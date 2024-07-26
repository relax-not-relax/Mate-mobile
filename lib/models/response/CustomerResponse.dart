import 'package:mate_project/models/pack.dart';
import 'package:mate_project/models/response/CustomerInRoomRespone.dart';
import 'package:mate_project/models/response/PackOfCustomerResponse.dart';

class CustomerResponse {
  int customerId;
  String email;
  String fullname;
  DateTime? dateOfBirth;
  String? gender;
  String? phoneNumber;
  String? address;
  String? avatar;
  String? favorite;
  String? note;
  bool status;
  String version;
  String? accessToken;
  String? refreshToken;
  int versionToken;
  List<PackOfCustomerResponse> packs;
  List<CustomerInRoomResponse> customerInRooms;

  CustomerResponse(
      {required this.customerId,
      required this.email,
      required this.fullname,
      required this.dateOfBirth,
      required this.gender,
      required this.phoneNumber,
      required this.address,
      required this.avatar,
      required this.favorite,
      required this.note,
      required this.status,
      required this.version,
      this.accessToken,
      this.refreshToken,
      required this.versionToken,
      required this.packs,
      required this.customerInRooms // Thêm packs vào constructor
      });

  factory CustomerResponse.fromJson(Map<String, dynamic> json) {
    var packsFromJson = json['packOfCustomers'] as List<dynamic>? ?? [];
    List<PackOfCustomerResponse> packList =
        packsFromJson.map((i) => PackOfCustomerResponse.fromJson(i)).toList();

    var roomsFromJson = json['customerInRooms'] as List<dynamic>? ?? [];
    List<CustomerInRoomResponse> roomList =
        roomsFromJson.map((i) => CustomerInRoomResponse.fromJson(i)).toList();

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
        avatar: json['avatar'],
        favorite: json['favorite'],
        note: json['note'],
        status: json['status'],
        version: json['version'],
        accessToken: json['accessToken'],
        refreshToken: json['refreshToken'],
        versionToken: json['versionToken'],
        packs: packList,
        customerInRooms: roomList);
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> packsToJson =
        packs.map((i) => i.toJson()).toList();

    List<Map<String, dynamic>> roomToJson =
        customerInRooms.map((i) => i.toJson()).toList();

    return {
      'customerId': customerId,
      'email': email,
      'fullname': fullname,
      'dateOfBirth': dateOfBirth?.toIso8601String(),
      'gender': gender,
      'phoneNumber': phoneNumber,
      'address': address,
      'avatar': avatar,
      'favorite': favorite,
      'note': note,
      'status': status,
      'version': version,
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      'versionToken': versionToken,
      'packOfCustomers': packsToJson,
      'customerInRooms': roomToJson
    };
  }
}
