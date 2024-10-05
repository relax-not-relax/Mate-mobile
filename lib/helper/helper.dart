import 'package:mate_project/models/pack.dart';

class Helper {
  static String convertRoomToPackName(int roomId) {
    if (roomId == 1 || roomId == 2 || roomId == 3) {
      return "Gold";
    } else if (roomId == 4 || roomId == 5 || roomId == 6) {
      return "Silver";
    } else if (roomId == 7 || roomId == 8 || roomId == 9) {
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
        return "Iris";
      case 2:
        return "Peony";
      case 3:
        return "Lotus";
      case 4:
        return "Infinite Frontier";
      case 5:
        return "New Haven";
      case 6:
        return "Horizon Edge";
      case 7:
        return "HeartLink";
      case 8:
        return "TrueBond";
      case 9:
        return "DreamScape";
    }
    return "";
  }
}
