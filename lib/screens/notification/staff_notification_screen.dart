import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mate_project/helper/sharedpreferenceshelper.dart';
import 'package:mate_project/models/news.dart';
import 'package:mate_project/screens/notification/widgets/notification_element.dart';
import 'package:mate_project/widgets/app_bar/normal_app_bar.dart';
import 'package:unicons/unicons.dart';

class StaffNotificationScreen extends StatefulWidget {
  const StaffNotificationScreen({super.key});

  @override
  State<StaffNotificationScreen> createState() =>
      _StaffNotificationScreenState();
}

class _StaffNotificationScreenState extends State<StaffNotificationScreen> {
  List<News> notifications = [];
  DatabaseReference? messagesRef;
  List<StreamSubscription> listStream = [];
  @override
  void dispose() {
    super.dispose();
    for (var element in listStream) {
      element.cancel();
    }
  }

  int staffId = 0;

  Future<int> getStaffId() async {
    staffId = (await SharedPreferencesHelper.getStaff())!.staffId;
    return staffId;
  }

  Future<void> markAllRead() async {
    DatabaseReference? messagesRef2;
    messagesRef2 =
        FirebaseDatabase.instance.ref().child('notifications/staff$staffId');
    for (var element in notifications) {
      if (element.status == false) {
        messagesRef2.child(element.id).child('isNew').set(false);
      }
    }
    for (int i = 0; i < notifications.length; i++) {
      if (notifications[i].status == false) {
        notifications[i].status = true;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getStaffId().then(
      (value) {
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
                notifications.add(news);
              });
            }
          }
        }));
      },
    );
  }

  bool isSameWeekAndDifferentDay(DateTime timeCheck) {
    DateTime currentWeekStart = DateTime.now().subtract(Duration(
        days: (DateTime.now().day - 1 + (DateTime.now().weekday == 1 ? 7 : 0)) %
            7));

    DateTime myDateTime = timeCheck.subtract(Duration(
        days: (timeCheck.day - 1 + (timeCheck.weekday == 1 ? 7 : 0)) % 7));

    bool isSameWeek = currentWeekStart.day == myDateTime.day;

    if (isSameWeek) {
      return timeCheck.day != DateTime.now().day;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    Future displayBottomSheet(BuildContext context) {
      return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 150.h,
            padding: EdgeInsets.symmetric(
              vertical: 8.h,
            ),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    markAllRead();
                  },
                  child: Text(
                    "Mark all as read",
                    style: GoogleFonts.inter(
                      color: const Color.fromARGB(255, 35, 38, 47),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(
                  height: 8.h,
                ),
                Container(
                  width: 360.w,
                  height: 0.5.h,
                  color: const Color.fromARGB(255, 189, 190, 191),
                ),
                SizedBox(
                  height: 8.h,
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "Clear all",
                    style: GoogleFonts.inter(
                      color: const Color.fromARGB(255, 234, 68, 53),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    }

    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: TNormalAppBar(
        title: "News",
        isBordered: true,
        isBack: false,
        action: IconButton(
          onPressed: () {
            displayBottomSheet(context);
          },
          style: const ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(
              Colors.transparent,
            ),
          ),
          icon: Icon(
            UniconsLine.ellipsis_v,
            size: 20.sp,
            color: const Color.fromARGB(255, 35, 47, 107),
          ),
        ),
      ),
      body: Container(
        width: 360.w,
        height: 710.h,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(
                  24.w,
                  16.h,
                  24.w,
                  8.h,
                ),
                child: Text(
                  "Today",
                  style: GoogleFonts.inter(
                    color: const Color.fromARGB(255, 35, 47, 107),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Column(
                children: notifications
                    .where((noti) => noti.time.day == DateTime.now().day)
                    .map(
                  (e) {
                    return NotificationElement(
                      news: e,
                      onRead: () {},
                    );
                  },
                ).toList(),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                  24.w,
                  16.h,
                  24.w,
                  8.h,
                ),
                child: Text(
                  "This week",
                  style: GoogleFonts.inter(
                    color: const Color.fromARGB(255, 35, 47, 107),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Column(
                children: notifications
                    .where((noti) => isSameWeekAndDifferentDay(noti.time))
                    .map(
                  (e) {
                    return NotificationElement(
                      news: e,
                      onRead: () {},
                    );
                  },
                ).toList(),
              ),
              SizedBox(
                height: 150.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
