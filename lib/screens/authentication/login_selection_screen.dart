import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mate_project/helper/languages_helper.dart';
import 'package:mate_project/helper/sharedpreferenceshelper.dart';
import 'package:mate_project/models/rememberme.dart';
import 'package:mate_project/screens/authentication/customer_login_screen.dart';
import 'package:mate_project/screens/authentication/staff_login_screen.dart';
import 'package:mate_project/widgets/form/normal_button_custom.dart';
import 'package:mate_project/widgets/form/outline_button_custom.dart';

class LoginSelectionScreen extends StatelessWidget {
  const LoginSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 41, 45, 50),
      body: Stack(
        children: [
          Container(
            width: 360.w,
            height: 800.h,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: AnimatedContainer(
                    duration: const Duration(seconds: 1),
                    curve: Curves.easeInExpo,
                    width: 148.03.w,
                    height: 212.h,
                    child: Image.asset(
                      'assets/pics/app_logo.png',
                    ),
                  ),
                ),
                SizedBox(
                  height: 32.h,
                ),
                Text(
                  LanguagesHelper().getString(LanguagesHelper.accountLogin),
                  style: GoogleFonts.inter(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 4.h,
                ),
                Text(
                  "Login as a customer of Mate or our staff",
                  style: GoogleFonts.inter(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  NormalButtonCustom(
                    name: 'LOGIN AS CUSTOMER',
                    action: () async {
                      Rememberme? rm =
                          await SharedPreferencesHelper.getRememberMe();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return CustomerLoginScreen(
                              rememberme: rm,
                            );
                          },
                        ),
                      );
                    },
                    background: const Color.fromARGB(255, 84, 110, 255),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  OutlineButtonCustom(
                    name: 'LOGIN AS STAFF',
                    action: () async {
                      Rememberme? rm =
                          await SharedPreferencesHelper.getRememberStaffAdmin();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return StaffLoginScreen(
                              rememberme: rm,
                            );
                          },
                        ),
                      );
                    },
                    selectionColor: const Color.fromARGB(255, 84, 110, 255),
                  ),
                  SizedBox(
                    height: 40.h,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
