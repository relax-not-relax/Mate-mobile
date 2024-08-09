import 'package:intl/intl.dart';
import 'package:mate_project/enums/failure_enum.dart';
import 'package:mate_project/helper/custom_exception.dart';
import 'package:mate_project/helper/sharedpreferenceshelper.dart';
import 'package:mate_project/models/request/password_request.dart';
import 'package:mate_project/models/request/update_staff_request.dart';
import 'package:mate_project/models/staff.dart';
import 'package:mate_project/models/room.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mate_project/helper/config.dart';

class StaffRepository {
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

  Future<Staff?> GetStaff({required int staffId}) async {
    var account = await SharedPreferencesHelper.getCustomer();

    final response = await http.get(
      Uri.parse("${Config.apiRoot}api/staff/$staffId"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${account!.accessToken}',
      },
    );
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      Staff staff = Staff.fromJson(jsonData);
      return staff;
    } else {
      return null;
    }
  }

  Future<void> changePassword({required PasswordRequest data}) async {
    var account = await SharedPreferencesHelper.getStaff();
    String jsonBody = jsonEncode(data);
    final response = await http.put(
      Uri.parse(
          "${Config.apiRoot}api/staff/Change-Password/${account!.staffId}"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${account.accessToken}',
      },
      body: jsonBody,
    );
    if (response.statusCode == 200) {
      return;
    } else if (response.statusCode == 400) {
      final jsonData = json.decode(response.body);
      throw CustomException(type: Failure.Password, content: jsonData['error']);
    } else {
      throw Exception('System failure');
    }
  }

  Future<Staff?> GetStaffOfRoom({required int roomId}) async {
    var account = await SharedPreferencesHelper.getCustomer();
    final response = await http.get(
      Uri.parse("${Config.apiRoot}api/staff/byRoomId/$roomId"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${account!.accessToken}',
      },
    );
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      Staff staff = Staff.fromJson(jsonData);
      return staff;
    } else {
      return null;
    }
  }

  Future<bool> deactiveStaff(int staffId) async {
    var account = await SharedPreferencesHelper.getAdmin();
    final response = await http.put(
        Uri.parse('${Config.apiRoot}api/staff/Ban/$staffId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${account!.accessToken}',
        });

    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 400) {
      return false;
    } else {
      return false;
    }
  }

  Future<List<Staff>> GetStaffByAdmin(
      {required int page, required int pageSize}) async {
    var account = await SharedPreferencesHelper.getAdmin();

    final response = await http.get(
      Uri.parse(
          "${Config.apiRoot}api/staff?Page=$page&PageSize=$pageSize&SortType=0"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${account!.accessToken}',
      },
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      List<dynamic> listJson = jsonData['results'] as List<dynamic>? ?? [];
      List<Staff> listStaff = [];
      for (var element in listJson) {
        Staff staff = Staff.fromJson(element);
        if (staff.status != null && staff.status == true) {
          listStaff.add(staff);
        }
      }
      return listStaff;
    } else if (response.statusCode == 400) {
      final jsonData = json.decode(response.body);
      throw Exception(jsonData['error']);
    } else {
      throw Exception('System failure');
    }
  }

  Future<Staff> UpdateInformation(
      {required UpdateStaffRequest data, required int staffId}) async {
    if ((data.fullname.trim().isEmpty)) {
      throw CustomException(
          type: Failure.Fullname, content: 'Please enter fullname');
    }
    if ((data.phoneNumber.trim().isEmpty)) {
      throw CustomException(
          type: Failure.PhoneNumber, content: 'Please enter phone number');
    }
    if (DateFormat('yyyy-MM-dd')
        .parse(data.dateOfBirth)
        .isAfter(DateTime.now())) {
      throw CustomException(
          type: Failure.Birthday, content: 'Invalid birthday');
    }

    var account = await SharedPreferencesHelper.getStaff();
    String jsonBody = jsonEncode(data);
    final response = await http.put(
      Uri.parse("${Config.apiRoot}api/staff/$staffId"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${account!.accessToken}',
      },
      body: jsonBody,
    );
    print(response.statusCode);
    print(jsonBody);
    print(account.accessToken);
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return Staff.fromJson(jsonData);
    } else if (response.statusCode == 400) {
      final jsonData = json.decode(response.body);
      throw Exception(jsonData['error']);
    } else {
      throw Exception('System failure');
    }
  }

  Future<Staff> CreateStaff(
      {required String fullName,
      required String email,
      required String password}) async {
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

    if (!isValidEmail(email)) {
      throw CustomException(type: Failure.Email, content: 'Invalid email');
    }
    if (fullName.length > 200) {
      throw CustomException(
          type: Failure.Fullname,
          content: 'Full Name must be less than 200 character');
    }
    var account = await SharedPreferencesHelper.getAdmin();
    Map<String, String> data = {
      "email": email,
      "password": password,
      "fullname": fullName,
      "gender": "Male"
    };
    String jsonBody = jsonEncode(data);
    final response = await http.post(
      Uri.parse("${Config.apiRoot}api/staff"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${account!.accessToken}',
      },
      body: jsonBody,
    );
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return Staff.fromJson(jsonData);
    } else if (response.statusCode == 400) {
      final jsonData = json.decode(response.body);
      throw CustomException(type: Failure.System, content: jsonData['error']);
    } else {
      throw CustomException(type: Failure.System, content: 'System failure');
    }
  }
}
