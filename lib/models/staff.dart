class Staff {
  final int staffId;
  final String email;
  final String fullName;
  String? dateOfBirth;
  String? gender;
  String? phoneNumber;
  String? address;
  bool? status;
  String? avatar;

  Staff({
    required this.staffId,
    required this.email,
    required this.fullName,
    this.dateOfBirth,
    this.gender,
    this.phoneNumber,
    this.address,
    this.status,
    this.avatar,
  });

  // Phương thức chuyển từ JSON sang đối tượng Staff
  factory Staff.fromJson(Map<String, dynamic> json) {
    return Staff(
      staffId: json['staffId'],
      email: json['email'],
      fullName: json['fullname'],
      dateOfBirth: json['dateOfBirth'],
      gender: json['gender'],
      phoneNumber: json['phoneNumber'],
      address: json['address'],
      status: json['status'],
      avatar: json['avatar'],
    );
  }

  // Phương thức chuyển từ đối tượng Staff sang JSON
  Map<String, dynamic> toJson() {
    return {
      'staffId': staffId,
      'email': email,
      'fullName': fullName,
      'dateOfBirth': dateOfBirth,
      'gender': gender,
      'phoneNumber': phoneNumber,
      'address': address,
      'status': status,
      'avatar': avatar,
    };
  }
}
