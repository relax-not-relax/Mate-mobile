import 'package:http/http.dart' as http;
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
    } else {
      throw Exception('Failed to Update');
    }
  }
}
