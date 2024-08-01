import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class EditTextField extends StatefulWidget {
  const EditTextField({
    super.key,
    required this.controller,
    required this.title,
    this.errorText,
  });

  final TextEditingController controller;
  final String title;
  final String? errorText;

  @override
  State<EditTextField> createState() => _EditTextFieldState();
}

class _EditTextFieldState extends State<EditTextField> {
  late FocusNode _focusNode;
  late Color textColor;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    textColor = const Color.fromARGB(255, 187, 188, 191);

    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        if (mounted)
          setState(() {
            textColor = Colors.black;
          });
      } else {
        if (mounted)
          setState(() {
            textColor = const Color.fromARGB(255, 187, 188, 191);
          });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: GoogleFonts.inter(
            color: Color.fromARGB(255, 115, 115, 115),
            fontSize: 13.0.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(
          height: 4.h,
        ),
        TextFormField(
          controller: widget.controller,
          focusNode: _focusNode,
          style: GoogleFonts.inter(
            color: textColor,
            fontSize: 13.sp,
          ),
          decoration: InputDecoration(
            hintText: 'loremispun@gmail.com',
            hintStyle: GoogleFonts.inter(
              color: const Color.fromARGB(255, 187, 188, 191),
              fontSize: 13.sp,
              fontWeight: FontWeight.w400,
            ),
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
              borderSide: BorderSide(
                color: Color.fromARGB(255, 238, 241, 255),
              ),
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
              borderSide: BorderSide(
                color: Color.fromARGB(255, 164, 178, 255),
              ),
            ),
            errorText: widget.errorText,
            contentPadding: EdgeInsets.symmetric(
              vertical: 8.h,
              horizontal: 16.w,
            ),
            filled: true,
            fillColor: const Color.fromARGB(255, 238, 241, 255),
          ),
        )
      ],
    );
  }
}
