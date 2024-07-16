class Message {
  final String avatar;
  final String name;
  final String lastMessage;
  final DateTime time;
  final bool isAdmin;
  bool? status;

  Message({
    required this.avatar,
    required this.name,
    required this.lastMessage,
    required this.time,
    required this.isAdmin,
    this.status,
  });
}
