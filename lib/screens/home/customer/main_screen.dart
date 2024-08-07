import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:iconly/iconly.dart';
import 'package:mate_project/models/response/CustomerResponse.dart';
import 'package:mate_project/models/room.dart';
import 'package:mate_project/screens/chat/chat_screen.dart';
import 'package:mate_project/screens/home/customer/home_screen.dart';
import 'package:mate_project/screens/management/customer/my_room_screen.dart';
import 'package:mate_project/screens/profile_management/customer/customer_account_main_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({
    super.key,
    required this.inputScreen,
    required this.screenIndex,
    required this.customerResponse,
  });

  final Widget inputScreen;
  final int screenIndex;
  final CustomerResponse customerResponse;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedPageIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _selectedPageIndex = widget.screenIndex;
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   if (_selectedPageIndex == 1) {
    //     Navigator.pushReplacement(
    //       context,
    //       MaterialPageRoute(
    //         builder: (context) {
    //           return ChatScreen(
    //             isAdmin: false,
    //             customerResponse: widget.customerResponse,
    //           );
    //         },
    //       ),
    //     );
    //   }
    // });
  }

  void _selectPage(int index) {
    if (!mounted) return;

    if (mounted)
      setState(() {
        _selectedPageIndex = index;
      });

    if (index == 1) {
      Future.delayed(Duration(seconds: 1)).then(
        (value) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) {
                return ChatScreen(
                  isAdmin: false,
                  customerResponse: widget.customerResponse,
                );
              },
            ),
            (route) => false,
          );
        },
      );

      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) {
      //       return ChatScreen(
      //         isAdmin: false,
      //         customerResponse: widget.customerResponse,
      //       );
      //     },
      //   ),
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = widget.inputScreen;

    switch (_selectedPageIndex) {
      case 0:
        activePage = HomeScreen();
        break;
      case 2:
        activePage = MyRoomScreen(
          myRoom: Room(
            roomId: 1,
            managerId: 1,
            roomName: "“Sunflower” Room",
          ),
        );
        break;
      case 3:
        activePage = CustomerAccountMainScreen();
        break;
    }

    return Scaffold(
      body: activePage,
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 16.h,
        ),
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 15, 16, 20),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        child: GNav(
          backgroundColor: const Color.fromARGB(255, 15, 16, 20),
          color: Colors.white,
          activeColor: Colors.white,
          tabBackgroundColor: const Color.fromARGB(255, 35, 38, 47),
          gap: 8.w,
          padding: EdgeInsets.all(16.w),
          onTabChange: (value) {
            _selectPage(value);
          },
          selectedIndex: _selectedPageIndex,
          tabs: [
            const GButton(
              icon: IconlyBold.home,
              text: "Home",
            ),
            const GButton(
              icon: IconlyBold.chat,
              text: "Chat",
            ),
            const GButton(
              icon: IconlyBold.calendar,
              text: "Schedule",
            ),
            GButton(
              icon: IconlyBold.user_2,
              leading: CircleAvatar(
                backgroundImage: (widget.customerResponse.avatar != null &&
                        widget.customerResponse.avatar!.isNotEmpty)
                    ? NetworkImage(widget.customerResponse.avatar!)
                    : AssetImage("assets/pics/user_test.png"),
                radius: 16,
              ),
              text: "Account",
            ),
          ],
        ),
      ),
    );
  }
}
