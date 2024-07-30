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
        listStaff.add(staff);
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
}
