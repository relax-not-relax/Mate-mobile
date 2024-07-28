abstract class AuthenticationEvent {}

class RegisterPressed extends AuthenticationEvent {
  final String username;
  final String password;
  final String email;
  final String coinfirmPassword;

  RegisterPressed(
      {required this.username,
      required this.password,
      required this.email,
      required this.coinfirmPassword});
}

class ConfirmCodePressed extends AuthenticationEvent {
  final String code;
  final String codeConfirm;

  ConfirmCodePressed({required this.code, required this.codeConfirm});
}

class RegisterDonePressed extends AuthenticationEvent {
  final String fullname;
  final String password;
  final String email;

  RegisterDonePressed(
      {required this.fullname, required this.password, required this.email});
}

class LoginPressed extends AuthenticationEvent {
  final String email;
  final String password;
  final String fcm;
  final bool rememberCheck;

  LoginPressed(
      {required this.email,
      required this.password,
      required this.fcm,
      required this.rememberCheck});
}

class LoginStaffOrAdminPressed extends AuthenticationEvent {
  final String email;
  final String password;
  final String fcm;
  final bool rememberCheck;

  LoginStaffOrAdminPressed(
      {required this.email,
      required this.password,
      required this.fcm,
      required this.rememberCheck});
}

class LogoutPressed extends AuthenticationEvent {
  final int customerId;

  LogoutPressed({required this.customerId});
}
