import 'dart:async';
import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mate_project/enums/failure_enum.dart';
import 'package:mate_project/events/authen_event.dart';
import 'package:mate_project/helper/custom_exception.dart';
import 'package:mate_project/helper/sharedpreferenceshelper.dart';
import 'package:mate_project/repositories/authen_repo.dart';
import 'package:mate_project/models/response/CustomerResponse.dart';
import 'package:mate_project/states/authen_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final Authenrepository authenticationRepository;

  AuthenticationBloc({required this.authenticationRepository})
      : super(RegisterInitial()) {
    on<RegisterPressed>(_onRegisterPressed);
    on<ConfirmCodePressed>(_onConfirmCodePressed);
    on<RegisterDonePressed>(_onRegisterDonePressed);
    on<LoginPressed>(_onLoginPressed);
  }
  Future<void> _onRegisterPressed(
      RegisterPressed event, Emitter<AuthenticationState> emit) async {
    emit(SendCodeLoading());

    try {
      final code = await authenticationRepository.verifyCustomerEmail(
          email: event.email,
          confirmPass: event.coinfirmPassword,
          password: event.password,
          fullName: event.username);
      SharedPreferencesHelper.setRegisterInformation(
          event.password, event.username, event.email);
      emit(SendCodeSucess(code));
    } catch (error) {
      if (error is CustomException) {
        emit(SendCodeFailure(error));
      } else {
        emit(SendCodeFailure(
            CustomException(type: Failure.System, content: error.toString())));
      }
    }
  }

  Future<void> _onConfirmCodePressed(
      ConfirmCodePressed event, Emitter<AuthenticationState> emit) async {
    emit(ConfirmCodeInitial());

    try {
      if (event.code == event.codeConfirm) {
        emit(ConfirmCodeSuccess());
      } else {
        throw CustomException(
            type: Failure.ConfirmMail, content: 'Code is incorrect!');
      }
    } catch (error) {
      if (error is CustomException) {
        emit(ConfirmCodeFailure(error.content));
      } else {
        emit(SendCodeFailure(
            CustomException(type: Failure.System, content: error.toString())));
      }
    }
  }

  FutureOr<void> _onRegisterDonePressed(
      RegisterDonePressed event, Emitter<AuthenticationState> emit) async {
    try {
      CustomerResponse cus = await authenticationRepository.register(
          fullName: event.fullname,
          email: event.email,
          password: event.password,
          confirmPass: event.password);
      emit(RegisterDone(cus));
    } catch (error) {
      if (error is CustomException) {
        emit(RegisterFail());
      } else {
        emit(RegisterFail());
      }
    }
  }

  FutureOr<void> _onLoginPressed(
      LoginPressed event, Emitter<AuthenticationState> emit) async {
    emit(LoginLoading());
    try {
      CustomerResponse customer = await authenticationRepository.authenCustomer(
          email: event.email, password: event.password, fcm: event.fcm);
      if (event.rememberCheck) {
        await SharedPreferencesHelper.setRememberMe(
            event.password, event.email);
      }
      emit(LoginSuccess(customerResponse: customer));
    } catch (error) {
      if (error is CustomException) {
        emit(LoginFail(error: error));
      } else {
        emit(LoginFail(
            error: CustomException(
                type: Failure.System, content: error.toString())));
      }
    }
  }
}
