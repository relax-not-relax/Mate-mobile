import 'package:intl/intl.dart';
import 'package:mate_project/models/staff.dart';

class Attendance {
  final int attendanceId;
  final int customerId;
  final int staffId;
  final DateTime checkDate;
  final int status;
  final Staff? staff;

  const Attendance(
      {required this.attendanceId,
      required this.customerId,
      required this.staffId,
      required this.checkDate,
      required this.status,
      required this.staff});

  // fromJson method
  factory Attendance.fromJson(Map<String, dynamic> json) {
    final DateFormat formatter = DateFormat("yyyy-MM-ddTHH:mm:ss.SSS");
    return Attendance(
        attendanceId: json['attendanceId'],
        customerId: json['customerId'],
        staffId: json['staffId'],
        checkDate: formatter.parse(json['checkDate']),
        status: int.parse(json['status'].toString()),
        staff: Staff.fromJson(json['staff']));
  }

  // toJson method
  Map<String, dynamic> toJson() {
    final DateFormat formatter = DateFormat("yyyy-MM-ddTHH:mm:ss.SSS");
    return {
      'attendanceId': attendanceId,
      'customerId': customerId,
      'staffId': staffId,
      'checkDate': formatter.format(checkDate),
      'status': status,
      'staff': staff?.toJson()
    };
  }
}
