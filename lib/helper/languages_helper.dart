import 'dart:convert';

import 'package:mate_project/helper/sharedpreferenceshelper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguagesHelper {
  // Private constructor
  LanguagesHelper._();

  // Singleton instance
  static final LanguagesHelper _instance = LanguagesHelper._();

  // Factory constructor to return the singleton instance
  factory LanguagesHelper() => _instance;

  // Static default language
  static String lg = 'vi';

  // Sample multi-language strings
  static MultiLanguages accountLogin =
      MultiLanguages(vi: 'Đăng nhập tài khoản', en: 'Account Login');

  // Method to get string based on the current language
  String getString(MultiLanguages ml) {
    print(lg);
    if (lg == 'vi') {
      return ml.vi;
    } else {
      return ml.en;
    }
  }
}

class MultiLanguages {
  final String vi;
  final String en;

  MultiLanguages({required this.vi, required this.en});
}
