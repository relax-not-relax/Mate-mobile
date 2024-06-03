import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class DisabledButtonCustom extends StatelessWidget {
  const DisabledButtonCustom({
    super.key,
    required this.name,
  });

  final String name;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: null,
      style: ButtonStyle(
        fixedSize: WidgetStatePropertyAll(
          Size(360.w, 59.h),
        ),
        backgroundColor: const WidgetStatePropertyAll(
          Color.fromARGB(255, 183, 183, 183),
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
            color: const Color.fromARGB(255, 226, 226, 226),
          ),
        ),
      ),
    );
  }
}
