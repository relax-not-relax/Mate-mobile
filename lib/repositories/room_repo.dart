import 'package:mate_project/models/room.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mate_project/helper/config.dart';
import 'package:mate_project/helper/sharedpreferenceshelper.dart';

class RoomRepository {
  Future<Room?> GetRoom({required int roomId}) async {
    var account = await SharedPreferencesHelper.getCustomer();
    final response = await http.get(
      Uri.parse("${Config.apiRoot}api/room/$roomId"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${account!.accessToken}',
      },
    );
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      Room room = Room.fromJson(jsonData);
      return room;
    } else {
      return null;
    }
  }

  Future<Room?> GetRoomStaff({required int roomId}) async {
    var account = await SharedPreferencesHelper.getStaff();
    final response = await http.get(
      Uri.parse("${Config.apiRoot}api/room/$roomId"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${account!.accessToken}',
      },
    );
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      Room room = Room.fromJson(jsonData);
      return room;
    } else {
      return null;
    }
  }
}
