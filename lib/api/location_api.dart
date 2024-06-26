import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:mate_project/models/location.dart';

class LocationApi {
  static Future<List<Location>> getLocation(String search) async {
    List<Location> result = [];
    try {
      final response = await http.get(
        Uri.parse(
            "https://nominatim.openstreetmap.org/search?addressdetails=1&q=$search&format=jsonv2&limit=1"),
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        print(jsonData);
        for (var element in jsonData) {
          result.add(Location.fromJson(element));
        }
        print(result);
        return result;
      } else {
        return [];
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return [];
  }
}
