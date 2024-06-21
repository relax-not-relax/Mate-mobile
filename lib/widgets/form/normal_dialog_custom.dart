import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mate_project/widgets/form/circular_progress.dart';
import 'package:mate_project/widgets/form/normal_button_custom.dart';

class NormalDialogCustom {
  const NormalDialogCustom();

  void showWaitingDialog(
    BuildContext context,
    String imgUrl,
    String title,
    String description,
    bool isDismiss,
    Color selectionColor,
  ) {
    showDialog(
      context: context,
      barrierDismissible: isDismiss,
      builder: (context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(0),
          content: Container(
            width: 340.w,
            height: 420.h,
            padding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 24.h),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(35)),
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    imgUrl,
                    width: 150.w,
                    height: 150.w,
                  ),
                ),
                SizedBox(
                  height: 16.h,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    title,
                    style: GoogleFonts.inter(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                      color: selectionColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 4.h,
                ),
                Text(
                  description,
                  style: GoogleFonts.inter(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color.fromARGB(255, 129, 140, 155),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 32.h,
                ),
                Column(
                  children: [
                    SizedBox(
                      width: 60.w,
                      height: 60.h,
                      child: const CircularProgressCustom(
                        beginColor: Color.fromARGB(255, 76, 102, 232),
                        endColor: Color.fromARGB(0, 255, 255, 255),
                        backgroundColorSelection: Colors.white,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void showSelectionDialog(
      BuildContext context,
      String imgUrl,
      String title,
      String description,
      bool isDismiss,
      Color selectionColor,
      String content,
      void Function() click) {
    showDialog(
      context: context,
      barrierDismissible: isDismiss,
      builder: (context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(0),
          content: Container(
            width: 350.w,
            height: 430.h,
            padding: EdgeInsets.fromLTRB(24.w, 24.h, 24.w, 24.h),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(35)),
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    imgUrl,
                    width: 150.w,
                    height: 150.w,
                  ),
                ),
                SizedBox(
                  height: 16.h,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    title,
                    style: GoogleFonts.inter(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                      color: selectionColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 4.h,
                ),
                Text(
                  description,
                  style: GoogleFonts.inter(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color.fromARGB(255, 129, 140, 155),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 32.h,
                ),
                NormalButtonCustom(
                  name: content,
                  action: () {
                    click();
                  },
                  background: selectionColor,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
