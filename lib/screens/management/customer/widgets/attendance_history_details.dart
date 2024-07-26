import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:intl/intl.dart';
import 'package:mate_project/models/attendance.dart';
import 'package:url_launcher/url_launcher.dart';

class AttendanceHistoryDetails extends StatefulWidget {
  const AttendanceHistoryDetails({
    super.key,
    required this.details,
  });

  final Attendance details;

  @override
  State<AttendanceHistoryDetails> createState() =>
      _AttendanceHistoryDetailsState();
}

class _AttendanceHistoryDetailsState extends State<AttendanceHistoryDetails> {
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

  void _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (await canLaunch(launchUri.toString())) {
      await launch(launchUri.toString());
    } else {
      throw 'Could not launch $phoneNumber';
    }
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

    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 16.h,
          ),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 241, 244, 255),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    alignment: WrapAlignment.start,
                    crossAxisAlignment: WrapCrossAlignment.start,
                    spacing: 8.w,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 16.h,
                          horizontal: 8.w,
                        ),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 226, 223, 255),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                widget.details.checkDate.day.toString(),
                                style: GoogleFonts.inter(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  color: const Color.fromARGB(255, 25, 27, 33),
                                ),
                              ),
                              Text(
                                DateFormat.MMM()
                                    .format(widget.details.checkDate),
                                style: GoogleFonts.inter(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                  color: const Color.fromARGB(255, 25, 27, 33),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            isWithinRange
                                ? "Morning attendance"
                                : "Evening attendance",
                            style: GoogleFonts.inter(
                              fontSize: 14.sp,
                              color: const Color.fromARGB(255, 25, 27, 33),
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
                  CircleAvatar(
                    radius: 20.w,
                    // Lay thong tin Staff tu API
                    backgroundImage: widget.details.staff!.avatar == null
                        ? const AssetImage("assets/pics/nurse.png")
                        : NetworkImage(widget.details.staff!.avatar!),
                  ),
                ],
              ),
              SizedBox(
                height: 16.h,
              ),
              Container(
                height: 0.5.h,
                color: const Color.fromARGB(255, 202, 210, 255),
              ),
              SizedBox(
                height: 16.h,
              ),
              InkWell(
                onTap: () {
                  _makePhoneCall(widget.details.staff!.phoneNumber!);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      IconsaxPlusBold.call,
                      size: 20.sp,
                      color: const Color.fromARGB(255, 67, 90, 204),
                    ),
                    SizedBox(
                      width: 4.w,
                    ),
                    Text(
                      "Contact nurse",
                      style: GoogleFonts.inter(
                        color: const Color.fromARGB(255, 67, 90, 204),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.underline,
                        decorationColor: const Color.fromARGB(255, 67, 90, 204),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 8.h,
        ),
      ],
    );
  }
}
