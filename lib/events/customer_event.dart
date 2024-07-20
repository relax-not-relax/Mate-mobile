import 'dart:io';

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
