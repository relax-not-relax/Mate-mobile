import 'package:mate_project/helper/custom_exception.dart';
import 'package:mate_project/models/admin.dart';
import 'package:mate_project/models/response/CustomerResponse.dart';
import 'package:mate_project/models/staff.dart';

abstract class AuthenticationState {}

class RegisterInitial extends AuthenticationState {}

class SendCodeInitial extends AuthenticationState {}

class SendCodeLoading extends AuthenticationState {}

class SendCodeSucess extends AuthenticationState {
  final String code;
  SendCodeSucess(this.code);
}

class SendCodeFailure extends AuthenticationState {
  final CustomException error;
  SendCodeFailure(this.error);
}

class RegisterLoading extends AuthenticationState {}

class RegisterSuccess extends AuthenticationState {
  final CustomerResponse customer;

  RegisterSuccess(this.customer);
}

class RegisterFailure extends AuthenticationState {
  final String error;

  RegisterFailure(this.error);
}

class ConfirmCodeInitial extends AuthenticationState {}

class ConfirmCodeFailure extends AuthenticationState {
  final String error;
  ConfirmCodeFailure(this.error);
}

class ConfirmCodeSuccess extends AuthenticationState {}

class RegisterDone extends AuthenticationState {
  final CustomerResponse customerResponse;
  RegisterDone(this.customerResponse);
}

class RegisterFail extends AuthenticationState {}

class LoginSuccess extends AuthenticationState {
  final CustomerResponse customerResponse;

  LoginSuccess({required this.customerResponse});
}

class LoginGoogleSuccess extends AuthenticationState {
  final CustomerResponse customerResponse;

  LoginGoogleSuccess({required this.customerResponse});
}

class LoginGoogleNewSuccess extends AuthenticationState {
  final String email;
  final String googleId;

  LoginGoogleNewSuccess({required this.email, required this.googleId});
}

class LoginSuccessStaffAdmin extends AuthenticationState {
  final Staff staff;

  LoginSuccessStaffAdmin({required this.staff});
}

class LoginSuccessAdmin extends AuthenticationState {
  final Admin admin;

  LoginSuccessAdmin({required this.admin});
}

class LoginLoading extends AuthenticationState {}

class LoginFail extends AuthenticationState {
  final CustomException error;
  LoginFail({required this.error});
}

class LogoutLoading extends AuthenticationState {}

class LogoutSuccess extends AuthenticationState {}

class RegisterGoogleSuccess extends AuthenticationState {
  final CustomerResponse customer;

  RegisterGoogleSuccess({required this.customer});
}

class RegisterGoogleLoading extends AuthenticationState {}

class RegisterGoogleFailure extends AuthenticationState {
  final CustomException error;

  RegisterGoogleFailure({required this.error});
}
