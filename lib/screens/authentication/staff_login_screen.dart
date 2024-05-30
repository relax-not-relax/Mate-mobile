import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mate_project/widgets/edit_pass_field.dart';
import 'package:mate_project/widgets/edit_text_field.dart';
import 'package:mate_project/widgets/normal_button_custom.dart';
import 'package:mate_project/widgets/normal_dialog_custom.dart';

class StaffLoginScreen extends StatefulWidget {
  const StaffLoginScreen({super.key});

  @override
  State<StaffLoginScreen> createState() => _StaffLoginScreenState();
}

class _StaffLoginScreenState extends State<StaffLoginScreen> {
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
        child: Stack(
          children: [
            Container(
              width: 360.w,
              height: 800.h * 0.5,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/pics/staff.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                width: 360.w,
                height: 800.h * 0.55,
                padding: EdgeInsets.fromLTRB(24.w, 32.h, 24.w, 0),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 252, 252, 252),
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Hello, have a nice day!",
                        style: GoogleFonts.inter(
                          color: const Color.fromARGB(255, 41, 45, 50),
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: 24.h,
                      ),
                      EditTextField(
                        controller: _emailController,
                        title: "Email",
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
