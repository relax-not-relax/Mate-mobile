import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class EditPassword extends StatefulWidget {
  const EditPassword({
    super.key,
    required this.controller,
    this.errorText,
    required this.borderColor,
    required this.title,
  });

  final TextEditingController controller;
  final String? errorText;
  final Color borderColor;
  final String title;

  @override
  State<EditPassword> createState() => _EditPasswordState();
}

class _EditPasswordState extends State<EditPassword> {
  late FocusNode _focusNode;
  late Color textColor;
  bool _isObscured = true;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    textColor = const Color.fromARGB(255, 108, 110, 116);

    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        if (mounted)
          setState(() {
            textColor = Colors.black;
          });
      } else {
        if (mounted)
          setState(() {
            textColor = const Color.fromARGB(255, 108, 110, 116);
          });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      onTapOutside: (event) {
        FocusScope.of(context).unfocus();
      },
      focusNode: _focusNode,
      obscureText: _isObscured,
      style: GoogleFonts.inter(
        fontSize: 12.sp,
        color: widget.errorText != null ? Colors.red : textColor,
        fontWeight: FontWeight.w400,
      ),
      decoration: InputDecoration(
        labelText: widget.title,
        labelStyle: GoogleFonts.inter(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: widget.errorText != null
              ? Colors.red
              : const Color.fromARGB(255, 67, 90, 204),
        ),
        hintText: widget.title,
        prefixIcon: Icon(
          IconsaxPlusBold.lock_1,
          size: 20.sp,
          color: widget.errorText != null
              ? Colors.red
              : const Color.fromARGB(255, 67, 90, 204),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(20.0),
          ),
          borderSide: BorderSide(
            color: widget.borderColor,
            width: 1.5.w,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(20.0),
          ),
          borderSide: BorderSide(
            color: Colors.red,
            width: 1.5.w,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(20.0),
          ),
          borderSide: BorderSide(
            color: widget.borderColor,
            width: 1.5.w,
          ),
        ),
        errorText: widget.errorText,
        errorMaxLines: 2,
        contentPadding: EdgeInsets.symmetric(
          vertical: 18.h,
          horizontal: 16.w,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            _isObscured ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: () {
            if (mounted)
              setState(() {
                _isObscured = !_isObscured;
              });
          },
        ),
      ),
    );
  }
}
