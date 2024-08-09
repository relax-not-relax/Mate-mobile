import 'dart:convert';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:mate_project/enums/failure_enum.dart';
import 'package:mate_project/helper/config.dart';
import 'package:mate_project/helper/custom_exception.dart';
import 'package:mate_project/helper/sharedpreferenceshelper.dart';
import 'package:mate_project/models/event.dart';

class EventRepository {
  DateTime getEndOfMonth(DateTime startDate) {
    int year = startDate.year;
    int month = startDate.month;

    DateTime firstDayNextMonth =
        (month < 12) ? DateTime(year, month + 1, 1) : DateTime(year + 1, 1, 1);

    DateTime lastDayOfMonth =
        firstDayNextMonth.subtract(const Duration(days: 1));

    DateTime result = DateTime(lastDayOfMonth.year, lastDayOfMonth.month,
        lastDayOfMonth.day, 23, 59, 59);
    return result;
  }

  Future<Event> CreateEvent(
      {required String title,
      required DateTime startDate,
      required String description,
      required File image}) async {
    if (title.trim().isEmpty) {
      throw CustomException(type: Failure.System, content: 'Title is required');
    }
    if (title.length > 200) {
      throw CustomException(
          type: Failure.Fullname,
          content: 'Title must be less than 200 character');
    }
    if (description.trim().isEmpty) {
      throw CustomException(
          type: Failure.System, content: 'Description is required');
    }
    if (description.length > 200) {
      throw CustomException(
          type: Failure.Fullname,
          content: 'Description must be less than 200 character');
    }

    String startDateS = DateFormat("yyyy-MM-ddTHH:mm:ss.SSS").format(startDate);
    String endDateS =
        DateFormat("yyyy-MM-ddTHH:mm:ss.SSS").format(getEndOfMonth(startDate));

    final storageRef = FirebaseStorage.instance
        .ref()
        .child('uploads/${DateTime.now().millisecondsSinceEpoch}.png');
    final uploadTask = storageRef.putFile(image);

    final snapshot = await uploadTask.whenComplete(() => null);
    final downloadURL = await snapshot.ref.getDownloadURL();

    var account = await SharedPreferencesHelper.getAdmin();
    Map<String, String> data = {
      "title": title,
      "description": description,
      "imageLink": downloadURL,
      "startTime": startDateS,
      "endTime": endDateS
    };
    String jsonBody = jsonEncode(data);
    final response = await http.post(
      Uri.parse("${Config.apiRoot}api/event"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${account!.accessToken}',
      },
      body: jsonBody,
    );
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return Event.fromJson(jsonData);
    } else if (response.statusCode == 400) {
      final jsonData = json.decode(response.body);
      throw CustomException(type: Failure.System, content: jsonData['error']);
    } else {
      throw CustomException(type: Failure.System, content: 'System failure');
    }
  }

  Future<List<Event>> GetAllEvent() async {
    var account = await SharedPreferencesHelper.getAdmin();
    var accountCustomer = await SharedPreferencesHelper.getCustomer();
    String? token =
        account != null ? account.accessToken : accountCustomer!.accessToken;

    final response = await http.get(
      Uri.parse("${Config.apiRoot}api/event?Status=true&Page=1&PageSize=10000"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${token}',
      },
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      List<dynamic> listJson = jsonData['results'] as List<dynamic>? ?? [];
      List<Event> listStaff = [];
      for (var element in listJson) {
        Event event = Event.fromJson(element);
        listStaff.add(event);
      }
      return listStaff;
    } else if (response.statusCode == 400) {
      final jsonData = json.decode(response.body);
      throw Exception(jsonData['error']);
    } else {
      throw Exception('System failure');
    }
  }
}
