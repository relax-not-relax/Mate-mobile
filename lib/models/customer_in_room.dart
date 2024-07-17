import 'package:mate_project/models/customer.dart';
import 'package:mate_project/models/room.dart';

class CustomerInRoom {
  final Room room;
  final Customer customer;
  final DateTime joinDate;
  DateTime? leaveDate;
  bool? status;

  CustomerInRoom({
    required this.room,
    required this.customer,
    required this.joinDate,
    this.leaveDate,
    this.status,
  });
}
