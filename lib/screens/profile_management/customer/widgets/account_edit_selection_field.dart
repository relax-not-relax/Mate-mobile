import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class AccountEditSelectionField extends StatefulWidget {
  AccountEditSelectionField({
    super.key,
    required this.controller,
    required this.onPressed,
    required this.title,
    required this.iconData,
  });

  final TextEditingController controller;
  final void Function() onPressed;
  final String title;
  final IconData iconData;

  @override
  State<AccountEditSelectionField> createState() =>
      _AccountEditSelectionFieldState();
}

class _AccountEditSelectionFieldState extends State<AccountEditSelectionField> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: TextFormField(
        controller: widget.controller,
        ignorePointers: true,
        style: GoogleFonts.inter(
          fontSize: 12.sp,
          color: const Color.fromARGB(255, 108, 110, 116),
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          labelText: widget.title,
          labelStyle: GoogleFonts.inter(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: const Color.fromARGB(255, 67, 90, 204),
          ),
          hintText: widget.title,
          prefixIcon: Icon(
            widget.iconData,
            size: 20.sp,
            color: const Color.fromARGB(255, 67, 90, 204),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(20.0),
            ),
            borderSide: BorderSide(
              color: const Color.fromARGB(255, 148, 141, 246),
              width: 1.5.w,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(20.0),
            ),
            borderSide: BorderSide(
              color: const Color.fromARGB(255, 148, 141, 246),
              width: 1.5.w,
            ),
          ),
          contentPadding: EdgeInsets.symmetric(
            vertical: 18.h,
            horizontal: 16.w,
          ),
        ),
      ),
    );
  }
}
