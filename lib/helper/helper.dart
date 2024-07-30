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
}
