class PasswordRequest {
  String oldPassword;
  String newPassword;

  PasswordRequest({
    required this.oldPassword,
    required this.newPassword,
  });

  // Phương thức chuyển đổi từ JSON sang object
  factory PasswordRequest.fromJson(Map<String, dynamic> json) {
    return PasswordRequest(
      oldPassword: json['oldPassword'],
      newPassword: json['newPassword'],
    );
  }

  // Phương thức chuyển đổi từ object sang JSON
  Map<String, dynamic> toJson() {
    return {
      'oldPassword': oldPassword,
      'newPassword': newPassword,
    };
  }
}
