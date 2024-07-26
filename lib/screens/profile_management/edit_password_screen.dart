import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mate_project/blocs/customer_bloc.dart';
import 'package:mate_project/enums/failure_enum.dart';
import 'package:mate_project/events/customer_event.dart';
import 'package:mate_project/helper/sharedpreferenceshelper.dart';
import 'package:mate_project/models/request/password_request.dart';
import 'package:mate_project/screens/profile_management/customer/customer_account_main_screen.dart';
import 'package:mate_project/screens/profile_management/widgets/edit_password.dart';
import 'package:mate_project/states/customer_state.dart';
import 'package:mate_project/widgets/app_bar/normal_app_bar.dart';
import 'package:mate_project/widgets/form/normal_button_custom.dart';
import 'package:mate_project/widgets/form/normal_dialog_custom.dart';

class EditPasswordScreen extends StatefulWidget {
  const EditPasswordScreen({super.key});

  @override
  State<EditPasswordScreen> createState() => _EditPasswordScreenState();
}

class _EditPasswordScreenState extends State<EditPasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  NormalDialogCustom dialogCustom = const NormalDialogCustom();
  late CustomerBloc _customerBloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _customerBloc = BlocProvider.of<CustomerBloc>(context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool _isPasswordMismatch = false;
  bool _isInCorrectOldPassword = false;
  bool _isUnChecked = false;
  bool _isValid = false;
  String errorText = "";
  String passCheck = "";

  Future getPass() async {
    if (await SharedPreferencesHelper.getRememberMe() != null) {
      passCheck = (await SharedPreferencesHelper.getRememberMe())!.password;
    }
  }

  @override
  void initState() {
    super.initState();
    _newPasswordController.text = "";
    _confirmPasswordController.text = "";
    // Test data (Please get from login info)
    _passwordController.text = passCheck;
  }

  void _validateAndSave() {
    print("oke");
    final passwordRegex =
        RegExp(r'^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,12}$');

    // if (_passwordController.text != passCheck) {
    //   setState(() {
    //     _isInCorrectOldPassword = true;
    //   });
    // } else {
    //   _isInCorrectOldPassword = false;
    // }

    if (_newPasswordController.text != _confirmPasswordController.text) {
      setState(() {
        _isPasswordMismatch = true;
      });
    } else {
      setState(() {
        _isPasswordMismatch = false;
      });
    }

    if (_newPasswordController.text != "") {
      if (_newPasswordController.text.contains(' ')) {
        setState(() {
          _isUnChecked = true;
          errorText = "Password must not contain spaces!";
        });
      } else {
        _isUnChecked = false;
      }

      _isValid = passwordRegex.hasMatch(_newPasswordController.text);
      if (_isValid) {
        setState(() {
          _isUnChecked = false;
        });
      } else {
        setState(() {
          _isUnChecked = true;
          errorText =
              "Password must have at least one number, one lowercase letter, one uppercase letter, and be between 8 and 12 characters long";
        });
      }
    }

    if (_isInCorrectOldPassword == false && _isPasswordMismatch == false) {
      if (_newPasswordController.text == "") {
        setState(() {
          _newPasswordController.text = _passwordController.text;
        });
        //Navigator.pop(context, _newPasswordController.text);
      } else if (_newPasswordController.text != "" &&
          _isUnChecked == false &&
          _isValid) {
        //Navigator.pop(context, _newPasswordController.text);
      }
    }

    print(2222);
    if (!_isPasswordMismatch && !_isUnChecked && _isValid) {
      _customerBloc.add(SaveChangePasswordPressed(
          passwordRequest: PasswordRequest(
              oldPassword: _passwordController.text,
              newPassword: _newPasswordController.text)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: false,
        backgroundColor: Colors.white,
        appBar: TNormalAppBar(
          title: "Change Password",
          isBordered: false,
          isBack: true,
          back: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const CustomerAccountMainScreen();
                },
              ),
            );
          },
        ),
        body: BlocListener<CustomerBloc, CustomerState>(
          listener: (context, state) async {
            if (state is UpdateCustomerLoading) {
              dialogCustom.showWaitingDialog(
                context,
                'assets/pics/oldpeople.png',
                "Wating..",
                "Togetherness - Companion - Sharing",
                false,
                const Color.fromARGB(255, 68, 60, 172),
              );
            }
            if (state is UpdateCustomerSuccess) {
              Navigator.of(context).pop();
              dialogCustom.showWaitingDialog(
                context,
                'assets/pics/oldpeople.png',
                "Update success",
                "Togetherness - Companion - Sharing",
                false,
                const Color.fromARGB(255, 68, 60, 172),
              );
              await Future.delayed(const Duration(seconds: 1));
              Navigator.of(context).pop();
            }
            if (state is UpdateCustomerFailure) {
              Navigator.of(context).pop();
              dialogCustom.showSelectionDialog(
                context,
                'assets/pics/error.png',
                state.error.content,
                'Please check again',
                true,
                const Color.fromARGB(255, 230, 57, 71),
                'Continue',
                () {
                  Navigator.of(context).pop();
                },
              );
            }
            if (state is UpdateCustomerFailure &&
                state.error.type == Failure.System) {
              dialogCustom.showSelectionDialog(
                context,
                'assets/pics/error.png',
                'System failure',
                'Please check again',
                true,
                const Color.fromARGB(255, 230, 57, 71),
                'Continue',
                () {
                  Navigator.of(context).pop();
                },
              );
            }
          },
          child: BlocBuilder<CustomerBloc, CustomerState>(
              builder: (context, state) {
            return Container(
              width: 360.w,
              height: 710.h,
              padding: EdgeInsets.symmetric(
                horizontal: 24.w,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 8.h,
                    ),
                    EditPassword(
                      controller: _passwordController,
                      title: "Old password",
                      borderColor: const Color.fromARGB(255, 148, 141, 246),
                      errorText: _isInCorrectOldPassword
                          ? 'Old password is incorrect'
                          : null,
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    EditPassword(
                      controller: _newPasswordController,
                      title: "New password",
                      borderColor: const Color.fromARGB(255, 148, 141, 246),
                      errorText: _isUnChecked ? errorText : null,
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    EditPassword(
                      controller: _confirmPasswordController,
                      title: "Confirm new password",
                      borderColor: const Color.fromARGB(255, 148, 141, 246),
                      errorText: _isPasswordMismatch
                          ? 'Confirm password does not match the new password!'
                          : null,
                    ),
                    SizedBox(
                      height: 32.h,
                    ),
                    NormalButtonCustom(
                      name: "Save",
                      action: () {
                        _validateAndSave();
                      },
                      background: const Color.fromARGB(255, 84, 110, 255),
                    ),
                  ],
                ),
              ),
            );
          }),
        ));
  }
}
