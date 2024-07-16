import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class TextFieldView extends StatelessWidget {
  const TextFieldView({
    super.key,
    required this.controller,
    required this.title,
    required this.iconData,
  });

  final TextEditingController controller;
  final String title;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      ignorePointers: true,
      style: GoogleFonts.inter(
        fontSize: 12.sp,
        color: Colors.white,
        fontWeight: FontWeight.w400,
      ),
      decoration: InputDecoration(
        labelText: title,
        labelStyle: GoogleFonts.inter(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: const Color.fromARGB(255, 234, 234, 235),
        ),
        hintText: title,
        prefixIcon: Icon(
          iconData,
          size: 20.sp,
          color: const Color.fromARGB(255, 234, 234, 235),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(20.0),
          ),
          borderSide: BorderSide(
            color: const Color.fromARGB(255, 112, 114, 118),
            width: 1.5.w,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(20.0),
          ),
          borderSide: BorderSide(
            color: const Color.fromARGB(255, 112, 114, 118),
            width: 1.5.w,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: 18.h,
          horizontal: 16.w,
        ),
      ),
    );
  }
}
