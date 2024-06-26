import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';

class EditNote extends StatefulWidget {
  const EditNote({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  late double minHeight;
  late FocusNode _focusNode;
  late Color textColor;

  @override
  void initState() {
    super.initState();

    minHeight = 200.h;
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
    return Container(
      width: 360.w,
      height: minHeight,
      child: TextFormField(
        controller: widget.controller,
        style: GoogleFonts.inter(
          fontSize: 12.sp,
          color: textColor,
          fontWeight: FontWeight.w400,
        ),
        focusNode: _focusNode,
        maxLines: null,
        expands: true,
        onTapOutside: (event) {
          FocusScope.of(context).unfocus();
        },
        decoration: InputDecoration(
          labelText: "Note",
          labelStyle: GoogleFonts.inter(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: const Color.fromARGB(255, 67, 90, 204),
          ),
          hintText: "Note",
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
