import 'package:mate_project/models/customer_in_room.dart';
import 'package:mate_project/models/staff.dart';

class RoomAssign {
  final List<CustomerInRoom> customerInRoom;
  Staff? staff;
  DateTime? assignDate;
  final bool isAssigned;

  RoomAssign({
    required this.customerInRoom,
    this.staff,
    this.assignDate,
    required this.isAssigned,
  });
}
