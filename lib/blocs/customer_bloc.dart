import 'dart:async';
import 'dart:math';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mate_project/enums/failure_enum.dart';
import 'package:mate_project/events/authen_event.dart';
import 'package:mate_project/events/customer_event.dart';
import 'package:mate_project/helper/custom_exception.dart';
import 'package:mate_project/helper/sharedpreferenceshelper.dart';
import 'package:mate_project/models/attendance.dart';
import 'package:mate_project/repositories/attendance_repo.dart';
import 'package:mate_project/repositories/authen_repo.dart';
import 'package:mate_project/models/response/CustomerResponse.dart';
import 'package:mate_project/repositories/customer_repo.dart';
import 'package:mate_project/repositories/staff_repo.dart';
import 'package:mate_project/states/authen_state.dart';
import 'package:mate_project/states/customer_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomerBloc extends Bloc<CustomerEvent, CustomerState> {
  final CustomerRepository customerRepository;
  final AttendanceRepo attendanceRepository;
  final CustomerResponse? customer;
  final StaffRepository staffRepository;

  CustomerBloc(
      {required this.customerRepository,
      required this.attendanceRepository,
      required this.customer,
      required this.staffRepository})
      : super(UpdateCustomerInital()) {
    on<SaveUpdatePressed>(_onSaveUpdatePressed);
    on<BuyPackPressed>(_onBuyPackPresses);
    on<ViewAttendanceScroll>(_onViewAttendanceScroll);
    on<SaveChangePasswordPressed>(_onChangePasswordPressed);
    on<SaveChangePasswordStaffPressed>(_onChangePasswordStaffPressed);
  }

  Future<void> _onChangePasswordStaffPressed(
      SaveChangePasswordStaffPressed event, Emitter<CustomerState> emit) async {
    emit(UpdateCustomerLoading());
    try {
      await staffRepository.changePassword(data: event.passwordRequest);
      emit(UpdateCustomerSuccess());
    } catch (er) {
      if (er is CustomException) {
        emit(UpdateCustomerFailure(error: er));
      } else {
        emit(UpdateCustomerFailure(
            error:
                CustomException(type: Failure.System, content: er.toString())));
      }
    }
  }

  Future<void> _onChangePasswordPressed(
      SaveChangePasswordPressed event, Emitter<CustomerState> emit) async {
    emit(UpdateCustomerLoading());
    try {
      await customerRepository.changePassword(data: event.passwordRequest);
      emit(UpdateCustomerSuccess());
    } catch (er) {
      if (er is CustomException) {
        emit(UpdateCustomerFailure(error: er));
      } else {
        emit(UpdateCustomerFailure(
            error:
                CustomException(type: Failure.System, content: er.toString())));
      }
    }
  }

  Future<void> _onViewAttendanceScroll(
      ViewAttendanceScroll event, Emitter<CustomerState> emit) async {
    emit(ViewAttendanceLoading());
    try {
      List<Attendance> list =
          await attendanceRepository.GetAttendanceOfCustomer(
              filterType: 0,
              pageSize: event.pageSize,
              page: event.page,
              customerId: event.customerId);
      emit(ViewAttendanceSuccess(listAttendance: list));
    } catch (er) {
      print(er);
      emit(ViewAttendanceFailure());
    }
  }

  Future<void> _onBuyPackPresses(
      BuyPackPressed event, Emitter<CustomerState> emit) async {
    emit(UpdateCustomerLoading());
    try {
      await customerRepository.addToRoom(data: event.addToRoomRequest);
      await customerRepository.BuyPack(data: event.buyPackRequest);

      CustomerResponse customerResponse =
          await customerRepository.getCustomerCurrent();
      SharedPreferencesHelper.setCustomer(customerResponse);
      emit(BuyPackSuccess());
    } catch (er) {
      if (er is CustomException) {
        emit(BuyPackFailure(error: er));
      } else {
        emit(BuyPackFailure(
            error:
                CustomException(type: Failure.System, content: er.toString())));
      }
    }
  }

  Future<void> _onSaveUpdatePressed(
      SaveUpdatePressed event, Emitter<CustomerState> emit) async {
    emit(UpdateCustomerLoading());
    try {
      if (event.avatar != null) {
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('uploads/${DateTime.now().millisecondsSinceEpoch}.png');
        final uploadTask = storageRef.putFile(event.avatar!);

        final snapshot = await uploadTask.whenComplete(() => null);
        final downloadURL = await snapshot.ref.getDownloadURL();
        event.customerRequest.avatar = downloadURL;
      }

      await customerRepository.UpdateInformation(
          customerId: event.customerId, data: event.customerRequest);
      CustomerResponse? customer = await SharedPreferencesHelper.getCustomer();
      customer!.avatar = event.customerRequest.avatar;
      customer.fullname = event.customerRequest.fullname;
      customer.phoneNumber = event.customerRequest.phoneNumber;
      customer.dateOfBirth =
          DateFormat('yyyy-MM-dd').parse(event.customerRequest.dateOfBirth);
      customer.gender = event.customerRequest.gender;
      customer.address = event.customerRequest.address;
      customer.favorite = event.customerRequest.favorite;
      customer.note = event.customerRequest.note;
      await SharedPreferencesHelper.setCustomer(customer);

      emit(UpdateCustomerSuccess());
    } catch (er) {
      if (er is CustomException) {
        print("loi");
        emit(UpdateCustomerFailure(error: er));
      } else {
        emit(UpdateCustomerFailure(
            error:
                CustomException(type: Failure.System, content: er.toString())));
      }
    }
  }
}
