class ChatMessage {
  int? customerId;
  bool isAdmin;
  String message;

  ChatMessage({
    required this.isAdmin,
    required this.message,
    required this.customerId,
  });

  // Phương thức fromJson để khởi tạo một đối tượng từ một Map
  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      customerId: json['customerId'],
      isAdmin: json['isAdmin'],
      message: json['message'],
    );
  }

  // Phương thức toJson để chuyển đổi đối tượng thành một Map
  Map<String, dynamic> toJson() {
    return {
      'customerId': customerId,
      'isAdmin': isAdmin,
      'message': message,
    };
  }
}
