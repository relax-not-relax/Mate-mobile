import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';

class SearchField extends StatefulWidget {
  const SearchField({
    super.key,
    required this.controller,
    required this.search,
    required this.filter,
  });

  final TextEditingController controller;
  final void Function() search;
  final void Function() filter;

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
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
        if (mounted)
          setState(() {
            textColor = Colors.black;
            expands = true;
          });
      } else {
        if (mounted)
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
      onTapOutside: (event) {
        FocusScope.of(context).unfocus();
      },
      decoration: InputDecoration(
        prefixIcon: InkWell(
          onTap: widget.search,
          child: const Icon(
            IconlyLight.search,
            color: Color.fromARGB(255, 79, 81, 89),
          ),
        ),
        suffixIcon: Container(
          margin: EdgeInsets.all(4.w),
          child: IconButton(
            onPressed: widget.filter,
            style: const ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(
                Color.fromARGB(255, 222, 222, 222),
              ),
            ),
            icon: Icon(
              IconlyLight.filter,
              size: 16.sp,
            ),
          ),
        ),
        hintText: 'Search staff',
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
