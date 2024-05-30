import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mate_project/widgets/normal_button_custom.dart';
import 'package:mate_project/widgets/normal_dialog_custom.dart';
import 'package:mate_project/widgets/otp_form.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  NormalDialogCustom dialogCustom = NormalDialogCustom();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      backgroundColor: const Color.fromARGB(255, 252, 252, 252),
      appBar: AppBar(
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        width: 360.w,
        height: 800.h,
        padding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 32.h),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Verification",
                style: GoogleFonts.inter(
                  color: const Color.fromARGB(255, 17, 19, 21),
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 24.h,
              ),
              Text(
                'Enter the verification code sent to',
                style: GoogleFonts.inter(
                  color: const Color.fromARGB(255, 129, 140, 155),
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                'loremispun@gmail.com',
                style: GoogleFonts.inter(
                  color: const Color.fromARGB(255, 76, 102, 232),
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 16.h,
              ),
              OtpForm(),
              SizedBox(
                height: 16.h,
              ),
              Wrap(
                children: [
                  Text(
                    "Didn’t receive a code?",
                    style: GoogleFonts.inter(
                      color: const Color.fromARGB(255, 129, 140, 155),
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  Text(
                    'Resend',
                    style: GoogleFonts.inter(
                      color: const Color.fromARGB(255, 76, 102, 232),
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.underline,
                      decorationColor: const Color.fromARGB(255, 76, 102, 232),
                    ),
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  NormalButtonCustom(
                    name: "Confirm",
                    action: () {
                      //This dialog is used when waiting for verification
                      // dialogCustom.showWaitingDialog(
                      //   context,
                      //   'assets/pics/otp.png',
                      //   'Checking',
                      //   "Wait a minute, we're checking for you.",
                      //   true,
                      //   const Color.fromARGB(255, 68, 60, 172),
                      // );

                      //This dialog is used when the code is failed verified
                      // dialogCustom.showSelectionDialog(
                      //   context,
                      //   'assets/pics/error.png',
                      //   'Checking failed!',
                      //   'It looks like the verification code you entered is incorrect.',
                      //   true,
                      //   const Color.fromARGB(255, 230, 57, 71),
                      //   'Send Code Again',
                      // );

                      //This dialog is used when the code is verified successfully
                      dialogCustom.showSelectionDialog(
                        context,
                        'assets/pics/checked.png',
                        'Welcome!',
                        "Welcome to Mate, let's experience great things together here!",
                        true,
                        const Color.fromARGB(255, 68, 60, 172),
                        'Continue',
                      );
                    },
                    background: const Color.fromARGB(255, 84, 110, 255),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
