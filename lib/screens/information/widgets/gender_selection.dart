import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mate_project/helper/sharedpreferenceshelper.dart';

class GenderSelection extends StatefulWidget {
  const GenderSelection({
    super.key,
    required this.onSelecting,
    required this.done,
    required this.gender,
    required this.onSelectGender,
  });

  final void Function() onSelecting;
  final void Function() done;
  final String gender;
  final void Function(String) onSelectGender;

  @override
  State<GenderSelection> createState() => _GenderSelectionState();
}

class _GenderSelectionState extends State<GenderSelection> {
  List<String> genderSelection = ['Male', 'Female'];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {
            widget.onSelectGender(genderSelection[0]);
          },
          child: Container(
            width: 148.w,
            height: 200.h,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  color: Color.fromARGB(22, 71, 71, 71),
                  spreadRadius: 2,
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
              border: Border.all(
                color: widget.gender == genderSelection[0]
                    ? const Color.fromARGB(255, 67, 90, 204)
                    : Colors.white,
                width: 2,
              ),
            ),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    genderSelection[0],
                    style: GoogleFonts.inter(
                      color: const Color.fromARGB(255, 46, 62, 140),
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Image.asset(
                    'assets/pics/man.png',
                    width: 126.w,
                    height: 126.w,
                  ),
                ],
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            widget.onSelectGender(genderSelection[1]);
          },
          child: Container(
            width: 148.w,
            height: 200.h,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  color: Color.fromARGB(22, 71, 71, 71),
                  spreadRadius: 2,
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
              border: Border.all(
                color: widget.gender == genderSelection[1]
                    ? const Color.fromARGB(255, 67, 90, 204)
                    : Colors.white,
                width: 2,
              ),
            ),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    genderSelection[1],
                    style: GoogleFonts.inter(
                      color: const Color.fromARGB(255, 46, 62, 140),
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Image.asset(
                    'assets/pics/woman.png',
                    width: 126.w,
                    height: 126.w,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
