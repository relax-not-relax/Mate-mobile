import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mate_project/data/project_data.dart';
import 'package:mate_project/models/attendance_type.dart';

class AttendanceOfDay extends StatefulWidget {
  const AttendanceOfDay({
    super.key,
    required this.aType,
    required this.onChoose,
  });

  final AttendanceType aType;
  final void Function(AttendanceType) onChoose;

  @override
  State<AttendanceOfDay> createState() => _AttendanceOfDayState();
}

class _AttendanceOfDayState extends State<AttendanceOfDay> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 360.w,
      height: 65.h,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: ProjectData.attendanceType.map(
          (e) {
            return GestureDetector(
              onTap: () {
                widget.onChoose(e);
              },
              child: Container(
                width: 148.w,
                height: 65.h,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                decoration: BoxDecoration(
                  color: widget.aType == e
                      ? const Color.fromARGB(255, 84, 110, 255)
                      : const Color.fromARGB(255, 55, 58, 63),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      e.icon,
                      size: 24.w,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            e.session,
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Flexible(
                            child: Text(
                              "Take attendance",
                              style: GoogleFonts.inter(
                                color: widget.aType == e
                                    ? Colors.white
                                    : const Color.fromARGB(255, 187, 188, 191),
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w400,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ).toList(),
      ),
    );
  }
}
