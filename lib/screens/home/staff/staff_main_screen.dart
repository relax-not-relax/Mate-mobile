import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:iconly/iconly.dart';
import 'package:mate_project/helper/sharedpreferenceshelper.dart';
import 'package:mate_project/models/news.dart';
import 'package:mate_project/screens/home/staff/staff_home_screen.dart';
import 'package:mate_project/screens/management/staff/staff_schedule_screen.dart';
import 'package:mate_project/screens/notification/staff_notification_screen.dart';
import 'package:mate_project/screens/profile_management/staff/staff_account_main_screen.dart';

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
  DatabaseReference? messagesRef;
  List<StreamSubscription> listStream = [];
  int newNumber = 0;

  Future<int> getStaffId() async {
    int staffId = (await SharedPreferencesHelper.getStaff())!.staffId;
    return staffId;
  }

  @override
  void initState() {
    super.initState();
    _selectedPageIndex = widget.screenIndex;
    getStaffId().then(
      (value) {
        List<News> notifications = [];
        messagesRef =
            FirebaseDatabase.instance.ref().child('notifications/staff$value');
        listStream.add(messagesRef!.onChildAdded.listen((event) {
          if (event.snapshot.value != null) {
            News news = News(
              id: event.snapshot.key ?? "",
              avatar: "assets/pics/admin_avatar.png",
              title: event.snapshot.child('title').value.toString(),
              description: event.snapshot.child('content').value.toString(),
              time:
                  DateTime.parse(event.snapshot.child('time').value.toString()),
              status:
                  !bool.parse(event.snapshot.child('isNew').value.toString()),
            );
            if (mounted) {
              setState(() {
                newNumber =
                    notifications.where((e) => e.status == false).length;
              });
            }
          }
        }));
      },
    );
  }

  void _selectPage(int index) {
    if (mounted)
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
        activePage = StaffNotificationScreen();
        break;
      case 2:
        activePage = StaffScheduleScreen();
        break;
      case 3:
        activePage = StaffAccountMainScreen();
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
          selectedIndex: _selectedPageIndex,
          tabs: [
            const GButton(
              icon: IconlyBold.home,
              text: "Home",
            ),
            GButton(
              icon: IconlyBold.notification,
              leading: Badge(
                isLabelVisible: newNumber > 0,
                backgroundColor: const Color.fromARGB(255, 84, 110, 255),
                label: Text(
                  newNumber.toString(),
                  style: GoogleFonts.inter(
                    color: Colors.white,
                  ),
                ),
                child: const Icon(
                  IconlyBold.notification,
                  color: Colors.white,
                ),
              ),
              text: "News",
            ),
            const GButton(
              icon: IconlyBold.calendar,
              text: "Assign",
            ),
            const GButton(
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
