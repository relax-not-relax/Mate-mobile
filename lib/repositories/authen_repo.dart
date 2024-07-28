import 'package:http/http.dart' as http;
import 'package:mate_project/enums/failure_enum.dart';
import 'dart:convert';

import 'package:mate_project/helper/config.dart';
import 'package:mate_project/helper/custom_exception.dart';
import 'package:mate_project/helper/sharedpreferenceshelper.dart';
import 'package:mate_project/models/customer.dart';
import 'package:mate_project/models/pack.dart';
import 'package:mate_project/models/response/CustomerResponse.dart';
import 'package:mate_project/models/staff.dart';

class Authenrepository {
  bool isValidEmail(String email) {
    final RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }

  bool isValidPassword(String password) {
    final RegExp passwordRegex = RegExp(
      r'^(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*(),.?":{}|<>]).+$',
    );
    return passwordRegex.hasMatch(password);
  }

  Future<CustomerResponse> register(
      {required String fullName,
      required String email,
      required String password,
      required String confirmPass}) async {
    Map<String, String> data = {
      "email": email,
      "password": password,
      "fullname": fullName
    };

    String jsonBody = jsonEncode(data);
    final response = await http.post(
      Uri.parse("${Config.apiRoot}api/customer"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonBody,
    );
    print(jsonBody);
    if (response.statusCode == 200) {
      print('ok');
      final jsonData = json.decode(response.body);
      print(CustomerResponse.fromJson(jsonData).toJson().toString());
      return CustomerResponse.fromJson(jsonData);
    } else {
      throw Exception('Failed to register');
    }
  }

  Future<String> verifyCustomerEmail(
      {required String fullName,
      required String email,
      required String password,
      required String confirmPass}) async {
    if (fullName.trim().isEmpty) {
      throw CustomException(
          type: Failure.Fullname, content: 'Fullname is required');
    }
    if (password.contains(' ')) {
      throw CustomException(
          type: Failure.Password,
          content: 'Password must be not contain space');
    }
    if (password.length > 30 || password.length < 8) {
      throw CustomException(
          type: Failure.Password,
          content: "Password's length is between 8 - 30 character");
    }
    if (!isValidPassword(password)) {
      throw CustomException(
          type: Failure.Password,
          content:
              'Password must contain number, uppercase character, special character');
    }

    if (!(password == confirmPass)) {
      throw CustomException(
          type: Failure.ConfirmPasssword,
          content: 'Confirmation passwors does not match');
    }
    if (!isValidEmail(email)) {
      throw CustomException(type: Failure.Email, content: 'Invalid email');
    }
    if (fullName.length > 200) {
      throw CustomException(
          type: Failure.Fullname,
          content: 'Full Name must be less than 200 character');
    }

    final response = await http.get(
        Uri.parse('${Config.apiRoot}api/customer/Verify-Email-Customer/$email'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });
    if (response.statusCode == 200) {
      SharedPreferencesHelper.setRegisterInformation(password, fullName, email);
      return response.body;
    } else if (response.statusCode == 400) {
      final jsonData = json.decode(response.body);
      throw Exception(jsonData['error']);
    } else {
      throw Exception('System failure');
    }
  }

  Future<Staff> authenStaff(
      {required String email,
      required String password,
      required String fcm}) async {
    if ((email.trim().isEmpty)) {
      throw CustomException(type: Failure.Email, content: 'Please enter email');
    }
    if ((password.trim().isEmpty)) {
      throw CustomException(
          type: Failure.Password, content: 'Please enter password');
    }
    if (!isValidEmail(email)) {
      throw CustomException(type: Failure.Email, content: 'Invalid email');
    }

    Map<String, String> data = {
      "email": email,
      "password": password,
      "fcm": fcm
    };

    String jsonBody = jsonEncode(data);

    final response = await http.post(
        Uri.parse('${Config.apiRoot}api/authen/Authentication-Staff'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonBody);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      Staff staff = Staff.fromJson(jsonData);
      print(staff.toJson());
      await SharedPreferencesHelper.setStaff(staff);
      return staff;
    } else if (response.statusCode == 400) {
      final jsonData = json.decode(response.body);
      throw Exception(jsonData['error']);
    } else {
      throw Exception('System failure');
    }
  }

  Future<CustomerResponse> authenCustomer(
      {required String email,
      required String password,
      required String fcm}) async {
    if ((email.trim().isEmpty)) {
      throw CustomException(type: Failure.Email, content: 'Please enter email');
    }
    if ((password.trim().isEmpty)) {
      throw CustomException(
          type: Failure.Password, content: 'Please enter password');
    }
    if (!isValidEmail(email)) {
      throw CustomException(type: Failure.Email, content: 'Invalid email');
    }

    Map<String, String> data = {
      "email": email,
      "password": password,
      "fcm": fcm
    };

    String jsonBody = jsonEncode(data);

    final response = await http.post(
        Uri.parse('${Config.apiRoot}api/authen/Authentication-Customer'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonBody);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      CustomerResponse customer = CustomerResponse.fromJson(jsonData);
      print(customer.toJson());
      await SharedPreferencesHelper.setCustomer(customer);
      return customer;
    } else if (response.statusCode == 400) {
      final jsonData = json.decode(response.body);
      throw Exception(jsonData['error']);
    } else {
      throw Exception('System failure');
    }
  }

  Future<void> LogoutCustomer({required int customerId}) async {
    var account = await SharedPreferencesHelper.getCustomer();
    final response = await http.post(
        Uri.parse(
            "${Config.apiRoot}api/authen/Revoke-Token-Customer/$customerId"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${account!.accessToken}',
        });
    print(response.statusCode);
    print(customerId);
    print(account.accessToken);
  }
}
