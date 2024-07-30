import 'package:mate_project/helper/custom_exception.dart';
import 'package:mate_project/models/attendance.dart';
import 'package:mate_project/models/response/CustomerResponse.dart';

abstract class StaffState {}

class StaffInitial extends StaffState {}

class SaveAttendanceLoading extends StaffState {}

class SaveAttendanceSuccess extends StaffState {}

class SaveAttendanceFailure extends StaffState {
  final CustomException error;
  SaveAttendanceFailure({required this.error});
}

class UpdateStaffLoading extends StaffState {}

class UpdateStaffSuccess extends StaffState {}

class UpdateStaffFailure extends StaffState {
  final CustomException error;
  UpdateStaffFailure({required this.error});
}
