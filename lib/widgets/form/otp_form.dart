import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class OtpForm extends StatefulWidget {
  const OtpForm({super.key, required this.inputCode});
  final void Function(int, String) inputCode;
  @override
  // ignore: no_logic_in_create_state
  State<OtpForm> createState() => _OtpFormState(inputCode: inputCode);
}

class _OtpFormState extends State<OtpForm> {
  final void Function(int, String) inputCode;
  _OtpFormState({required this.inputCode});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 60.h,
            width: 40.w,
            child: TextFormField(
              onChanged: (value) {
                if (value.length == 1) {
                  inputCode(0, value);
                  FocusScope.of(context).nextFocus();
                }
              },
              onSaved: (newValue) {},
              keyboardType: TextInputType.number,
              style: GoogleFonts.inter(
                color: Colors.black,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
              inputFormatters: [
                LengthLimitingTextInputFormatter(1),
                FilteringTextInputFormatter.digitsOnly,
              ],
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                  borderSide: BorderSide(
                    width: 2,
                    color: Color.fromARGB(255, 238, 241, 255),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                  borderSide: BorderSide(
                    width: 2,
                    color: Color.fromARGB(255, 67, 90, 204),
                  ),
                ),
                filled: true,
                fillColor: Color.fromARGB(255, 238, 241, 255),
              ),
            ),
          ),
          SizedBox(
            height: 60.h,
            width: 40.w,
            child: TextFormField(
              onChanged: (value) {
                if (value.length == 1) {
                  FocusScope.of(context).nextFocus();
                  inputCode(1, value);
                }
              },
              onSaved: (newValue) {},
              keyboardType: TextInputType.number,
              style: GoogleFonts.inter(
                color: Colors.black,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
              inputFormatters: [
                LengthLimitingTextInputFormatter(1),
                FilteringTextInputFormatter.digitsOnly,
              ],
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                  borderSide: BorderSide(
                    width: 2,
                    color: Color.fromARGB(255, 238, 241, 255),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                  borderSide: BorderSide(
                    width: 2,
                    color: Color.fromARGB(255, 67, 90, 204),
                  ),
                ),
                filled: true,
                fillColor: Color.fromARGB(255, 238, 241, 255),
              ),
            ),
          ),
          SizedBox(
            height: 60.h,
            width: 40.w,
            child: TextFormField(
              onChanged: (value) {
                if (value.length == 1) {
                  inputCode(2, value);
                  FocusScope.of(context).nextFocus();
                }
              },
              onSaved: (newValue) {},
              keyboardType: TextInputType.number,
              style: GoogleFonts.inter(
                color: Colors.black,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
              inputFormatters: [
                LengthLimitingTextInputFormatter(1),
                FilteringTextInputFormatter.digitsOnly,
              ],
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                  borderSide: BorderSide(
                    width: 2,
                    color: Color.fromARGB(255, 238, 241, 255),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                  borderSide: BorderSide(
                    width: 2,
                    color: Color.fromARGB(255, 67, 90, 204),
                  ),
                ),
                filled: true,
                fillColor: Color.fromARGB(255, 238, 241, 255),
              ),
            ),
          ),
          SizedBox(
            height: 60.h,
            width: 40.w,
            child: TextFormField(
              onChanged: (value) {
                if (value.length == 1) {
                  inputCode(3, value);
                  FocusScope.of(context).nextFocus();
                }
              },
              onSaved: (newValue) {},
              keyboardType: TextInputType.number,
              style: GoogleFonts.inter(
                color: Colors.black,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
              inputFormatters: [
                LengthLimitingTextInputFormatter(1),
                FilteringTextInputFormatter.digitsOnly,
              ],
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                  borderSide: BorderSide(
                    width: 2,
                    color: Color.fromARGB(255, 238, 241, 255),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                  borderSide: BorderSide(
                    width: 2,
                    color: Color.fromARGB(255, 67, 90, 204),
                  ),
                ),
                filled: true,
                fillColor: Color.fromARGB(255, 238, 241, 255),
              ),
            ),
          ),
          SizedBox(
            height: 60.h,
            width: 40.w,
            child: TextFormField(
              onChanged: (value) {
                if (value.length == 1) {
                  inputCode(4, value);
                  FocusScope.of(context).nextFocus();
                }
              },
              onSaved: (newValue) {},
              keyboardType: TextInputType.number,
              style: GoogleFonts.inter(
                color: Colors.black,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
              inputFormatters: [
                LengthLimitingTextInputFormatter(1),
                FilteringTextInputFormatter.digitsOnly,
              ],
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                  borderSide: BorderSide(
                    width: 2,
                    color: Color.fromARGB(255, 238, 241, 255),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                  borderSide: BorderSide(
                    width: 2,
                    color: Color.fromARGB(255, 67, 90, 204),
                  ),
                ),
                filled: true,
                fillColor: Color.fromARGB(255, 238, 241, 255),
              ),
            ),
          ),
          SizedBox(
            height: 60.h,
            width: 40.w,
            child: TextFormField(
              onChanged: (value) {
                if (value.length == 1) {
                  inputCode(5, value);
                  FocusScope.of(context).nextFocus();
                }
              },
              onSaved: (newValue) {},
              keyboardType: TextInputType.number,
              style: GoogleFonts.inter(
                color: Colors.black,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
              inputFormatters: [
                LengthLimitingTextInputFormatter(1),
                FilteringTextInputFormatter.digitsOnly,
              ],
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                  borderSide: BorderSide(
                    width: 2,
                    color: Color.fromARGB(255, 238, 241, 255),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                  borderSide: BorderSide(
                    width: 2,
                    color: Color.fromARGB(255, 67, 90, 204),
                  ),
                ),
                filled: true,
                fillColor: Color.fromARGB(255, 238, 241, 255),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
