import 'dart:async';
import 'dart:math';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mate_project/enums/failure_enum.dart';
import 'package:mate_project/events/authen_event.dart';
import 'package:mate_project/events/customer_event.dart';
import 'package:mate_project/events/staff_event.dart';
import 'package:mate_project/helper/custom_exception.dart';
import 'package:mate_project/helper/sharedpreferenceshelper.dart';
import 'package:mate_project/models/attendance.dart';
import 'package:mate_project/models/staff.dart';
import 'package:mate_project/repositories/attendance_repo.dart';
import 'package:mate_project/repositories/authen_repo.dart';
import 'package:mate_project/models/response/CustomerResponse.dart';
import 'package:mate_project/repositories/customer_repo.dart';
import 'package:mate_project/repositories/staff_repo.dart';
import 'package:mate_project/states/authen_state.dart';
import 'package:mate_project/states/customer_state.dart';
import 'package:mate_project/states/staff_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StaffBloc extends Bloc<StaffEvent, StaffState> {
  final StaffRepository staffRepository;
  final AttendanceRepo attendanceRepository;

  StaffBloc({required this.staffRepository, required this.attendanceRepository})
      : super(StaffInitial()) {
    on<SaveAttendancePresses>(_onSaveAttendancePress);
    on<SaveUpdateStaffPressed>(_onSaveUpdatePressed);
  }

  Future<void> _onSaveUpdatePressed(
      SaveUpdateStaffPressed event, Emitter<StaffState> emit) async {
    emit(UpdateStaffLoading());
    try {
      if (event.avatar != null) {
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('uploads/${DateTime.now().millisecondsSinceEpoch}.png');
        final uploadTask = storageRef.putFile(event.avatar!);

        final snapshot = await uploadTask.whenComplete(() => null);
        final downloadURL = await snapshot.ref.getDownloadURL();
        event.updateStaffRequest.avatar = downloadURL;
      }

      await staffRepository.UpdateInformation(
          staffId: event.staffId, data: event.updateStaffRequest);
      Staff? staff = await SharedPreferencesHelper.getStaff();
      staff!.avatar = event.updateStaffRequest.avatar;
      staff.fullName = event.updateStaffRequest.fullname;
      staff.phoneNumber = event.updateStaffRequest.phoneNumber;
      staff.dateOfBirth = event.updateStaffRequest.dateOfBirth;
      staff.gender = event.updateStaffRequest.gender;
      staff.address = event.updateStaffRequest.address;
      await SharedPreferencesHelper.setStaff(staff);

      emit(UpdateStaffSuccess());
    } catch (er) {
      if (er is CustomException) {
        print("loi");
        emit(UpdateStaffFailure(error: er));
      } else {
        emit(UpdateStaffFailure(
            error:
                CustomException(type: Failure.System, content: er.toString())));
      }
    }
  }

  Future<void> _onSaveAttendancePress(
      SaveAttendancePresses event, Emitter<StaffState> emit) async {
    emit(SaveAttendanceLoading());
    try {
      await attendanceRepository.CheckAttendanceStaff(
          listCheck: event.checkAttendanceList);
      emit(SaveAttendanceSuccess());
    } catch (er) {
      emit(SaveAttendanceFailure(
          error:
              CustomException(type: Failure.System, content: er.toString())));
    }
  }
}
