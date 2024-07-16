import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class NoteView extends StatelessWidget {
  const NoteView({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 360.w,
      height: 200.h,
      child: TextFormField(
        controller: controller,
        ignorePointers: true,
        style: GoogleFonts.inter(
          fontSize: 12.sp,
          color: Colors.white,
          fontWeight: FontWeight.w400,
        ),
        maxLines: null,
        expands: true,
        decoration: InputDecoration(
          labelText: "Note",
          labelStyle: GoogleFonts.inter(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: const Color.fromARGB(255, 234, 234, 235),
          ),
          hintText: "Note",
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(20.0),
            ),
            borderSide: BorderSide(
              color: const Color.fromARGB(255, 112, 114, 118),
              width: 1.5.w,
            ),
          ),
          contentPadding: EdgeInsets.symmetric(
            vertical: 16.h,
            horizontal: 16.w,
          ),
        ),
      ),
    );
  }
}
