import 'package:intl/intl.dart';

class CustomerInRoomResponse {
  int roomId;
  int customerId;
  DateTime joinDate;
  DateTime? leaveDate;
  bool status;

  CustomerInRoomResponse({
    required this.roomId,
    required this.customerId,
    required this.joinDate,
    this.leaveDate,
    required this.status,
  });

  // fromJson method
  factory CustomerInRoomResponse.fromJson(Map<String, dynamic> json) {
    final DateFormat formatter = DateFormat("yyyy-MM-ddTHH:mm:ss.SSS");
    return CustomerInRoomResponse(
      roomId: json['roomId'],
      customerId: json['customerId'],
      joinDate: DateTime.parse(json['joinDate']),
      leaveDate:
          json['leaveDate'] != null ? DateTime.parse(json['leaveDate']) : null,
      status: json['status'],
    );
  }

  // toJson method
  Map<String, dynamic> toJson() {
    final DateFormat formatter = DateFormat("yyyy-MM-ddTHH:mm:ss.SSS");
    return {
      'roomId': roomId,
      'customerId': customerId,
      'joinDate': formatter.format(joinDate),
      'leaveDate': leaveDate != null ? formatter.format(leaveDate!) : null,
      'status': status,
    };
  }
}
