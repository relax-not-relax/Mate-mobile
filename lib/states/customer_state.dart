import 'package:mate_project/helper/custom_exception.dart';
import 'package:mate_project/models/response/CustomerResponse.dart';

abstract class CustomerState {}

class UpdateCustomerInital extends CustomerState {}

class UpdateCustomerLoading extends CustomerState {}

class UpdateCustomerSuccess extends CustomerState {}

class UpdateCustomerFailure extends CustomerState {
  final CustomException error;
  UpdateCustomerFailure({required this.error});
}
