import 'package:mate_project/helper/sharedpreferenceshelper.dart';
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
}
