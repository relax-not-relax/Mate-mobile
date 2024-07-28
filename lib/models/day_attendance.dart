import 'package:intl/intl.dart';
import 'package:mate_project/models/attendance.dart';
import 'package:mate_project/models/response/CustomerResponse.dart';
import 'package:mate_project/models/staff.dart';

class DayAttendance {
  final int customerId;
  final int staffId;
  int status;
  final Staff? staff;
  final int roomId;
  final CustomerResponse? customer;
  Attendance morningAttendance;
  Attendance eveningAttendance;

  DayAttendance(this.morningAttendance, this.eveningAttendance,
      {required this.customerId,
      required this.staffId,
      required this.status,
      required this.staff,
      required this.roomId,
      required this.customer});
}
