import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mate_project/blocs/authen_bloc.dart';
import 'package:mate_project/enums/failure_enum.dart';
import 'package:mate_project/events/authen_event.dart';
import 'package:mate_project/screens/authentication/verification_screen.dart';
import 'package:mate_project/states/authen_state.dart';
import 'package:mate_project/widgets/form/edit_pass_field.dart';
import 'package:mate_project/widgets/form/edit_text_field.dart';
import 'package:mate_project/widgets/form/normal_button_custom.dart';
import 'package:mate_project/widgets/form/normal_dialog_custom.dart';

class CustomerRegisterScreen extends StatefulWidget {
  const CustomerRegisterScreen({super.key});

  @override
  State<CustomerRegisterScreen> createState() => _CustomerRegisterScreenState();
}

class _CustomerRegisterScreenState extends State<CustomerRegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  NormalDialogCustom dialogCustom = const NormalDialogCustom();

  @override
  void initState() {
    super.initState();
    _nameController.text = "";
    _emailController.text = "";
    _passwordController.text = "";
    _confirmPasswordController.text = "";
  }

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
        body: BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            if (state is SendCodeLoading) {
              dialogCustom.showWaitingDialog(
                context,
                'assets/pics/sent.png',
                'Wait a minute!',
                'Wait a minute, we are sending the verification code to your email.',
                true,
                const Color.fromARGB(255, 68, 60, 172),
              );
            }
            if (state is SendCodeFailure) {
              Navigator.pop(context);
            }
            if (state is SendCodeSucess) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => VerificationScreen(
                        email: _emailController.text, code: state.code)),
                (Route<dynamic> route) => false,
              );
            }
          },
          child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, state) {
            return Container(
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
                      "Sign up and experience services from Mate!",
                      style: GoogleFonts.inter(
                        color: const Color.fromARGB(255, 17, 19, 21),
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                    EditTextField(
                      controller: _nameController,
                      title: 'Full Name',
                      errorText: (state is SendCodeFailure &&
                              state.error.type == Failure.Fullname)
                          ? state.error.content
                          : null,
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    EditTextField(
                      controller: _emailController,
                      title: 'Email',
                      errorText: (state is SendCodeFailure &&
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
                      errorText: (state is SendCodeFailure &&
                              state.error.type == Failure.Password)
                          ? state.error.content
                          : null,
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    EditPassField(
                      controllerPass: _confirmPasswordController,
                      title: "Confirm Password",
                      errorText: (state is SendCodeFailure &&
                              state.error.type == Failure.ConfirmPasssword)
                          ? state.error.content
                          : null,
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    NormalButtonCustom(
                      name: "Register",
                      action: () {
                        final fullname = _nameController.text;
                        final email = _emailController.text;
                        final pass = _passwordController.text;
                        final confirmPass = _confirmPasswordController.text;

                        BlocProvider.of<AuthenticationBloc>(context).add(
                            RegisterPressed(
                                username: fullname,
                                password: pass,
                                email: email,
                                coinfirmPassword: confirmPass));
                      },
                      background: const Color.fromARGB(255, 84, 110, 255),
                    ),
                    SizedBox(
                      height: 48.h,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Or continue with',
                        style: GoogleFonts.inter(
                          color: Color.fromARGB(255, 184, 184, 184),
                          fontWeight: FontWeight.w500,
                          fontSize: 13.sp,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    const Align(
                      alignment: Alignment.center,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        backgroundImage: AssetImage(
                          "assets/pics/google_icon.png",
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
        ));
  }
}
