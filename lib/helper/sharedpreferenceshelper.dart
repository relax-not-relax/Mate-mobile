import 'dart:convert';

import 'package:mate_project/models/admin.dart';
import 'package:mate_project/models/analysis_response.dart';
import 'package:mate_project/models/pack.dart';
import 'package:mate_project/models/rememberme.dart';
import 'package:mate_project/models/response/CustomerResponse.dart';
import 'package:mate_project/models/staff.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static const String gender = 'gender';
  static const String age = 'age';
  static const String hobbies = 'hobbies';
  static const String pack = 'pack';
  static const String REGISTER_KEY = "register";
  static const String CUSTOMER_KEY = "customer";
  static const String STAFF_KEY = "staff";
  static const String ADMIN_KEY = "admin";
  static const String REMEMBER_KEY = "rememberme";
  static const String REMEMBER_STAFF_ADMIN_KEY = "rememberstaffadmin";
  static const String STATISTICS = "statistics";

  static Future<List<AnalysisResult>> getAnalysisResults() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString(STATISTICS);

    if (jsonString != null) {
      List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList.map((e) => AnalysisResult.fromJson(e)).toList();
    }
    return [];
  }

  static Future<AnalysisResult?> getAnalysisResultsByTime(
      int month, int year) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString(STATISTICS);

    if (jsonString != null) {
      List<dynamic> jsonList = jsonDecode(jsonString);
      List<AnalysisResult> list =
          jsonList.map((e) => AnalysisResult.fromJson(e)).toList();
      return list
          .where((e) =>
              e.listCashFlow.isNotEmpty &&
              e.listCashFlow.first.time.month == month &&
              e.listCashFlow.first.time.year == year)
          .firstOrNull;
    }
    return null;
  }

  static Future<void> addAnalysisResults(List<AnalysisResult> results) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<AnalysisResult> listPre = await getAnalysisResults();
    if (listPre.isNotEmpty) {
      results.addAll(listPre);
    }
    String jsonString = jsonEncode(results.map((e) => e.toJson()).toList());
    await prefs.setString(STATISTICS, jsonString);
  }

  static Future<void> setRememberMe(String password, String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, String> data = {"email": email, "password": password};

    String jsonBody = jsonEncode(data);
    prefs.setString(REMEMBER_KEY, jsonBody);
  }

  static Future<Rememberme?> getRememberMe() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonS = prefs.getString(REMEMBER_KEY);
    if (jsonS != null) {
      final jsonData = json.decode(jsonS);
      return Rememberme.fromJson(jsonData);
    } else {
      return null;
    }
  }

  static Future<void> setRememberStaffAdmin(
      String password, String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, String> data = {"email": email, "password": password};

    String jsonBody = jsonEncode(data);
    prefs.setString(REMEMBER_STAFF_ADMIN_KEY, jsonBody);
  }

  static Future<Rememberme?> getRememberStaffAdmin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonS = prefs.getString(REMEMBER_STAFF_ADMIN_KEY);
    if (jsonS != null) {
      final jsonData = json.decode(jsonS);
      return Rememberme.fromJson(jsonData);
    } else {
      return null;
    }
  }

  static Future<void> removeRemember() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(REMEMBER_KEY);
  }

  static Future<void> setRegisterInformation(
      String password, String fullname, String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, String> data = {
      "email": email,
      "password": password,
      "fullname": fullname
    };

    String jsonBody = jsonEncode(data);
    prefs.setString(REGISTER_KEY, jsonBody);
  }

  static Future<String> getRegisterInformation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? json = prefs.getString(REGISTER_KEY);
    if (json != null) {
      return json;
    } else {
      return '';
    }
  }

  static Future<void> removeRegisterInformation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(REGISTER_KEY);
  }

  static Future<void> setCustomer(CustomerResponse customer) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String jsonBody = jsonEncode(customer);
      prefs.setString(CUSTOMER_KEY, jsonBody);
    } catch (error) {
      print(error.toString());
    }
  }

  static Future<CustomerResponse?> getCustomer() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? json = prefs.getString(CUSTOMER_KEY);

    if (json != null) {
      CustomerResponse rs = CustomerResponse.fromJson(jsonDecode(json));
      return rs;
    } else {
      return null;
    }
  }

  static Future<void> setStaff(Staff staff) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String jsonBody = jsonEncode(staff);
      prefs.setString(STAFF_KEY, jsonBody);
    } catch (error) {
      print(error.toString());
    }
  }

  static Future<Staff?> getStaff() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? json = prefs.getString(STAFF_KEY);

    if (json != null) {
      Staff rs = Staff.fromJson(jsonDecode(json));
      return rs;
    } else {
      return null;
    }
  }

  static Future<void> setAdmin(Admin admin) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String jsonBody = jsonEncode(admin);
      prefs.setString(ADMIN_KEY, jsonBody);
    } catch (error) {
      print(error.toString());
    }
  }

  static Future<Admin?> getAdmin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? json = prefs.getString(ADMIN_KEY);

    if (json != null) {
      Admin rs = Admin.fromJson(jsonDecode(json));
      return rs;
    } else {
      return null;
    }
  }

  static Future<void> removeCustomer() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(CUSTOMER_KEY);
  }

  static Future<void> removeStaff() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(STAFF_KEY);
  }

  static Future<void> removeAdmin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(ADMIN_KEY);
  }

  static Future<void> setGender(String genderSelection) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(gender, genderSelection);
  }

  static Future<String> getGender() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? genderSelected = prefs.getString(gender);
    if (genderSelected != null) {
      return genderSelected;
    } else {
      return '';
    }
  }

  static Future<void> setAge(String dateSelected) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(age, dateSelected);
  }

  static Future<String> getAge() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? ageSelected = prefs.getString(age);
    if (ageSelected != null) {
      return ageSelected;
    } else {
      return '';
    }
  }

  static Future<void> setHobbies(List<String> hobbyList) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList(hobbies, hobbyList);
  }

  static Future<List<String>> getHobbies() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? hobbyList = prefs.getStringList(hobbies);
    if (hobbyList != null) {
      return hobbyList;
    } else {
      return [];
    }
  }

  static Future<void> setPack(Pack packChosen) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String packJson = jsonEncode(packChosen.toJson());
    prefs.setString(pack, packJson);
  }

  static Future<Pack?> getPack() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? packJson = prefs.getString(pack);

    if (packJson != null) {
      Map<String, dynamic> packMap = jsonDecode(packJson);
      return Pack.fromJson(packMap);
    } else {
      return null;
    }
  }
}
