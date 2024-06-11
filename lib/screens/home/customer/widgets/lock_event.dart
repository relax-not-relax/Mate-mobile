import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';

class LockEvent extends StatelessWidget {
  const LockEvent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 360.w,
      height: 140.h,
      padding: EdgeInsets.symmetric(
        horizontal: 24.w,
      ),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 243, 243, 243),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              IconlyBold.lock,
              color: Color.fromARGB(255, 108, 110, 116),
            ),
            SizedBox(
              width: 8.w,
            ),
            Flexible(
              child: Text(
                "Become a member to view this content",
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.inter(
                  color: const Color.fromARGB(255, 154, 155, 159),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
