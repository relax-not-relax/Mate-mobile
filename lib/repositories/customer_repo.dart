import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:mate_project/enums/failure_enum.dart';
import 'dart:convert';

import 'package:mate_project/helper/config.dart';
import 'package:mate_project/helper/custom_exception.dart';
import 'package:mate_project/helper/sharedpreferenceshelper.dart';
import 'package:mate_project/models/request/add_customer_to_room_request.dart';
import 'package:mate_project/models/request/buy_pack_request.dart';
import 'package:mate_project/models/request/password_request.dart';
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

  Future<CustomerResponse> getCustomerCurrent() async {
    var account = await SharedPreferencesHelper.getCustomer();
    final response = await http.get(
        Uri.parse('${Config.apiRoot}api/customer/${account!.customerId}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${account.accessToken}',
        });

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      CustomerResponse customer = CustomerResponse.fromJson(jsonData);
      print(customer.toJson());
      customer.accessToken = account.accessToken;
      return customer;
    } else if (response.statusCode == 400) {
      final jsonData = json.decode(response.body);
      throw Exception(jsonData['error']);
    } else {
      throw Exception('System failure');
    }
  }

  Future<bool> deactiveCustomer(int customerId) async {
    var account = await SharedPreferencesHelper.getAdmin();
    final response = await http.delete(
        Uri.parse('${Config.apiRoot}api/customer/Deacticve/$customerId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${account!.accessToken}',
        });
    print(customerId);

    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 400) {
      return false;
    } else {
      return false;
    }
  }

  Future<List<CustomerResponse>> GetCustomerByAdmin(
      {required int page, required int pageSize}) async {
    var account = await SharedPreferencesHelper.getAdmin();

    final response = await http.get(
      Uri.parse("${Config.apiRoot}api/customer?Page=$page&PageSize=$pageSize"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${account!.accessToken}',
      },
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      List<dynamic> listJson = jsonData['results'] as List<dynamic>? ?? [];
      List<CustomerResponse> listCustomer = [];
      for (var element in listJson) {
        CustomerResponse customer = CustomerResponse.fromJson(element);
        if (customer.status == true) {
          listCustomer.add(customer);
        }
      }
      return listCustomer;
    } else if (response.statusCode == 400) {
      final jsonData = json.decode(response.body);
      throw Exception(jsonData['error']);
    } else {
      throw Exception('System failure');
    }
  }

  Future<CustomerResponse> GetCustomerWithIdByAdmin(
      {required int customerId}) async {
    var account = await SharedPreferencesHelper.getAdmin();

    final response = await http.get(
      Uri.parse("${Config.apiRoot}api/customer/$customerId"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${account!.accessToken}',
      },
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      CustomerResponse customerResponse = CustomerResponse.fromJson(jsonData);
      return customerResponse;
    } else if (response.statusCode == 400) {
      final jsonData = json.decode(response.body);
      throw Exception(jsonData['error']);
    } else {
      throw Exception('System failure');
    }
  }

  Future<void> BuyPack({required BuyPackRequest data}) async {
    var account = await SharedPreferencesHelper.getCustomer();
    String jsonBody = jsonEncode(data);
    final response = await http.post(
      Uri.parse("${Config.apiRoot}api/pack/Buy-Pack"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${account!.accessToken}',
      },
      body: jsonBody,
    );
    print(jsonBody);
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      return;
    } else if (response.statusCode == 400) {
      final jsonData = json.decode(response.body);
      throw Exception(jsonData['error']);
    } else {
      throw Exception('System failure');
    }
  }

  Future<void> addToRoom({required AddToRoomRequest data}) async {
    var account = await SharedPreferencesHelper.getCustomer();
    String jsonBody = jsonEncode(data);
    print(data.toJson().toString());
    final response = await http.post(
      Uri.parse("${Config.apiRoot}api/room/Add-Customer-Into-Room"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${account!.accessToken}',
      },
      body: jsonBody,
    );
    if (response.statusCode == 200) {
      return;
    } else if (response.statusCode == 400) {
      final jsonData = json.decode(response.body);
      throw Exception(jsonData['error']);
    } else {
      throw Exception('System failure');
    }
  }

  Future<void> changePassword({required PasswordRequest data}) async {
    var account = await SharedPreferencesHelper.getCustomer();
    String jsonBody = jsonEncode(data);
    final response = await http.put(
      Uri.parse(
          "${Config.apiRoot}api/customer/Change-Password/${account!.customerId}"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${account.accessToken}',
      },
      body: jsonBody,
    );
    if (response.statusCode == 200) {
      return;
    } else if (response.statusCode == 400) {
      final jsonData = json.decode(response.body);
      throw CustomException(type: Failure.Password, content: jsonData['error']);
    } else {
      throw Exception('System failure');
    }
  }

  Future<int> checkPack({required int packId}) async {
    var account = await SharedPreferencesHelper.getCustomer();
    if (packId == 1) {
      //Gold Room
      final response = await http.get(
        Uri.parse("${Config.apiRoot}api/room/Customer-In-Room?RoomId=1"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${account!.accessToken}',
        },
      );
      print("done");
      final jsonData = json.decode(response.body);
      print(jsonData);
      if (int.parse(jsonData['totalNumberOfRecords'].toString()) < 1) {
        return 1;
      }
      print("done");
      final response2 = await http.get(
        Uri.parse("${Config.apiRoot}api/room/Customer-In-Room?RoomId=2"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${account.accessToken}',
        },
      );
      final jsonData2 = json.decode(response2.body);
      if (int.parse(jsonData2['totalNumberOfRecords'].toString()) < 1) {
        return 2;
      }

      final response3 = await http.get(
        Uri.parse("${Config.apiRoot}api/room/Customer-In-Room?RoomId=3"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${account.accessToken}',
        },
      );
      final jsonData3 = json.decode(response3.body);
      if (int.parse(jsonData3['totalNumberOfRecords'].toString()) < 1) {
        return 3;
      }

      throw CustomException(
          type: Failure.RoomFull, content: 'This package is currently full');
    } else if (packId == 2) {
      //Silver Room
      final response = await http.get(
        Uri.parse("${Config.apiRoot}api/room/Customer-In-Room?RoomId=4"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${account!.accessToken}',
        },
      );
      final jsonData = json.decode(response.body);
      if (int.parse(jsonData['totalNumberOfRecords'].toString()) < 2) {
        return 4;
      }

      final response2 = await http.get(
        Uri.parse("${Config.apiRoot}api/room/Customer-In-Room?RoomId=5"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${account.accessToken}',
        },
      );
      final jsonData2 = json.decode(response2.body);
      if (int.parse(jsonData2['totalNumberOfRecords'].toString()) < 2) {
        return 5;
      }
      final response3 = await http.get(
        Uri.parse("${Config.apiRoot}api/room/Customer-In-Room?RoomId=6"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${account.accessToken}',
        },
      );
      final jsonData3 = json.decode(response3.body);
      if (int.parse(jsonData3['totalNumberOfRecords'].toString()) < 2) {
        return 6;
      }
      throw CustomException(
          type: Failure.RoomFull, content: 'This package is currently full');
    } else {
      //Bronze Room
      final response = await http.get(
        Uri.parse("${Config.apiRoot}api/room/Customer-In-Room?RoomId=7"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${account!.accessToken}',
        },
      );
      final jsonData = json.decode(response.body);
      if (int.parse(jsonData['totalNumberOfRecords'].toString()) < 3) {
        return 7;
      }

      final response2 = await http.get(
        Uri.parse("${Config.apiRoot}api/room/Customer-In-Room?RoomId=8"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${account.accessToken}',
        },
      );
      final jsonData2 = json.decode(response2.body);
      if (int.parse(jsonData2['totalNumberOfRecords'].toString()) < 3) {
        return 8;
      }

      final response3 = await http.get(
        Uri.parse("${Config.apiRoot}api/room/Customer-In-Room?RoomId=9"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${account.accessToken}',
        },
      );
      final jsonData3 = json.decode(response3.body);
      if (int.parse(jsonData3['totalNumberOfRecords'].toString()) < 3) {
        return 9;
      }
      throw CustomException(
          type: Failure.RoomFull, content: 'This package is currently full');
    }
  }
}
