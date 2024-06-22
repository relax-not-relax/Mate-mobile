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
}
