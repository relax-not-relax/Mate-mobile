import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mate_project/blocs/authen_bloc.dart';
import 'package:mate_project/enums/failure_enum.dart';
import 'package:mate_project/events/authen_event.dart';
import 'package:mate_project/screens/authentication/verification_screen.dart';
import 'package:mate_project/screens/information/get_information_screen.dart';
import 'package:mate_project/states/authen_state.dart';
import 'package:mate_project/widgets/form/edit_pass_field.dart';
import 'package:mate_project/widgets/form/edit_text_field.dart';
import 'package:mate_project/widgets/form/normal_button_custom.dart';
import 'package:mate_project/widgets/form/normal_dialog_custom.dart';

class CustomerRegisterGoogleScreen extends StatefulWidget {
  const CustomerRegisterGoogleScreen(
      {super.key, required this.googleId, required this.email});
  final String googleId;
  final String email;

  @override
  State<CustomerRegisterGoogleScreen> createState() =>
      _CustomerRegisterGoogleScreenState();
}

class _CustomerRegisterGoogleScreenState
    extends State<CustomerRegisterGoogleScreen> {
  final TextEditingController _nameController = TextEditingController();
  NormalDialogCustom dialogCustom = const NormalDialogCustom();

  @override
  void initState() {
    super.initState();
    _nameController.text = "";
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
            if (state is RegisterGoogleLoading) {
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
            if (state is RegisterGoogleSuccess) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => const GetInformationScreen()),
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
                      errorText: (state is RegisterGoogleFailure &&
                              state.error.type == Failure.Fullname)
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
                        BlocProvider.of<AuthenticationBloc>(context).add(
                            RegisterGooglePressed(
                                email: widget.email,
                                fullName: fullname,
                                googleId: widget.googleId));
                      },
                      background: const Color.fromARGB(255, 84, 110, 255),
                    ),
                    SizedBox(
                      height: 48.h,
                    ),
                  ],
                ),
              ),
            );
          }),
        ));
  }
}
