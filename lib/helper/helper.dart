import 'package:mate_project/models/pack.dart';

class Helper {
  static String convertRoomToPackName(int roomId) {
    if (roomId == 1 || roomId == 2) {
      return "Gold";
    } else if (roomId == 3 || roomId == 4) {
      return "Silver";
    } else if (roomId == 5 || roomId == 6) {
      return "Bronze";
    } else {
      return "No";
    }
  }

  static Pack? getPackFromId(int packId) {
    switch (packId) {
      case 1:
        return Pack(
            packId: 1,
            price: 289,
            packName: "Gold Room",
            description: "",
            duration: 12,
            status: true);
      case 2:
        return Pack(
            packId: 2,
            price: 199,
            packName: "Silver Room",
            description: "",
            duration: 12,
            status: true);
      case 3:
        return Pack(
            packId: 3,
            price: 99,
            packName: "Bronze Room",
            description: "",
            duration: 12,
            status: true);
    }
    return null;
  }

  static String getRoomName(int roomId) {
    switch (roomId) {
      case 1:
        return "Sunflower";
      case 2:
        return "Lily";
      case 3:
        return "Soulmate";
      case 4:
        return "F4 plus";
      case 5:
        return "New Zone";
      case 6:
        return "New World";
    }
    return "";
  }
}
