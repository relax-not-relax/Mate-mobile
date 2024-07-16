import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';

class SearchField extends StatefulWidget {
  const SearchField({
    super.key,
    required this.controller,
    required this.search,
  });

  final TextEditingController controller;
  final void Function(String) search;

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  late FocusNode _focusNode;
  late Color textColor;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    textColor = const Color.fromARGB(255, 154, 155, 159);

    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        setState(() {
          textColor = Colors.white;
        });
      } else {
        setState(() {
          textColor = const Color.fromARGB(255, 154, 155, 159);
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
      onTapOutside: (event) {
        FocusScope.of(context).unfocus();
      },
      decoration: InputDecoration(
        prefixIcon: const Icon(
          IconlyLight.search,
          color: Color.fromARGB(255, 154, 155, 159),
        ),
        hintText: 'Search for user',
        hintStyle: GoogleFonts.inter(
          color: const Color.fromARGB(255, 154, 155, 159),
          fontSize: 12.sp,
          fontWeight: FontWeight.w400,
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(30.0),
          ),
          borderSide: BorderSide(
            color: const Color.fromARGB(255, 15, 16, 20),
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(30.0),
          ),
          borderSide: BorderSide(
            color: Color.fromARGB(255, 15, 16, 20),
          ),
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: 16.h,
          horizontal: 16.w,
        ),
        filled: true,
        fillColor: const Color.fromARGB(255, 32, 35, 43),
      ),
    );
  }
}
