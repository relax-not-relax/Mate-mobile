import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mate_project/screens/authentication/customer_register_screen.dart';
import 'package:mate_project/widgets/form/edit_pass_field.dart';
import 'package:mate_project/widgets/form/edit_text_field.dart';
import 'package:mate_project/widgets/form/normal_button_custom.dart';
import 'package:mate_project/widgets/form/normal_dialog_custom.dart';

class CustomerLoginScreen extends StatefulWidget {
  const CustomerLoginScreen({super.key});

  @override
  State<CustomerLoginScreen> createState() => _CustomerLoginScreenState();
}

class _CustomerLoginScreenState extends State<CustomerLoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String errorText = "";
  NormalDialogCustom dialogCustom = NormalDialogCustom();

  @override
  void initState() {
    super.initState();
    _emailController.text = "";
    _passwordController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color.fromARGB(255, 41, 45, 50),
      appBar: AppBar(
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        width: 360.w,
        height: 800.h,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                width: 360.w,
                height: 800.h * 0.4,
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Image.asset(
                        'assets/pics/blur.png',
                        width: 250.w,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: -20.w,
                      child: Image.asset(
                        'assets/pics/hello.png',
                        width: 190.w,
                        height: 247.88.h,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 24.w,
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 200.w,
                                child: Text(
                                  "Sign in to your account",
                                  style: GoogleFonts.inter(
                                    color: Colors.white,
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 16.h,
                              ),
                              Wrap(
                                children: [
                                  Text(
                                    "Don’t have an account?",
                                    style: GoogleFonts.inter(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 13.sp,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return CustomerRegisterScreen();
                                          },
                                        ),
                                      );
                                    },
                                    child: Text(
                                      "Sign up",
                                      style: GoogleFonts.inter(
                                        color:
                                            Color.fromARGB(255, 84, 110, 255),
                                        fontWeight: FontWeight.w700,
                                        fontSize: 13.sp,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                width: 360.w,
                height: 800.h * 0.65,
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 252, 252, 252),
                  borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(15),
                    right: Radius.circular(15),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      EditTextField(
                        controller: _emailController,
                        title: 'Email',
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      EditPassField(
                        controllerPass: _passwordController,
                        title: "Password",
                      ),
                      SizedBox(
                        height: 24.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Wrap(
                            children: [
                              SizedBox(
                                height: 18,
                                width: 18,
                                child: Checkbox(
                                  checkColor:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  activeColor:
                                      const Color.fromRGBO(234, 84, 85, 1),
                                  fillColor: const WidgetStatePropertyAll(
                                    Color.fromARGB(255, 238, 241, 255),
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(2.0),
                                  ),
                                  side: MaterialStateBorderSide.resolveWith(
                                    (states) => const BorderSide(
                                      width: 1.0,
                                      color: Color.fromARGB(255, 238, 241, 255),
                                    ),
                                  ),
                                  value: false,
                                  onChanged: (bool? value) {},
                                ),
                              ),
                              SizedBox(
                                width: 8.w,
                              ),
                              Text(
                                'Remember me',
                                style: GoogleFonts.roboto(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w400,
                                  color:
                                      const Color.fromARGB(255, 115, 115, 115),
                                ),
                              )
                            ],
                          ),
                          InkWell(
                            onTap: () {},
                            child: Text(
                              'Forgot password?',
                              style: GoogleFonts.inter(
                                color: const Color.fromARGB(255, 84, 110, 255),
                                fontWeight: FontWeight.w600,
                                fontSize: 13.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 40.h,
                      ),
                      NormalButtonCustom(
                        name: "Login",
                        action: () {
                          dialogCustom.showWaitingDialog(
                            context,
                            'assets/pics/oldpeople.png',
                            "Have a nice day",
                            "Togetherness - Companion - Sharing",
                            true,
                            const Color.fromARGB(255, 68, 60, 172),
                          );
                        },
                        background: const Color.fromARGB(255, 84, 110, 255),
                      ),
                      SizedBox(
                        height: 40.h,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 100.w,
                            height: 1.h,
                            color: const Color.fromARGB(255, 217, 217, 217),
                          ),
                          Text(
                            "Or login with",
                            style: GoogleFonts.inter(
                              color: Color.fromARGB(255, 184, 184, 184),
                              fontWeight: FontWeight.w500,
                              fontSize: 13.sp,
                            ),
                          ),
                          Container(
                            width: 100.w,
                            height: 1.h,
                            color: const Color.fromARGB(255, 217, 217, 217),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 40.h,
                      ),
                      Container(
                        width: 360.w,
                        height: 59.h,
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 255, 255, 255),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(10, 20, 19, 19),
                              offset: Offset(0, 4),
                              blurRadius: 6.6,
                              spreadRadius: 2,
                            )
                          ],
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/pics/google_icon.png',
                                width: 20.w,
                                height: 20.w,
                              ),
                              SizedBox(
                                width: 16.w,
                              ),
                              Text(
                                "Continue with Google",
                                style: GoogleFonts.inter(
                                  color: Color.fromARGB(255, 115, 115, 115),
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
