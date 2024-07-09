import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:unicons/unicons.dart';

class RoomAssigned extends StatefulWidget {
  const RoomAssigned({super.key});

  @override
  State<RoomAssigned> createState() => _RoomAssignedState();
}

class _RoomAssignedState extends State<RoomAssigned> {
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
      width: 360.w,
      height: 244.h,
      margin: EdgeInsets.symmetric(
        horizontal: 24.w,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 24.h,
      ),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 41, 45, 50),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "May 27, 2024",
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: 24.h,
              ),
              Text(
                "“Sunflower” Room",
                style: GoogleFonts.inter(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              Wrap(
                alignment: WrapAlignment.start,
                crossAxisAlignment: WrapCrossAlignment.start,
                children: [
                  Text(
                    "10 rooms",
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color.fromARGB(255, 118, 141, 255),
                    ),
                  ),
                  Icon(
                    UniconsLine.angle_double_right,
                    size: 24.sp,
                    color: const Color.fromARGB(255, 118, 141, 255),
                  ),
                ],
              )
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 84, 87, 91),
                  borderRadius: BorderRadius.circular(30.w),
                ),
                child: Center(
                  child: Wrap(
                    alignment: WrapAlignment.spaceEvenly,
                    crossAxisAlignment: WrapCrossAlignment.center,
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
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 8.w,
              ),

              // Used when the room has not been attended yet
              // Container(
              //   padding:
              //       EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
              //   decoration: BoxDecoration(
              //     color: const Color.fromARGB(80, 250, 101, 88),
              //     borderRadius: BorderRadius.circular(30.w),
              //   ),
              //   child: Center(
              //     child: Wrap(
              //       alignment: WrapAlignment.spaceEvenly,
              //       crossAxisAlignment: WrapCrossAlignment.center,
              //       spacing: 4.w,
              //       children: [
              //         Icon(
              //           UniconsLine.file_exclamation,
              //           color: const Color.fromARGB(255, 218, 92, 83),
              //           size: 16.sp,
              //         ),
              //         Text(
              //           "Waiting to be counted",
              //           style: GoogleFonts.inter(
              //             color: const Color.fromARGB(255, 218, 92, 83),
              //             fontSize: 12.sp,
              //             fontWeight: FontWeight.w500,
              //           ),
              //           overflow: TextOverflow.ellipsis,
              //           maxLines: 1,
              //         )
              //       ],
              //     ),
              //   ),
              // ),

              // Used when the room is attended
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(77, 105, 212, 133),
                  borderRadius: BorderRadius.circular(30.w),
                ),
                child: Center(
                  child: Wrap(
                    alignment: WrapAlignment.spaceEvenly,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 4.w,
                    children: [
                      Icon(
                        UniconsLine.file_exclamation,
                        color: const Color.fromARGB(255, 52, 168, 83),
                        size: 16.sp,
                      ),
                      Text(
                        "Attended",
                        style: GoogleFonts.inter(
                          color: const Color.fromARGB(255, 52, 168, 83),
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      )
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
