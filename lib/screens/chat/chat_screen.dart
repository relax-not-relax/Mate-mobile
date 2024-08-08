import 'dart:async';
import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:mate_project/helper/realtime_helper.dart';
import 'package:mate_project/models/admin.dart';
import 'package:mate_project/models/chat.dart';
import 'package:mate_project/models/chat_message.dart';
import 'package:mate_project/models/message.dart';
import 'package:mate_project/models/response/CustomerResponse.dart';
import 'package:mate_project/screens/chat/admin/messages_list_screen.dart';
import 'package:mate_project/screens/chat/widgets/chat_details.dart';
import 'package:mate_project/screens/chat/widgets/chat_text_field.dart';
import 'package:mate_project/screens/chat/widgets/conversation.dart';
import 'package:mate_project/screens/chat/widgets/first_chat.dart';
import 'package:mate_project/screens/home/customer/home_screen.dart';
import 'package:mate_project/screens/home/customer/main_screen.dart';
import 'package:mate_project/widgets/app_bar/normal_app_bar.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen(
      {super.key, required this.isAdmin, required this.customerResponse});
  final bool isAdmin;
  final CustomerResponse customerResponse;

  @override
  State<ChatScreen> createState() =>
      _ChatScreenState(customerRespone: customerResponse);
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  Widget? content;
  CustomerResponse customerRespone;
  _ChatScreenState({required this.customerRespone});
  final data = ValueNotifier<List<Chat>>([]);
  DatabaseReference? messagesRef;
  List<StreamSubscription> listStream = [];
  final FocusNode _focusNode = FocusNode();

  void _dismissKeyboard() {
    FocusScope.of(context).unfocus(); // This will dismiss the keyboard
  }

  String askChat = "";
  bool isApart(DateTime first, DateTime second) {
    // Tính chênh lệch thời gian giữa hai DateTime
    Duration difference = first.difference(second).abs();
    return difference.inMinutes >= 3;
  }

  @override
  void initState() {
    super.initState();
    messagesRef = FirebaseDatabase.instance
        .ref()
        .child('chats/customer${customerRespone.customerId}');
    _controller.text = "";
    //Widget này sẽ được hiển thị khi người dùng lần đầu tiên nhắn tin với hệ thống Mate
    content = FirstChat(
      ask: askChoice,
    );
    if (widget.isAdmin) {
      data.value.add(
        Chat(
            avatar: widget.customerResponse.avatar ?? "",
            text: "",
            id_1: 1,
            id_2: 2,
            isShowAvatar: false,
            time: DateTime(1999, 1, 1, 0, 0, 0)),
      );
    }
    listStream.add(messagesRef!.onChildAdded.listen((event) {
      if (event.snapshot.value != null &&
          event.snapshot.child('isAdmin').value == false) {
        bool showAvata = true;
        if (data.value.isNotEmpty &&
            data.value.last.id_1 == (widget.isAdmin ? 2 : 1)) showAvata = false;
        if (data.value.isNotEmpty &&
            isApart(
                DateTime.parse(event.snapshot.child('time').value.toString()),
                data.value.last.time)) {
          showAvata = true;
        }
        if (data.value.isNotEmpty) {
          print(DateTime.parse(event.snapshot.child('time').value.toString()));
          print(data.value.last.time.toString());
        }

        {
          if (mounted) {
            setState(() {
              data.value.add(
                Chat(
                    avatar: widget.customerResponse.avatar ?? "",
                    text: event.snapshot.child('lastMessage').value.toString(),
                    id_1: widget.isAdmin ? 2 : 1,
                    id_2: widget.isAdmin ? 1 : 2,
                    isShowAvatar: showAvata,
                    time: DateTime.parse(
                        event.snapshot.child('time').value.toString())),
              );
              content = Conversation(
                messages: data.value,
                ask: askChoice,
              );
            });
          }
        }
      }
      if (event.snapshot.value != null &&
          event.snapshot.child('isAdmin').value == true) {
        bool showAvata = true;
        if (data.value.isNotEmpty &&
            data.value.last.id_1 == (widget.isAdmin ? 1 : 2)) {
          showAvata = false;
        }
        if (data.value.isNotEmpty &&
            isApart(
                DateTime.parse(event.snapshot.child('time').value.toString()),
                data.value.last.time)) showAvata = true;
        {
          if (mounted) {
            setState(() {
              data.value.add(
                Chat(
                    avatar: "assets/pics/admin_avatar.png",
                    text: event.snapshot.child('lastMessage').value.toString(),
                    id_1: widget.isAdmin ? 1 : 2,
                    id_2: widget.isAdmin ? 2 : 1,
                    isShowAvatar: showAvata,
                    time: DateTime.parse(
                        event.snapshot.child('time').value.toString())),
              );
              content = Conversation(
                messages: data.value,
                ask: askChoice,
              );
            });
          }
        }
      }
    }));
  }

  @override
  void dispose() {
    super.dispose();
    for (var element in listStream) {
      element.cancel();
      print("oke");
    }
  }

  void askChoice(String question) {
    if (mounted) {
      String answer = "";
      switch (question) {
        case "Room-specific pricing policies?":
          answer =
              'Hello, our Pricing policies will depend on the types of services and rooms you want. Here are some services we provide:\n\nGold: \$289\n\nSilver: \$199\n\nBronze: \$99\n\nCome and join us today!';
          break;
        case "Some benefits for gold, silver and bronze room?":
          answer =
              "Gold: \n- single room\n- Service available: Massage, Assistance in organizing special events in special occasions \n- TV available in the room\n- High - quality dishes (buffet)\n- Take attendance 3 times/day\n\nSilver:\n- Phòng đôi/n- services available: Massage, Assist in organizing the special events in the special occasion/n- TV available/n- Delicious food \n- Take attendance 3 times/day\n\nBronze:\n- Take attendance 3 times/day\n- phòng 3-5 người\n- Good food\n- TV available\n\nIt’s our pleasure to provide these services for you! Enjoy your “youth” here.";
          break;
        case "Types of rooms do you have for gold, silver, bronze?":
          answer =
              "Heyy,.. We do have different kind of rooms for Gold, Silver, Bronze\n\nGold:\n“Sunflower”\n“Lily”\n\nSilver:\n“New Zone”\n“New World”\n\nBronzes\n“Soulmate”\n“F4 plus”";
          break;
        case "Frequency of music concert organization?":
          answer =
              "Howdy, friends! That’s a good question though. We often have a music concert annually. This activities will be contributed by the elder to a larger community. We are gonna send out the invitation a month before the concert starts! Remember to check the information daily on our Fanpage!";
          break;
      }
      setState(() {
        data.value.add(
          Chat(
              avatar: customerRespone.avatar ?? "",
              text: question,
              id_1: 1,
              id_2: 2,
              isShowAvatar: true,
              time: DateTime.now()),
        );

        data.value.add(
          Chat(
              avatar: "assets/pics/admin_avatar.png",
              text: answer,
              id_1: 2,
              id_2: 1,
              isShowAvatar: true,
              time: DateTime.now()),
        );

        content = Conversation(
          messages: data.value,
          ask: askChoice,
        );
      });
    }
  }

  void addChat(String chat) {
    if (chat.isEmpty || chat.trim().isEmpty) return;

    if (mounted) {
      setState(() {
        _controller.clear();
        content = Conversation(
          messages: data.value,
          ask: askChoice,
        );
      });
    }
    Message chatMessage = Message(
        time: DateTime.now(),
        name: widget.customerResponse.fullname,
        avatar: widget.customerResponse.avatar ?? "",
        isAdmin: widget.isAdmin,
        lastMessage: chat,
        customerId: widget.customerResponse.customerId);
    RealTimeHelper.sendMessage(chatMessage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 250, 250, 250),
      extendBodyBehindAppBar: false,
      appBar: TNormalAppBar(
        title: "Mate's Assistant",
        isBordered: true,
        isBack: true,
        back: () {
          if (widget.isAdmin) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return MessagesListScreen();
                },
              ),
              (route) => false,
            );
          } else {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return MainScreen(
                    inputScreen: HomeScreen(),
                    screenIndex: 0,
                    customerResponse: widget.customerResponse,
                  );
                },
              ),
              (route) => false,
            );
          }
        },
      ),
      body: Stack(
        children: [
          Positioned(
            top: 16.h,
            left: 0,
            right: 0,
            child: content ?? Container(),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              width: 360.w,
              padding: EdgeInsets.symmetric(
                horizontal: 24.w,
                vertical: 24.h,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(38, 20, 19, 19),
                    blurRadius: 32,
                    offset: Offset(0, 12),
                  )
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 258.w,
                        height: 50.h,
                        child: ChatTextField(
                          controller: _controller,
                          focusNode: _focusNode,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          addChat(_controller.text);
                          _dismissKeyboard();
                        },
                        style: ButtonStyle(
                          backgroundColor: const WidgetStatePropertyAll(
                            Color.fromARGB(255, 63, 82, 191),
                          ),
                          padding: WidgetStatePropertyAll(
                            EdgeInsets.all(8.w),
                          ),
                        ),
                        icon: Icon(
                          IconsaxPlusBold.send_2,
                          size: 24.sp,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
