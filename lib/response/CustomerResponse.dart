class CustomerResponse {
  int customerId;
  String email;
  String fullname;
  DateTime? dateOfBirth;
  String? gender;
  String? phoneNumber;
  String? address;
  String? favorite;
  String? note;
  bool status;
  String version;
  String? accessToken;
  String? refreshToken;
  int versionToken;

  CustomerResponse(
      {required this.customerId,
      required this.email,
      required this.fullname,
      required this.dateOfBirth,
      required this.gender,
      required this.phoneNumber,
      required this.address,
      required this.favorite,
      required this.note,
      required this.status,
      required this.version,
      this.accessToken,
      this.refreshToken,
      required this.versionToken});

  factory CustomerResponse.fromJson(Map<String, dynamic> json) {
    return CustomerResponse(
        customerId: json['customerId'],
        email: json['email'],
        fullname: json['fullname'],
        dateOfBirth: json['dateOfBirth'] != null
            ? DateTime.parse(json['dateOfBirth'])
            : null,
        gender: json['gender'],
        phoneNumber: json['phoneNumber'],
        address: json['address'],
        favorite: json['favorite'],
        note: json['note'],
        status: json['status'],
        version: json['version'],
        accessToken: json['accessToken'],
        refreshToken: json['refreshToken'],
        versionToken: json['versionToken']);
  }

  Map<String, dynamic> toJson() {
    return {
      'customerId': customerId,
      'email': email,
      'fullname': fullname,
      'dateOfBirth': dateOfBirth?.toIso8601String(),
      'gender': gender,
      'phoneNumber': phoneNumber,
      'address': address,
      'favorite': favorite,
      'note': note,
      'status': status,
      'version': version,
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      'versionToken': versionToken
    };
  }
}
