import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';

import 'package:mate_project/helper/config.dart';
import 'package:mate_project/helper/sharedpreferenceshelper.dart';
import 'package:mate_project/models/attendance.dart';
import 'package:mate_project/models/response/TotalAttendance.dart';
import 'package:mate_project/models/room.dart';
import 'package:mate_project/models/staff.dart';

import 'package:mate_project/repositories/room_repo.dart';

class AttendanceRepo {
  DateTime firstDayOfWeek(DateTime date) {
    int daysFromMonday = date.weekday - DateTime.monday;
    return date.subtract(Duration(days: daysFromMonday));
  }

  int daysInMonth(DateTime date) {
    var firstDayOfNextMonth = (date.month < 12)
        ? DateTime(date.year, date.month + 1, 1)
        : DateTime(date.year + 1, 1, 1);
    var lastDayOfThisMonth = firstDayOfNextMonth.subtract(Duration(days: 1));
    return lastDayOfThisMonth.day;
  }

  int getDayOfYear(DateTime date) {
    int dayOfYear = 0;
    for (int i = 1; i < date.month; i++) {
      dayOfYear += DateTime(date.year, i + 1, 0).day;
    }
    dayOfYear += date.day;
    return dayOfYear;
  }

  Future<TotalAttendanceResponse?> GetTotalAttendance(
      {required int customerId}) async {
    var account = await SharedPreferencesHelper.getCustomer();
    final response = await http.get(
      Uri.parse("${Config.apiRoot}api/attendance/total/$customerId"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${account!.accessToken}',
      },
    );
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      TotalAttendanceResponse totalAttendanceResponse =
          TotalAttendanceResponse.fromJson(jsonData);
      return totalAttendanceResponse;
    } else {
      return null;
    }
  }

  Future<List<Attendance>> GetAttendanceByDay(
      {required DateTime startDate,
      required DateTime endDate,
      required int staffId}) async {
    String end = DateFormat("yyyy-MM-ddTHH:mm:ss.SSS").format(endDate);
    String start = DateFormat("yyyy-MM-ddTHH:mm:ss.SSS").format(startDate);
    var account = await SharedPreferencesHelper.getStaff();

    final response = await http.get(
      Uri.parse(
          "${Config.apiRoot}api/attendance?Page=1&PageSize=100&&EndDate=$end&SortType=1&StartDate=$start&StaffId=$staffId"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${account!.accessToken}',
      },
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      List<dynamic> listJson = jsonData['results'] as List<dynamic>? ?? [];
      List<Attendance> listAttendance = [];
      for (var element in listJson) {
        Attendance attendance = Attendance.fromJson(element);
        listAttendance.add(attendance);
      }
      return listAttendance;
    } else if (response.statusCode == 400) {
      final jsonData = json.decode(response.body);
      throw Exception(jsonData['error']);
    } else {
      throw Exception('System failure');
    }
  }

  Future<List<Attendance>> GetAttendanceOfCustomer(
      {required int pageSize,
      required int page,
      required int customerId,
      required int filterType}) async {
    print(page);
    print(pageSize);
    int day = (page - 1) * (pageSize / 2).ceil();
    DateTime now = DateTime.now();
    DateTime endOfDay = DateTime(now.year, now.month, now.day, 23, 59, 59);

    endOfDay = endOfDay.add(Duration(days: -day));
    String endDate = DateFormat("yyyy-MM-ddTHH:mm:ss.SSS").format(endOfDay);
    print(endDate);
    print(day);

    DateTime startOfDay;
    String startDate = "";
    var account = await SharedPreferencesHelper.getCustomer();

    switch (filterType) {
      case 0:
        //Alltime
        startDate = "";
        break;
      case 1:
        //this week
        DateTime firstDay = firstDayOfWeek(DateTime.now());
        startOfDay = DateTime(now.year, now.month, firstDay.day, 0, 0, 0);
        startDate =
            "&StartDate=${DateFormat("yyyy-MM-ddTHH:mm:ss.SSS").format(startOfDay)}";
        page = 1;
        pageSize = (endOfDay.difference(startOfDay).inDays + 1) * 2;
      case 2:
        //this month
        startOfDay = DateTime(now.year, now.month, 1, 0, 0, 0);
        startDate =
            "&StartDate=${DateFormat("yyyy-MM-ddTHH:mm:ss.SSS").format(startOfDay)}";
        page = 1;
        pageSize = (endOfDay.difference(startOfDay).inDays + 1) * 2;
      case 3:
        //this year
        startOfDay = DateTime(now.year, 1, 1, 0, 0, 0);
        startDate =
            "&StartDate=${DateFormat("yyyy-MM-ddTHH:mm:ss.SSS").format(startOfDay)}";
        page = 1;
        pageSize = (endOfDay.difference(startOfDay).inDays + 1) * 2;
    }
    print(
        "?Page=$page&PageSize=$pageSize&CustomerId=$customerId&EndDate=$endDate&SortType=1$startDate");
    final response = await http.get(
      Uri.parse(
          "${Config.apiRoot}api/attendance?Page=$page&PageSize=$pageSize&CustomerId=$customerId&EndDate=$endDate&SortType=1$startDate"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${account!.accessToken}',
      },
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      List<dynamic> listJson = jsonData['results'] as List<dynamic>? ?? [];
      List<Attendance> listAttendance = [];
      int idJson = 0;
      DateTime endDate = endOfDay;
      DateTime startDate =
          DateTime(endDate.year, endDate.month, endDate.day, 12, 00, 00);
      for (int i = 0; i < pageSize; i++) {
        Attendance attendance;
        if (listJson.isEmpty || idJson >= listJson.length) {
          attendance = Attendance(
              customer: null,
              roomId: 0,
              staff: Staff(
                  phoneNumber: "0929828328",
                  staffId: 0,
                  email: "admin@gmail.com",
                  fullName: "Admin",
                  avatar:
                      "https://firebasestorage.googleapis.com/v0/b/lottery-4803d.appspot.com/o/admin.png?alt=media&token=36c3bf42-b2b3-4742-bf5b-671f06926823",
                  status: true),
              attendanceId: 0,
              customerId: customerId,
              staffId: 0,
              checkDate: DateTime(1990, 1, 1, 12, 00, 00),
              status: 3);
        } else {
          attendance = Attendance.fromJson(listJson[idJson]);
        }

        if ((attendance.checkDate.isBefore(endOfDay) &&
            startDate.isBefore(attendance.checkDate))) {
          listAttendance.add(attendance);
          idJson++;
        } else {
          DateTime checkDate = startDate.add(const Duration(hours: 1));
          // checkDate.add(const Duration(hours: 1));
          Attendance attendanceAdd = Attendance(
              customer: null,
              roomId: 0,
              staff: Staff(
                  phoneNumber: "0929828328",
                  staffId: 0,
                  email: "admin@gmail.com",
                  fullName: "Admin",
                  avatar:
                      "https://firebasestorage.googleapis.com/v0/b/lottery-4803d.appspot.com/o/admin.png?alt=media&token=36c3bf42-b2b3-4742-bf5b-671f06926823",
                  status: true),
              attendanceId: 0,
              customerId: customerId,
              staffId: 0,
              checkDate: checkDate,
              status: 3);
          listAttendance.add(attendanceAdd);
        }
        endDate = endDate.add(const Duration(hours: -12));
        startDate = startDate.add(const Duration(hours: -12));
      }
      if (filterType != 0) {
        listAttendance.sort((a, b) => a.checkDate.compareTo(b.checkDate));
      }
      for (var element in listAttendance) {
        print(element.toJson().toString());
      }
      return listAttendance;
    } else if (response.statusCode == 400) {
      final jsonData = json.decode(response.body);
      throw Exception(jsonData['error']);
    } else {
      throw Exception('System failure');
    }
  }
}
