import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mate_project/models/message.dart';
import 'package:mate_project/screens/chat/admin/widgets/message_element.dart';
import 'package:mate_project/screens/chat/admin/widgets/search_field.dart';
import 'package:mate_project/screens/home/admin/admin_home_screen.dart';
import 'package:mate_project/screens/home/admin/admin_main_screen.dart';
import 'package:mate_project/widgets/app_bar/normal_app_bar.dart';

class MessagesListScreen extends StatefulWidget {
  const MessagesListScreen({super.key});

  @override
  State<MessagesListScreen> createState() => _MessagesListScreenState();
}

class _MessagesListScreenState extends State<MessagesListScreen> {
  TextEditingController _controller = TextEditingController();
  //Test data (Thay đổi khi call API để lấy dữ liệu)
  List<Message> messages = [];

  @override
  void initState() {
    super.initState();
    messages = [
      // Với những tin nhắn chưa được đọc status sẽ là false, update thành true khi nhấn vào tin nhắn
      // Note: Nhớ check tin nhắn cuối cùng là của khách hàng hay là admin
      Message(
        avatar: "assets/pics/user_test_1.png",
        name: "James Hill",
        lastMessage: "Hello, I need some help!",
        time: DateTime(2024, 7, 16, 9, 30),
        isAdmin: false,
        status: false,
      ),
      // Đây là trường hợp đã đọc
      Message(
        avatar: "assets/pics/user_test_2.png",
        name: "Phuong Nguyen",
        lastMessage: "Ok, got it!",
        time: DateTime(2024, 7, 15, 9, 30),
        isAdmin: false,
        status: true,
      ),
      // Đây là trường hợp tin nhắn cuối cùng là của admin
      Message(
        avatar: "assets/pics/user_test_3.png",
        name: "Thomas Le",
        lastMessage: "Oke, Have a nice day mate!",
        time: DateTime(2024, 7, 15, 9, 20),
        isAdmin: true,
        status: true,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      backgroundColor: const Color.fromARGB(255, 15, 16, 20),
      appBar: TNormalAppBar(
        title: "Messages",
        isBordered: false,
        isBack: true,
        back: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) {
                return AdminMainScreen(
                  inputScreen: AdminHomeScreen(),
                  screenIndex: 0,
                );
              },
            ),
          );
        },
        bgColor: const Color.fromARGB(255, 15, 16, 20),
        titleColor: Colors.white,
      ),
      body: Container(
        width: 360.w,
        height: 710.h,
        padding: EdgeInsets.symmetric(
          horizontal: 24.w,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SearchField(
                controller: _controller,
                search: (p0) {},
              ),
              SizedBox(
                height: 24.h,
              ),
              Text(
                "All chats",
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 16.h,
              ),
              Column(
                children: messages.map(
                  (e) {
                    return MessageElement(
                      element: e,
                      onTap: () {
                        setState(() {
                          e.status = true;
                        });
                      },
                    );
                  },
                ).toList(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
