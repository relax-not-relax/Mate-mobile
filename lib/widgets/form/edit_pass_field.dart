import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class EditPassField extends StatefulWidget {
  const EditPassField({
    super.key,
    required this.controllerPass,
    required this.title,
    this.errorText,
    this.selectionColor,
  });

  final TextEditingController controllerPass;
  final String title;
  final String? errorText;
  final Color? selectionColor;

  @override
  State<EditPassField> createState() => _EditPassFieldState();
}

class _EditPassFieldState extends State<EditPassField> {
  late FocusNode _focusNode;
  late Color textColor;
  bool _isObscured = true;

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
          controller: widget.controllerPass,
          focusNode: _focusNode,
          obscureText: _isObscured,
          style: GoogleFonts.inter(
            color: textColor,
            fontSize: 13.sp,
          ),
          decoration: InputDecoration(
            hintText: 'Abc@123456',
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
            errorText: widget.errorText,
            errorMaxLines: 3,
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
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
            fillColor: const Color.fromARGB(255, 238, 241, 255),
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
        ),
      ],
    );
  }
}
