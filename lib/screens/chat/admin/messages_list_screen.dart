import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mate_project/models/message.dart';
import 'package:mate_project/models/response/CustomerResponse.dart';
import 'package:mate_project/repositories/customer_repo.dart';
import 'package:mate_project/repositories/message_repo.dart';
import 'package:mate_project/screens/chat/admin/widgets/message_element.dart';
import 'package:mate_project/screens/chat/admin/widgets/search_field.dart';
import 'package:mate_project/screens/chat/chat_screen.dart';
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
  MessageRepository messageRepository = MessageRepository();
  CustomerRepository customerRepository = CustomerRepository();

  Future<List<Message>> getListMessgae() async {
    return await messageRepository.getListMessage();
  }

  @override
  void initState() {
    super.initState();
    getListMessgae().then(
      (value) {
        setState(() {
          messages = value;
        });
      },
    );
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
                return const AdminMainScreen(
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
                      onTap: () async {
                        CustomerResponse customerResponse =
                            await customerRepository.GetCustomerWithIdByAdmin(
                                customerId: e.customerId);
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return ChatScreen(
                                  isAdmin: true,
                                  customerResponse: customerResponse);
                            },
                          ),
                          (route) => false,
                        );
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
