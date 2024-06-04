import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class OutlineButtonCustom extends StatelessWidget {
  const OutlineButtonCustom({
    super.key,
    required this.name,
    required this.action,
    required this.selectionColor,
  });

  final String name;
  final void Function() action;
  final Color selectionColor;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: action,
      style: ButtonStyle(
        fixedSize: WidgetStatePropertyAll(
          Size(360.w, 59.h),
        ),
        elevation: const WidgetStatePropertyAll(0),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        side: WidgetStatePropertyAll(
          BorderSide(
            width: 2.w,
            color: selectionColor,
          ),
        ),
      ),
      child: Center(
        child: Text(
          name,
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: selectionColor,
          ),
        ),
      ),
    );
  }
}
