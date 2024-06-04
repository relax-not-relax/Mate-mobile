class Customer {
  final int customerId;
  final String email;
  final String fullName;
  String? dateOfBirth;
  String? gender;
  String? phoneNumber;
  String? address;
  String? favorite;
  String? note;
  String? avatar;

  Customer({
    required this.customerId,
    required this.email,
    required this.fullName,
    this.dateOfBirth,
    this.gender,
    this.phoneNumber,
    this.address,
    this.favorite,
    this.note,
    this.avatar,
  });
}
