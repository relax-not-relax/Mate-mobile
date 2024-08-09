class Event {
  int eventId;
  String title;
  String description;
  String imageLink;
  DateTime startTime;
  DateTime endTime;

  Event({
    required this.eventId,
    required this.title,
    required this.description,
    required this.imageLink,
    required this.startTime,
    required this.endTime,
  });

  // Phương thức fromJson để chuyển đổi từ JSON thành đối tượng Event
  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      eventId: json['eventId'],
      title: json['title'],
      description: json['description'],
      imageLink: json['imageLink'],
      startTime: DateTime.parse(json['startTime']),
      endTime: DateTime.parse(json['endTime']),
    );
  }

  // Phương thức toJson để chuyển đổi từ đối tượng Event thành JSON
  Map<String, dynamic> toJson() {
    return {
      'eventId': eventId,
      'title': title,
      'description': description,
      'imageLink': imageLink,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
    };
  }
}
