import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mate_project/models/attendance.dart';

// ignore: must_be_immutable
class AttendanceDetails extends StatefulWidget {
  AttendanceDetails({
    super.key,
    required this.details,
    this.index,
  });

  final Attendance details;
  int? index;

  @override
  State<AttendanceDetails> createState() => _AttendanceDetailsState();
}

class _AttendanceDetailsState extends State<AttendanceDetails> {
  DateFormat formatter = DateFormat('dd MMMM');

  String? formattedDate;
  String? formattedDateTime;
  List<String> splittedDate = [];

  int hour = 0;
  int minute = 0;
  int second = 0;
  bool isWithinRange = true;

  @override
  void initState() {
    super.initState();
    formattedDate = formatter.format(widget.details.checkDate);
    splittedDate = formattedDate!.split(' ');
    hour = widget.details.checkDate.hour;
    minute = widget.details.checkDate.minute;
    second = widget.details.checkDate.second;
    isWithinRange = (hour >= 0 && hour <= 12) &&
        (minute >= 0 && minute < 60) &&
        (second >= 0 && second < 60);
  }

  @override
  Widget build(BuildContext context) {
    String attendanceStatus = "";
    Color attendanceColor = Colors.white;
    switch (widget.details.status) {
      case 1:
        attendanceStatus = "Attended";
        attendanceColor = const Color.fromARGB(255, 52, 168, 83);
        break;
      case 2:
        attendanceStatus = "Absent";
        attendanceColor = const Color.fromARGB(255, 234, 68, 53);
        break;
      case 3:
        attendanceStatus = "Not yet attended";
        attendanceColor = const Color.fromARGB(255, 251, 189, 5);
        break;
    }
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 8.w,
        vertical: 16.h,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              vertical: 16.h,
              horizontal: 8.w,
            ),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 243, 243, 243),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    splittedDate[0],
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color.fromARGB(255, 88, 88, 88),
                    ),
                  ),
                  Text(
                    splittedDate[1],
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: const Color.fromARGB(255, 88, 88, 88),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 16.w,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isWithinRange ? "Morning attendance" : "Evening attendance",
                style: GoogleFonts.inter(
                  color: const Color.fromARGB(255, 83, 83, 83),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 8.h,
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: 4.h,
                  horizontal: 8.w,
                ),
                decoration: BoxDecoration(
                  color: attendanceColor,
                  borderRadius: BorderRadius.circular(
                    50,
                  ),
                ),
                child: Text(
                  attendanceStatus,
                  style: GoogleFonts.inter(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
