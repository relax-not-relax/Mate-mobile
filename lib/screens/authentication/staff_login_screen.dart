import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mate_project/blocs/authen_bloc.dart';
import 'package:mate_project/enums/failure_enum.dart';
import 'package:mate_project/events/authen_event.dart';
import 'package:mate_project/models/rememberme.dart';
import 'package:mate_project/screens/home/staff/staff_home_screen.dart';
import 'package:mate_project/screens/home/staff/staff_main_screen.dart';
import 'package:mate_project/states/authen_state.dart';
import 'package:mate_project/widgets/form/edit_pass_field.dart';
import 'package:mate_project/widgets/form/edit_text_field.dart';
import 'package:mate_project/widgets/form/normal_button_custom.dart';
import 'package:mate_project/widgets/form/normal_dialog_custom.dart';

class StaffLoginScreen extends StatefulWidget {
  const StaffLoginScreen({super.key, this.rememberme});
  final Rememberme? rememberme;

  @override
  // ignore: no_logic_in_create_state
  State<StaffLoginScreen> createState() =>
      _StaffLoginScreenState(rememberMe: rememberme);
}

class _StaffLoginScreenState extends State<StaffLoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String errorText = "";
  NormalDialogCustom dialogCustom = NormalDialogCustom();
  final Rememberme? rememberMe;
  bool rememberMeCheck = false;

  _StaffLoginScreenState({required this.rememberMe});

  @override
  void initState() {
    super.initState();
    _emailController.text = rememberMe != null ? rememberMe!.email : "";
    _passwordController.text = rememberMe != null ? rememberMe!.password : "";
    rememberMe == null ? rememberMeCheck = false : rememberMeCheck = true;
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
        body: BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) async {
            if (state is LoginLoading) {
              dialogCustom.showWaitingDialog(
                context,
                'assets/pics/oldpeople.png',
                "Wating..",
                "Togetherness - Companion - Sharing",
                true,
                const Color.fromARGB(255, 68, 60, 172),
              );
            }
            if (state is LoginSuccessStaffAdmin) {
              Navigator.of(context).pop();
              dialogCustom.showWaitingDialog(
                context,
                'assets/pics/oldpeople.png',
                "Have a nice day",
                "Togetherness - Companion - Sharing",
                true,
                const Color.fromARGB(255, 68, 60, 172),
              );

              await Future.delayed(Duration(seconds: 2), () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const StaffMainScreen(
                            inputScreen: StaffHomeScreen(),
                            screenIndex: 0,
                          )),
                  (Route<dynamic> route) => false,
                );
              });
            }
            if (state is LoginFail && state.error.type == Failure.System) {
              dialogCustom.showSelectionDialog(
                context,
                'assets/pics/error.png',
                'Incorrect email or password',
                'Please check again',
                true,
                const Color.fromARGB(255, 230, 57, 71),
                'Continue',
                () {
                  Navigator.of(context).pop();
                },
              );
            }
            if (state is LoginFail && state.error.type != Failure.System) {
              Navigator.of(context).pop();
            }
          },
          child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, state) {
            return Container(
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
                              errorText: (state is LoginFail &&
                                      state.error.type == Failure.Email)
                                  ? state.error.content
                                  : null,
                            ),
                            SizedBox(
                              height: 16.h,
                            ),
                            EditPassField(
                              controllerPass: _passwordController,
                              title: "Password",
                              errorText: (state is LoginFail &&
                                      state.error.type == Failure.Password)
                                  ? state.error.content
                                  : null,
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
                                        checkColor: const Color.fromARGB(
                                            255, 255, 255, 255),
                                        activeColor: const Color.fromRGBO(
                                            234, 84, 85, 1),
                                        fillColor: const WidgetStatePropertyAll(
                                          Color.fromARGB(255, 238, 241, 255),
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(2.0),
                                        ),
                                        side:
                                            MaterialStateBorderSide.resolveWith(
                                          (states) => const BorderSide(
                                            width: 1.0,
                                            color: Color.fromARGB(
                                                255, 238, 241, 255),
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
                                        color: const Color.fromARGB(
                                            255, 115, 115, 115),
                                      ),
                                    )
                                  ],
                                ),
                                InkWell(
                                  onTap: () {},
                                  child: Text(
                                    'Forgot password?',
                                    style: GoogleFonts.inter(
                                      color: const Color.fromARGB(
                                          255, 84, 110, 255),
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
                                BlocProvider.of<AuthenticationBloc>(context)
                                    .add(LoginStaffOrAdminPressed(
                                        rememberCheck: rememberMeCheck,
                                        email: _emailController.text,
                                        password: _passwordController.text,
                                        fcm: ""));
                              },
                              background:
                                  const Color.fromARGB(255, 84, 110, 255),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ));
  }
}
