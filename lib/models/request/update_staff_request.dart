class UpdateStaffRequest {
  String avatar;
  String fullname;
  String dateOfBirth;
  String gender;
  String phoneNumber;
  String address;

  UpdateStaffRequest({
    required this.avatar,
    required this.fullname,
    required this.dateOfBirth,
    required this.gender,
    required this.phoneNumber,
    required this.address,
  });

  // Phương thức chuyển đổi object thành JSON
  Map<String, dynamic> toJson() {
    return {
      'avatar': avatar,
      'fullname': fullname,
      'dateOfBirth': dateOfBirth,
      'gender': gender,
      'phoneNumber': phoneNumber,
      'address': address,
    };
  }

  // Phương thức tạo object từ JSON
  factory UpdateStaffRequest.fromJson(Map<String, dynamic> json) {
    return UpdateStaffRequest(
      avatar: json['avatar'],
      fullname: json['fullname'],
      dateOfBirth: json['dateOfBirth'],
      gender: json['gender'],
      phoneNumber: json['phoneNumber'],
      address: json['address'],
    );
  }
}
