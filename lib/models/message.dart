class Message {
  final String avatar;
  final String name;
  final String lastMessage;
  final DateTime time;
  final bool isAdmin;
  bool? status;
  final int customerId;

  Message({
    required this.customerId,
    required this.avatar,
    required this.name,
    required this.lastMessage,
    required this.time,
    required this.isAdmin,
    this.status,
  });

  // Chuyển đổi từ đối tượng Message thành Map<String, dynamic>
  Map<String, dynamic> toJson() => {
        'avatar': avatar,
        'name': name,
        'lastMessage': lastMessage,
        'time':
            time.toIso8601String(), // Chuyển đổi DateTime thành chuỗi ISO 8601
        'isAdmin': isAdmin,
        'status': status,
        'customerId': customerId,
      };

  // Tạo đối tượng Message từ Map<String, dynamic>
  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      customerId: json['customerId'] as int,
      avatar: json['avatar'] as String,
      name: json['name'] as String,
      lastMessage: json['lastMessage'] as String,
      time: DateTime.parse(
          json['time'] as String), // Chuyển đổi chuỗi ISO 8601 thành DateTime
      isAdmin: json['isAdmin'] as bool,
      status: json['status'] as bool?,
    );
  }
}
