import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class NormalButtonCustom extends StatelessWidget {
  const NormalButtonCustom({
    super.key,
    required this.name,
    required this.action,
    required this.background,
  });

  final String name;
  final void Function() action;
  final Color background;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: action,
      style: ButtonStyle(
        fixedSize: WidgetStatePropertyAll(
          Size(360.w, 59.h),
        ),
        backgroundColor: WidgetStatePropertyAll(
          background,
        ),
        elevation: const WidgetStatePropertyAll(0),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      child: Center(
        child: Text(
          name,
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
