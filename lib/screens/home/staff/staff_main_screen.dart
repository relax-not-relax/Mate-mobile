import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:iconly/iconly.dart';
import 'package:mate_project/screens/home/staff/staff_home_screen.dart';

class StaffMainScreen extends StatefulWidget {
  const StaffMainScreen({
    super.key,
    required this.inputScreen,
    required this.screenIndex,
  });

  final Widget inputScreen;
  final int screenIndex;

  @override
  State<StaffMainScreen> createState() => _StaffMainScreenState();
}

class _StaffMainScreenState extends State<StaffMainScreen> {
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
        activePage = StaffHomeScreen();
        break;
      case 1:
        break;
      case 2:
        break;
      case 3:
        break;
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBody: true,
      body: activePage,
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 16.h,
        ),
        margin: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 32.h,
        ),
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 41, 45, 50),
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
        child: GNav(
          backgroundColor: Colors.transparent,
          color: Colors.white,
          textSize: 12.sp,
          activeColor: Colors.white,
          tabBackgroundColor: const Color.fromARGB(255, 127, 119, 245),
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
              icon: IconlyBold.notification,
              text: "News",
            ),
            GButton(
              icon: IconlyBold.calendar,
              text: "Assign",
            ),
            GButton(
              icon: IconlyBold.user_2,
              leading: CircleAvatar(
                backgroundImage: AssetImage("assets/pics/nurse.png"),
                radius: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
