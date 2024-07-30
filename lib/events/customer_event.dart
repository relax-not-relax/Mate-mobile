import 'dart:io';

import 'package:mate_project/models/request/add_customer_to_room_request.dart';
import 'package:mate_project/models/request/buy_pack_request.dart';
import 'package:mate_project/models/request/password_request.dart';
import 'package:mate_project/models/request/update_customer_request.dart';
import 'package:mate_project/models/response/CustomerResponse.dart';

abstract class CustomerEvent {}

class SaveUpdatePressed extends CustomerEvent {
  final UpdateCustomerRequest customerRequest;
  final int customerId;
  final File? avatar;

  SaveUpdatePressed(
      {required this.avatar,
      required this.customerRequest,
      required this.customerId});
}

class BuyPackPressed extends CustomerEvent {
  final BuyPackRequest buyPackRequest;
  final AddToRoomRequest addToRoomRequest;

  BuyPackPressed(
      {required this.buyPackRequest, required this.addToRoomRequest});
}

class ViewAttendanceScroll extends CustomerEvent {
  final int page;
  final int pageSize;
  final int customerId;

  ViewAttendanceScroll(
      {required this.page, required this.pageSize, required this.customerId});
}

class SaveChangePasswordPressed extends CustomerEvent {
  final PasswordRequest passwordRequest;

  SaveChangePasswordPressed({required this.passwordRequest});
}

class SaveChangePasswordStaffPressed extends CustomerEvent {
  final PasswordRequest passwordRequest;

  SaveChangePasswordStaffPressed({required this.passwordRequest});
}
