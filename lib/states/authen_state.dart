import 'package:mate_project/helper/custom_exception.dart';
import 'package:mate_project/response/CustomerResponse.dart';

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

class LoginFail extends AuthenticationState {
  final CustomException error;

  LoginFail({required this.error});
}
