import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AttendanceSelection extends StatefulWidget {
  const AttendanceSelection({
    super.key,
    required this.status,
    required this.sessionType,
    required this.onSelect,
  });

  final String status;
  final String sessionType;
  final void Function(String) onSelect;

  @override
  State<AttendanceSelection> createState() => _AttendanceSelectionState();
}

class _AttendanceSelectionState extends State<AttendanceSelection> {
  final List<String> attends = [
    "Present",
    "Absent",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: attends.map(
        (e) {
          String description = "";
          Color active = const Color.fromARGB(255, 237, 237, 237);

          if (widget.sessionType.compareTo("Morning") == 0) {
            if (attends.indexOf(e) == 0) {
              description =
                  "Ensure all members are present between 6:00 AM and 12:00 PM";
            } else {
              description = "Double-check before marking this member absent";
            }
          } else if (widget.sessionType.compareTo("Evening") == 0) {
            if (attends.indexOf(e) == 0) {
              description =
                  "Ensure all members are present between 1:00 PM and 9:00 PM";
            } else {
              description = "Double-check before marking this member absent";
            }
          }

          if (widget.status.compareTo(e) == 0) {
            if (attends.indexOf(e) == 0) {
              active = const Color.fromARGB(255, 214, 255, 225);
            } else {
              active = const Color.fromARGB(255, 255, 204, 200);
            }
          } else {
            active = const Color.fromARGB(255, 237, 237, 237);
          }

          return GestureDetector(
            onTap: () {
              widget.onSelect(e);
            },
            child: Column(
              children: [
                Container(
                  width: 360.w,
                  height: 81.h,
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  decoration: BoxDecoration(
                    color: active,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        e,
                        style: GoogleFonts.inter(
                          color: Colors.black,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Flexible(
                        child: Text(
                          description,
                          style: GoogleFonts.inter(
                            color: const Color.fromARGB(255, 35, 38, 47),
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w400,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 8.h,
                ),
              ],
            ),
          );
        },
      ).toList(),
    );
  }
}
