import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatTextField extends StatefulWidget {
  const ChatTextField({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  State<ChatTextField> createState() => _ChatTextFieldState();
}

class _ChatTextFieldState extends State<ChatTextField> {
  late FocusNode _focusNode;
  late Color textColor;
  bool expands = true;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    textColor = const Color.fromARGB(255, 150, 150, 150);

    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        setState(() {
          textColor = Colors.black;
          expands = true;
        });
      } else {
        setState(() {
          textColor = const Color.fromARGB(255, 150, 150, 150);
          expands = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      focusNode: _focusNode,
      style: GoogleFonts.inter(
        color: textColor,
        fontSize: 12.sp,
      ),
      maxLines: null,
      expands: expands,
      decoration: InputDecoration(
        hintText: 'Type message here',
        hintStyle: GoogleFonts.inter(
          color: const Color.fromARGB(255, 150, 150, 150),
          fontSize: 12.sp,
          fontWeight: FontWeight.w400,
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(30.0),
          ),
          borderSide: BorderSide(
            color: Color.fromARGB(255, 241, 241, 241),
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(30.0),
          ),
          borderSide: BorderSide(
            color: Color.fromARGB(255, 164, 178, 255),
          ),
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: 8.h,
          horizontal: 16.w,
        ),
        filled: true,
        fillColor: const Color.fromARGB(255, 241, 241, 241),
      ),
    );
  }
}
