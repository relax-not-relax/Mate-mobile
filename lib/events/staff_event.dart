import 'dart:io';

import 'package:mate_project/models/check_attendance.dart';
import 'package:mate_project/models/request/add_customer_to_room_request.dart';
import 'package:mate_project/models/request/buy_pack_request.dart';
import 'package:mate_project/models/request/password_request.dart';
import 'package:mate_project/models/request/update_customer_request.dart';
import 'package:mate_project/models/request/update_staff_request.dart';
import 'package:mate_project/models/response/CustomerResponse.dart';
import 'package:mate_project/models/staff.dart';

abstract class StaffEvent {}

class SaveAttendancePresses extends StaffEvent {
  final List<CheckAttendance> checkAttendanceList;

  SaveAttendancePresses({required this.checkAttendanceList});
}

class SaveUpdateStaffPressed extends StaffEvent {
  final UpdateStaffRequest updateStaffRequest;
  final int staffId;
  final File? avatar;

  SaveUpdateStaffPressed(this.staffId, this.avatar,
      {required this.updateStaffRequest});
}
