class NotificationStaff {
  final DateTime time;
  final int staffId;
  final String title;
  final String content;
  final bool isNew;

  NotificationStaff({
    required this.time,
    required this.staffId,
    required this.title,
    required this.content,
    required this.isNew,
  });

  // Phương thức fromJson
  factory NotificationStaff.fromJson(Map<String, dynamic> json) {
    return NotificationStaff(
      time: DateTime.parse(json['time']), // Chuyển đổi từ chuỗi sang DateTime
      staffId: json['staffId'],
      title: json['title'],
      content: json['content'],
      isNew: json['isNew'],
    );
  }

  // Phương thức toJson
  Map<String, dynamic> toJson() {
    return {
      'time': time.toIso8601String(), // Chuyển đổi từ DateTime sang chuỗi
      'staffId': staffId,
      'title': title,
      'content': content,
      'isNew': isNew,
    };
  }
}
