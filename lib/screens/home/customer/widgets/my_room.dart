import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:mate_project/models/room.dart';

class MyRoom extends StatefulWidget {
  const MyRoom({
    super.key,
    required this.room,
  });

  final Room room;

  @override
  State<MyRoom> createState() => _MyRoomState();
}

class _MyRoomState extends State<MyRoom> {
  String _currentTime = '';
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    updateTime();
  }

  void updateTime() {
    setState(() {
      // Extract hours and minutes from current time
      String timeString = DateTime.now().toString().split(' ')[1];
      List<String> timeComponents = timeString.split(':');
      String hours = timeComponents[0];
      String minutes = timeComponents[1];

      // Format the time as "HH:mm"
      _currentTime =
          '${hours.padLeft(2, '0')}:$minutes'; // Pad hours to 2 digits
    });
    _timer = Timer(const Duration(seconds: 1), updateTime);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150.w,
      height: 160.w,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 35, 38, 47),
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(38, 20, 19, 19),
            spreadRadius: 0,
            blurRadius: 10,
            offset: Offset(0, 4), // changes position of shadow
          )
        ],
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 150.w * 0.8,
                  child: Text(
                    widget.room.roomName,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  "10 members",
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w300,
                  ),
                )
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 84, 87, 91),
                    borderRadius: BorderRadius.circular(7.w),
                  ),
                  child: Center(
                    child: Wrap(
                      alignment: WrapAlignment.spaceEvenly,
                      spacing: 4.w,
                      children: [
                        Icon(
                          IconlyLight.time_circle,
                          color: Colors.white,
                          size: 15.sp,
                        ),
                        Text(
                          _currentTime,
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                CircleAvatar(
                  backgroundImage: AssetImage("assets/pics/nurse.png"),
                  radius: 16.w,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
