import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static const String gender = 'gender';
  static const String age = 'age';
  static const String hobbies = 'hobbies';

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
}
