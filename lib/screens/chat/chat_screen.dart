import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:mate_project/models/chat.dart';
import 'package:mate_project/screens/chat/widgets/chat_details.dart';
import 'package:mate_project/screens/chat/widgets/chat_text_field.dart';
import 'package:mate_project/screens/chat/widgets/conversation.dart';
import 'package:mate_project/screens/chat/widgets/first_chat.dart';
import 'package:mate_project/widgets/app_bar/normal_app_bar.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  Widget? content;
  final data = ValueNotifier<List<Chat>>([]);

  String askChat = "";

  @override
  void initState() {
    super.initState();
    _controller.text = "";
    //Widget này sẽ được hiển thị khi người dùng lần đầu tiên nhắn tin với hệ thống Mate
    content = FirstChat(
      ask: askChoice,
    );
  }

  void askChoice(String question) {
    setState(() {
      data.value.add(
        Chat(
          avatar: "assets/pics/user_test.png",
          text: question,
          id_1: 1,
          id_2: 2,
          isShowAvatar: true,
        ),
      );

      // data.value.add(
      //   Chat(
      //     avatar: "assets/pics/admin_avatar.png",
      //     text:
      //         "Howdy, friends! That’s a good question though. We often have a music concert annually. This activities will be contributed by the elder to a larger community. We are gonna send out the invitation a month before the concert starts! Remember to check the information daily on our Fanpage!",
      //     id_1: 2,
      //     id_2: 1,
      //     isShowAvatar: true,
      //   ),
      // );

      content = Conversation(
        messages: data.value,
        ask: askChoice,
      );
    });
  }

  void addChat(String chat) {
    if (chat.isEmpty || chat.trim().isEmpty) return;
    setState(() {
      data.value.add(
        Chat(
          avatar: "assets/pics/user_test.png",
          text: chat,
          id_1: 1,
          id_2: 2,
          isShowAvatar: false,
        ),
      );

      // data.value.add(
      //   Chat(
      //     avatar: "assets/pics/admin_avatar.png",
      //     text: "You're welcome!",
      //     id_1: 2,
      //     id_2: 1,
      //     isShowAvatar: true,
      //   ),
      // );

      _controller.clear();
      content = Conversation(
        messages: data.value,
        ask: askChoice,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 250, 250, 250),
      extendBodyBehindAppBar: false,
      appBar: const TNormalAppBar(
        title: "Mate's Assistant",
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
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          addChat(_controller.text);
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
