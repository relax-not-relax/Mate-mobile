import 'dart:async';
import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mate_project/blocs/authen_bloc.dart';
import 'package:mate_project/events/authen_event.dart';
import 'package:mate_project/helper/sharedpreferenceshelper.dart';
import 'package:mate_project/states/authen_state.dart';
import 'package:mate_project/widgets/form/normal_button_custom.dart';
import 'package:mate_project/widgets/form/normal_dialog_custom.dart';
import 'package:mate_project/widgets/form/otp_form.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen(
      {super.key, required this.email, required this.code});
  final String email;
  final String code;
  @override
  // ignore: no_logic_in_create_state
  State<VerificationScreen> createState() => _VerificationScreenState(
        email: email,
      );
}

class _VerificationScreenState extends State<VerificationScreen> {
  NormalDialogCustom dialogCustom = NormalDialogCustom();
  final String email;
  String code = '';
  List<String> confirmCode = List.from(<String>['a', 'a', 'a', 'a', 'a', 'a']);
  final StreamController<int> _streamController = StreamController<int>();
  int _startCounter = 59;

  @override
  void initState() {
    super.initState();
    code = widget.code;
    _streamController.addStream(countStream());
  }

  void inputCode(int index, String number) {
    confirmCode[index] = number;
  }

  String getCode() {
    String rs = '';
    for (String c in confirmCode) {
      rs += c;
    }
    return rs;
  }

  Stream<int> countStream() async* {
    while (_startCounter > 0) {
      await Future.delayed(const Duration(seconds: 1));
      _startCounter--;
      yield _startCounter;
    }
  }

  void _restartStream() async {
    if (_startCounter == 0) {
      String info = await SharedPreferencesHelper.getRegisterInformation();
      dynamic registerInfo = jsonDecode(info);
      BlocProvider.of<AuthenticationBloc>(context).add(RegisterPressed(
          username: registerInfo['fullname'],
          password: registerInfo['password'],
          email: email,
          coinfirmPassword: registerInfo['password']));
      _startCounter = 59;
      _streamController.addStream(countStream());
    }
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  _VerificationScreenState({required this.email});

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
          listener: (context, state) async {
            if (state is SendCodeSucess) {
              code = state.code;
            }
            if (state is ConfirmCodeSuccess) {
              String info =
                  await SharedPreferencesHelper.getRegisterInformation();
              dynamic customerInfo = jsonDecode(info);
              dialogCustom.showSelectionDialog(
                context,
                'assets/pics/checked.png',
                'Welcome!',
                "Welcome to Mate, let's experience great things together here!",
                true,
                const Color.fromARGB(255, 68, 60, 172),
                'Continue',
                () {
                  BlocProvider.of<AuthenticationBloc>(context).add(
                      RegisterDonePressed(
                          fullname: customerInfo['fullname'],
                          password: customerInfo['password'],
                          email: customerInfo['email']));
                  Navigator.of(context).pop();
                },
              );
            }
            if (state is ConfirmCodeFailure) {
              dialogCustom.showSelectionDialog(
                context,
                'assets/pics/error.png',
                'Checking failed!',
                'It looks like the verification code you entered is incorrect.',
                true,
                const Color.fromARGB(255, 230, 57, 71),
                'Continue',
                () {
                  Navigator.of(context).pop();
                },
              );
            }
          },
          child: Container(
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
                    email,
                    style: GoogleFonts.inter(
                      color: const Color.fromARGB(255, 76, 102, 232),
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  OtpForm(inputCode: inputCode),
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
                      StreamBuilder<int>(
                          stream: _streamController.stream,
                          builder: (BuildContext context,
                              AsyncSnapshot<int> snapshot) {
                            if (snapshot.hasData && snapshot.data! > 0) {
                              return Text(
                                'resend after: ${snapshot.data}s',
                                style: GoogleFonts.inter(
                                  color: Color.fromARGB(255, 0, 99, 229),
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w500,
                                  decorationColor:
                                      const Color.fromARGB(255, 76, 102, 232),
                                ),
                              );
                            } else if (snapshot.hasData && snapshot.data == 0) {
                              return InkWell(
                                onTap: _restartStream,
                                child: Text(
                                  'Resend',
                                  style: GoogleFonts.inter(
                                    color:
                                        const Color.fromARGB(255, 76, 102, 232),
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w500,
                                    decoration: TextDecoration.underline,
                                    decorationColor:
                                        const Color.fromARGB(255, 76, 102, 232),
                                  ),
                                ),
                              );
                            } else {
                              return const SizedBox(height: 0, width: 0);
                            }
                          }),
                      SizedBox(
                        height: 40.h,
                      ),
                      NormalButtonCustom(
                        name: "Confirm",
                        action: () {
                          BlocProvider.of<AuthenticationBloc>(context).add(
                              ConfirmCodePressed(
                                  code: code, codeConfirm: getCode()));
                        },
                        background: const Color.fromARGB(255, 84, 110, 255),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
