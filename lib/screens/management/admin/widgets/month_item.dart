import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mate_project/models/month.dart';

class MonthItem extends StatelessWidget {
  const MonthItem({
    super.key,
    required this.month,
    required this.onTap,
  });

  final Month month;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 50.w,
        padding: EdgeInsets.symmetric(
          vertical: 8.h,
        ),
        margin: EdgeInsets.only(
          right: 16.w,
        ),
        decoration: BoxDecoration(
          color: month.isSelected!
              ? const Color.fromARGB(255, 84, 110, 255)
              : const Color.fromARGB(255, 55, 58, 63),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              month.monthName.toString(),
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
