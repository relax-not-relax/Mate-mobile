class ProjectData {
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
}
