import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mate_project/models/facility.dart';
import 'package:mate_project/models/language.dart';
import 'package:unicons/unicons.dart';

class ProjectData {
  static List<Language> languages = [
    const Language(
      countryCode: "US",
      language: "English (United States)",
    ),
    const Language(
      countryCode: "VN",
      language: "Vietnamese",
    ),
  ];

  static List<String> hobbyChoice = [
    "Play chess",
    "Listening to music",
    "Playing musical instruments",
    "Trekking",
    "Seeing relatives",
    "Cooking",
    "Chatting or talking with peers",
    "Gardening",
    "Reading books",
    "Yoga",
    "Watching news",
    "Reading newspaper",
    "Watching movies",
    "Taking a long nap",
    "Making artworks",
    "Bird-watching",
    "Taking photos",
    "Social interaction",
  ];

  static List<String> benefits(int id) {
    switch (id) {
      case 1:
        return [
          "Single room",
          "Service available: Massage, Assistance in organizing special events",
          "TV available in the room",
          "High - quality dishes (buffet)"
        ];
      case 2:
        return [
          "Two-beds room",
          "Service available: Massage, Assistance in organizing special events",
          "TV available in the room",
          "Delicious food",
        ];
      case 3:
        return [
          "Room for 3-5 people",
          "TV available in the room",
          "Good food",
        ];
      default:
        return [];
    }
  }

  static List<String> roomDetails(int id) {
    switch (id) {
      case 1:
        return [
          "assets/pics/vip_room_1.png",
          "assets/pics/vip_room_2.png",
          "assets/pics/massage.png",
          "assets/pics/organize.png",
          "assets/pics/gold_dishes.png",
          "assets/pics/gold_dishes_1.png"
        ];
      case 2:
        return [
          "assets/pics/vip_room_1.png",
          "assets/pics/vip_room_2.png",
          "assets/pics/massage.png",
          "assets/pics/organize.png",
          "assets/pics/delicious_dishes.png",
        ];
      case 3:
        return [
          "assets/pics/bronze_room.png",
          "assets/pics/good_dishes.png",
        ];
      default:
        return [];
    }
  }

  static List<Facility> roomFacilities(int id) {
    switch (id) {
      case 1:
        return [
          Facility(
            icon: Icon(
              UniconsLine.bed,
              color: const Color.fromARGB(255, 84, 87, 91),
              size: 22.sp,
            ),
            title: "Single-room",
          ),
          Facility(
            icon: Icon(
              UniconsLine.tv_retro,
              color: const Color.fromARGB(255, 84, 87, 91),
              size: 22.sp,
            ),
            title: "Television available",
          ),
          Facility(
            icon: Icon(
              UniconsLine.fire,
              color: const Color.fromARGB(255, 84, 87, 91),
              size: 22.sp,
            ),
            title: "Various services",
          ),
          Facility(
            icon: Icon(
              UniconsLine.utensils,
              color: const Color.fromARGB(255, 84, 87, 91),
              size: 22.sp,
            ),
            title: "Buffet available",
          ),
        ];
      case 2:
        return [
          Facility(
            icon: Icon(
              UniconsLine.bed_double,
              color: const Color.fromARGB(255, 84, 87, 91),
              size: 22.sp,
            ),
            title: "Double-room",
          ),
          Facility(
            icon: Icon(
              UniconsLine.tv_retro,
              color: const Color.fromARGB(255, 84, 87, 91),
              size: 22.sp,
            ),
            title: "Television available",
          ),
          Facility(
            icon: Icon(
              UniconsLine.fire,
              color: const Color.fromARGB(255, 84, 87, 91),
              size: 22.sp,
            ),
            title: "Various services",
          ),
          Facility(
            icon: Icon(
              UniconsLine.utensils,
              color: const Color.fromARGB(255, 84, 87, 91),
              size: 22.sp,
            ),
            title: "Delicious dishes",
          ),
        ];
      case 3:
        return [
          Facility(
            icon: Icon(
              UniconsLine.bed_double,
              color: const Color.fromARGB(255, 84, 87, 91),
              size: 22.sp,
            ),
            title: "Room for 3-5 people",
          ),
          Facility(
            icon: Icon(
              UniconsLine.tv_retro,
              color: const Color.fromARGB(255, 84, 87, 91),
              size: 22.sp,
            ),
            title: "Television available",
          ),
          Facility(
            icon: Icon(
              UniconsLine.utensils,
              color: const Color.fromARGB(255, 84, 87, 91),
              size: 22.sp,
            ),
            title: "Good dishes",
          ),
        ];
      default:
        return [];
    }
  }

  static List<Color> getGradient(int packId) {
    switch (packId) {
      case 1:
        return [
          const Color.fromARGB(255, 24, 22, 14),
          const Color.fromARGB(255, 255, 223, 150),
        ];
      case 2:
        return [
          const Color.fromARGB(255, 24, 22, 14),
          const Color.fromARGB(255, 205, 205, 233),
        ];
      case 3:
        return [
          const Color.fromARGB(255, 24, 22, 14),
          const Color.fromARGB(255, 249, 161, 89),
        ];
      default:
        return [];
    }
  }
}
