import 'package:mate_project/helper/custom_exception.dart';
import 'package:mate_project/models/attendance.dart';
import 'package:mate_project/models/response/CustomerResponse.dart';

abstract class CustomerState {}

class UpdateCustomerInital extends CustomerState {}

class UpdateCustomerLoading extends CustomerState {}

class UpdateCustomerSuccess extends CustomerState {}

class UpdateCustomerFailure extends CustomerState {
  final CustomException error;
  UpdateCustomerFailure({required this.error});
}

class BuyPackFailure extends CustomerState {
  final CustomException error;
  BuyPackFailure({required this.error});
}

class BuyPackSuccess extends CustomerState {}

class BuyPackLoading extends CustomerState {}

class ViewAttendanceInitial extends CustomerState {}

class ViewAttendanceLoading extends CustomerState {}

class ViewAttendanceFailure extends CustomerState {}

class ViewAttendanceSuccess extends CustomerState {
  final List<Attendance> listAttendance;

  ViewAttendanceSuccess({required this.listAttendance});
}
