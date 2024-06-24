import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unicons/unicons.dart';

class AccountEditElement extends StatelessWidget {
  const AccountEditElement({
    super.key,
    required this.icon,
    required this.title,
    required this.choose,
  });

  final IconData icon;
  final String title;
  final void Function() choose;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: choose,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Wrap(
            alignment: WrapAlignment.start,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 16.w,
            children: [
              Icon(
                icon,
                size: 22.sp,
                color: const Color.fromARGB(255, 84, 87, 91),
              ),
              Text(
                title,
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color.fromARGB(255, 84, 87, 91),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              )
            ],
          ),
          Icon(
            UniconsLine.angle_right,
            size: 20.sp,
            color: const Color.fromARGB(255, 157, 158, 161),
          ),
        ],
      ),
    );
  }
}
