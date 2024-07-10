import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mate_project/data/project_data.dart';
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

  @override
  void initState() {
    super.initState();
    // Test data, lấy dữ liệu danh sách thông báo của staff từ database
    notifications = [
      News(
        avatar: "assets/pics/admin_avatar.png",
        title: "Mate system",
        description:
            'You are assigned to take care of the "Sunflower" room on July 26.',
        time: DateTime(2024, 7, 9, 3, 20),
        status: false,
      ),
      News(
        avatar: "assets/pics/admin_avatar.png",
        title: "Mate system",
        description:
            'You are assigned to take care of the "Sunflower" room on July 27.',
        time: DateTime(2024, 7, 9, 4, 20),
        status: false,
      ),
      News(
        avatar: "assets/pics/admin_avatar.png",
        title: "Mate system",
        description:
            'You are assigned to take care of the "Sunflower" room on July 28.',
        time: DateTime(2024, 7, 9, 4, 25),
        status: true,
      ),
      News(
        avatar: "assets/pics/admin_avatar.png",
        title: "Mate system",
        description:
            'You are assigned to take care of the "Sunflower" room today.',
        time: DateTime(2024, 7, 8, 4, 25),
        status: true,
      ),
      News(
        avatar: "assets/pics/admin_avatar.png",
        title: "Mate system",
        description:
            'You are assigned to take care of the "Sunflower" room today.',
        time: DateTime(2024, 7, 8, 4, 25),
        status: true,
      ),
      News(
        avatar: "assets/pics/admin_avatar.png",
        title: "Mate system",
        description:
            'You are assigned to take care of the "Sunflower" room today.',
        time: DateTime(2024, 7, 8, 4, 25),
        status: true,
      ),
      News(
        avatar: "assets/pics/admin_avatar.png",
        title: "Mate system",
        description:
            'You are assigned to take care of the "Sunflower" room today.',
        time: DateTime(2024, 7, 8, 4, 25),
        status: true,
      ),
      News(
        avatar: "assets/pics/admin_avatar.png",
        title: "Mate system",
        description:
            'You are assigned to take care of the "Sunflower" room today.',
        time: DateTime(2024, 7, 8, 4, 25),
        status: true,
      ),
      News(
        avatar: "assets/pics/admin_avatar.png",
        title: "Mate system",
        description:
            'You are assigned to take care of the "Sunflower" room today.',
        time: DateTime(2024, 7, 8, 4, 25),
        status: true,
      ),
    ];
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
                  onPressed: () {},
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
