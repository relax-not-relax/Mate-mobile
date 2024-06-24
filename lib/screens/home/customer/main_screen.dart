import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:iconly/iconly.dart';
import 'package:mate_project/models/room.dart';
import 'package:mate_project/screens/chat/chat_screen.dart';
import 'package:mate_project/screens/home/customer/home_screen.dart';
import 'package:mate_project/screens/management/customer/my_room_screen.dart';
import 'package:mate_project/screens/profile_management/customer/account_main_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({
    super.key,
    required this.inputScreen,
    required this.screenIndex,
  });

  final Widget inputScreen;
  final int screenIndex;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _selectedPageIndex = widget.screenIndex;
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = widget.inputScreen;

    switch (_selectedPageIndex) {
      case 0:
        activePage = HomeScreen();
        break;
      case 1:
        activePage = ChatScreen();
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
        activePage = AccountMainScreen();
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
          tabs: const [
            GButton(
              icon: IconlyBold.home,
              text: "Home",
            ),
            GButton(
              icon: IconlyBold.chat,
              text: "Chat",
            ),
            GButton(
              icon: IconlyBold.calendar,
              text: "Schedule",
            ),
            GButton(
              icon: IconlyBold.user_2,
              leading: CircleAvatar(
                backgroundImage: AssetImage("assets/pics/user_test.png"),
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
