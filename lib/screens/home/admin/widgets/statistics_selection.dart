import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';

class StatisticsSelection extends StatelessWidget {
  const StatisticsSelection({
    super.key,
    required this.amount,
    required this.title,
  });

  final String title;
  final String amount;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 135.w,
      height: 100.h,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 56, 59, 64),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Container(
            width: 115.w,
            height: 100.h,
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 16.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "\$",
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      width: 4.w,
                    ),
                    Flexible(
                      child: Text(
                        amount,
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Container(
            width: 20.w,
            height: 100.h,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 118, 141, 255),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
            ),
            child: Center(
              child: Icon(
                IconlyLight.arrow_right_2,
                color: Colors.white,
                size: 13.sp,
              ),
            ),
          )
        ],
      ),
    );
  }
}
