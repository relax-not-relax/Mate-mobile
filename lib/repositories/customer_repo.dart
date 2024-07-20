import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:mate_project/enums/failure_enum.dart';
import 'dart:convert';

import 'package:mate_project/helper/config.dart';
import 'package:mate_project/helper/custom_exception.dart';
import 'package:mate_project/helper/sharedpreferenceshelper.dart';
import 'package:mate_project/models/request/update_customer_request.dart';
import 'package:mate_project/models/response/CustomerResponse.dart';

class CustomerRepository {
  Future<CustomerResponse> UpdateInformation(
      {required UpdateCustomerRequest data, required int customerId}) async {
    if ((data.fullname.trim().isEmpty)) {
      throw CustomException(
          type: Failure.Fullname, content: 'Please enter fullname');
    }
    if ((data.phoneNumber.trim().isEmpty)) {
      throw CustomException(
          type: Failure.PhoneNumber, content: 'Please enter phone number');
    }
    if (DateFormat('yyyy-MM-dd')
        .parse(data.dateOfBirth)
        .isAfter(DateTime.now())) {
      throw CustomException(
          type: Failure.Birthday, content: 'Invalid birthday');
    }

    var account = await SharedPreferencesHelper.getCustomer();
    String jsonBody = jsonEncode(data);
    final response = await http.put(
      Uri.parse("${Config.apiRoot}api/customer/$customerId"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${account!.accessToken}',
      },
      body: jsonBody,
    );
    print(response.statusCode);
    print(customerId);
    print(jsonBody);
    print(account.accessToken);
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return CustomerResponse.fromJson(jsonData);
    } else if (response.statusCode == 400) {
      final jsonData = json.decode(response.body);
      throw Exception(jsonData['error']);
    } else {
      throw Exception('System failure');
    }
  }
}
