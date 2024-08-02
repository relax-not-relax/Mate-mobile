import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';

class AccountEditDateField extends StatefulWidget {
  const AccountEditDateField({
    super.key,
    required this.controller,
    required this.title,
    this.errorText,
    required this.initBirthday,
    this.titleColor,
    //required this.onDateChanged,
  });

  final TextEditingController controller;
  final String initBirthday;
  final String title;
  final String? errorText;
  final Color? titleColor;
  //final void Function(String) onDateChanged;

  @override
  State<AccountEditDateField> createState() => _AccountEditDateFieldState();
}

class _AccountEditDateFieldState extends State<AccountEditDateField> {
  void updateDate() async {
    FocusScope.of(context).unfocus();
    final DateTime? datePicker = await showDatePicker(
      context: context,
      initialDate: DateFormat('dd/MM/yyyy').parse(widget.initBirthday),
      firstDate: DateTime(1900),
      lastDate: DateTime(3000),
    );
    if (datePicker != null) {
      widget.controller.text = DateFormat('dd/MM/yyyy').format(datePicker);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: updateDate,
      child: TextFormField(
        controller: widget.controller,
        ignorePointers: true,
        style: GoogleFonts.inter(
          fontSize: 12.sp,
          color: widget.titleColor ?? const Color.fromARGB(255, 108, 110, 116),
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          labelText: widget.title,
          labelStyle: GoogleFonts.inter(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: widget.titleColor ?? const Color.fromARGB(255, 67, 90, 204),
          ),
          hintText: widget.title,
          prefixIcon: Icon(
            IconlyBold.calendar,
            size: 20.sp,
            color: widget.titleColor ?? const Color.fromARGB(255, 67, 90, 204),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(20.0),
            ),
            borderSide: BorderSide(
              color:
                  widget.titleColor ?? const Color.fromARGB(255, 148, 141, 246),
              width: 1.5.w,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(20.0),
            ),
            borderSide: BorderSide(
              color:
                  widget.titleColor ?? const Color.fromARGB(255, 148, 141, 246),
              width: 1.5.w,
            ),
          ),
          errorText: widget.errorText,
          errorMaxLines: 2,
          contentPadding: EdgeInsets.symmetric(
            vertical: 18.h,
            horizontal: 16.w,
          ),
        ),
      ),
    );
  }
}
