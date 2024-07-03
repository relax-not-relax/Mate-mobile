import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mate_project/blocs/authen_bloc.dart';
import 'package:mate_project/enums/failure_enum.dart';
import 'package:mate_project/events/authen_event.dart';
import 'package:mate_project/models/rememberme.dart';
import 'package:mate_project/screens/authentication/customer_register_screen.dart';
import 'package:mate_project/screens/home/customer/home_screen.dart';
import 'package:mate_project/screens/home/customer/main_screen.dart';
import 'package:mate_project/screens/information/get_information_screen.dart';
import 'package:mate_project/states/authen_state.dart';
import 'package:mate_project/widgets/form/edit_pass_field.dart';
import 'package:mate_project/widgets/form/edit_text_field.dart';
import 'package:mate_project/widgets/form/normal_button_custom.dart';
import 'package:mate_project/widgets/form/normal_dialog_custom.dart';

class CustomerLoginScreen extends StatefulWidget {
  const CustomerLoginScreen({super.key, this.rememberme});
  final Rememberme? rememberme;

  @override
  // ignore: no_logic_in_create_state
  State<CustomerLoginScreen> createState() =>
      _CustomerLoginScreenState(rememberMe: rememberme);
}

class _CustomerLoginScreenState extends State<CustomerLoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String errorText = "";
  NormalDialogCustom dialogCustom = const NormalDialogCustom();
  final Rememberme? rememberMe;
  bool rememberMeCheck = false;

  _CustomerLoginScreenState({required this.rememberMe});

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
      backgroundColor: const Color.fromARGB(255, 41, 45, 50),
      appBar: AppBar(
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(
          color: Colors.white,
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
        if (state is LoginSuccess) {
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
            if (state.customerResponse.gender == null ||
                state.customerResponse.gender == "") {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => const GetInformationScreen()),
                (Route<dynamic> route) => false,
              );
            } else {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => const MainScreen(
                          inputScreen: HomeScreen(),
                          screenIndex: 0,
                        )),
                (Route<dynamic> route) => false,
              );
            }
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
      }, child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          return Container(
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
                                                return const CustomerRegisterScreen();
                                              },
                                            ),
                                          );
                                        },
                                        child: Text(
                                          "Sign up",
                                          style: GoogleFonts.inter(
                                            color: const Color.fromARGB(
                                                255, 84, 110, 255),
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
                    padding:
                        EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
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
                                          255, 84, 110, 255),
                                      activeColor:
                                          const Color.fromRGBO(234, 84, 85, 1),
                                      fillColor: const WidgetStatePropertyAll(
                                        Color.fromARGB(255, 238, 241, 255),
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(2.0),
                                      ),
                                      side: MaterialStateBorderSide.resolveWith(
                                        (states) => const BorderSide(
                                          width: 1.0,
                                          color: Color.fromARGB(
                                              255, 238, 241, 255),
                                        ),
                                      ),
                                      value: rememberMeCheck,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          rememberMeCheck = value!;
                                        });
                                      },
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
                                    color:
                                        const Color.fromARGB(255, 84, 110, 255),
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
                              BlocProvider.of<AuthenticationBloc>(context).add(
                                  LoginPressed(
                                      rememberCheck: rememberMeCheck,
                                      email: _emailController.text,
                                      password: _passwordController.text,
                                      fcm: ""));
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
          );
        },
      )),
    );
  }
}
