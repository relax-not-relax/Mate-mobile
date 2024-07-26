import 'package:intl/intl.dart';

class PackOfCustomerResponse {
  int packOfCustomerId;
  int customerId;
  int packId;
  DateTime startDate;
  DateTime endDate;
  bool status;
  dynamic
      pack; // Nếu "pack" có thể là một đối tượng phức tạp, hãy thay đổi kiểu dữ liệu này phù hợp

  PackOfCustomerResponse({
    required this.packOfCustomerId,
    required this.customerId,
    required this.packId,
    required this.startDate,
    required this.endDate,
    required this.status,
    this.pack,
  });

  // fromJson method
  factory PackOfCustomerResponse.fromJson(Map<String, dynamic> json) {
    final DateFormat formatter = DateFormat("yyyy-MM-ddTHH:mm:ss.SSS");
    return PackOfCustomerResponse(
      packOfCustomerId: json['packOfCustomerId'],
      customerId: json['customerId'],
      packId: json['packId'],
      startDate: formatter.parse(json['startDate']),
      endDate: formatter.parse(json['endDate']),
      status: json['status'],
      pack: json['pack'],
    );
  }

  // toJson method
  Map<String, dynamic> toJson() {
    final DateFormat formatter = DateFormat("yyyy-MM-ddTHH:mm:ss.SSS");
    return {
      'packOfCustomerId': packOfCustomerId,
      'customerId': customerId,
      'packId': packId,
      'startDate': formatter.format(startDate),
      'endDate': formatter.format(endDate),
      'status': status,
      'pack': pack,
    };
  }
}
