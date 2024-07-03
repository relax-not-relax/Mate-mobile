import 'dart:convert';

class UpdateCustomerRequest {
  String avatar;
  String fullname;
  String dateOfBirth;
  String gender;
  String phoneNumber;
  String address;
  String favorite;
  String note;

  UpdateCustomerRequest({
    required this.avatar,
    required this.fullname,
    required this.dateOfBirth,
    required this.gender,
    required this.phoneNumber,
    required this.address,
    required this.favorite,
    required this.note,
  });

  // Deserialize from JSON
  factory UpdateCustomerRequest.fromJson(Map<String, dynamic> json) {
    return UpdateCustomerRequest(
      avatar: json['avatar'],
      fullname: json['fullname'],
      dateOfBirth: json['dateOfBirth'],
      gender: json['gender'],
      phoneNumber: json['phoneNumber'],
      address: json['address'],
      favorite: json['favorite'],
      note: json['note'],
    );
  }

  // Serialize to JSON
  Map<String, dynamic> toJson() {
    return {
      'avatar': avatar,
      'fullname': fullname,
      'dateOfBirth': dateOfBirth,
      'gender': gender,
      'phoneNumber': phoneNumber,
      'address': address,
      'favorite': favorite,
      'note': note,
    };
  }
}

void main() {
  // Example usage
  String jsonString = '''
  {
    "avatar": "example_avatar.png",
    "fullname": "John Doe",
    "dateOfBirth": "2024-06-21T07:06:44.900Z",
    "gender": "male",
    "phoneNumber": "1234567890",
    "address": "123 Main St",
    "favorite": "Pizza",
    "note": "No additional notes"
  }
  ''';

  // Deserialize JSON to Dart object
  Map<String, dynamic> userMap = jsonDecode(jsonString);
  UpdateCustomerRequest customer = UpdateCustomerRequest.fromJson(userMap);
  print('Fullname: ${customer.fullname}'); // Output: Fullname: John Doe

  // Serialize Dart object to JSON
  String json = jsonEncode(customer.toJson());
  print(json);
}
