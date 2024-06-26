import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AccountEditTextField extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  AccountEditTextField({
    super.key,
    required this.controller,
    this.borderColor,
    this.errorText,
    required this.iconData,
    required this.type,
    required this.title,
    this.onSubmitted,
  });

  final TextEditingController controller;
  final String? errorText;
  final Color? borderColor;
  final IconData iconData;
  final TextInputType type;
  final String title;
  final void Function(String)? onSubmitted;

  @override
  State<AccountEditTextField> createState() => _AccountEditTextFieldState();
}

class _AccountEditTextFieldState extends State<AccountEditTextField> {
  late FocusNode _focusNode;
  late Color textColor;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    textColor = const Color.fromARGB(255, 108, 110, 116);

    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        setState(() {
          textColor = Colors.black;
        });
      } else {
        setState(() {
          textColor = const Color.fromARGB(255, 108, 110, 116);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.type,
      controller: widget.controller,
      onFieldSubmitted: widget.onSubmitted,
      onTapOutside: (event) {
        FocusScope.of(context).unfocus();
      },
      focusNode: _focusNode,
      style: GoogleFonts.inter(
        fontSize: 12.sp,
        color: textColor,
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
            color: widget.borderColor ?? Colors.white,
            width: 1.5.w,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(20.0),
          ),
          borderSide: BorderSide(
            color: widget.borderColor ?? Colors.white,
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
    );
  }
}
