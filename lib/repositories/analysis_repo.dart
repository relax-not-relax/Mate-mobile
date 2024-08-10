import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mate_project/enums/failure_enum.dart';
import 'package:mate_project/helper/config.dart';
import 'package:mate_project/helper/custom_exception.dart';
import 'package:mate_project/helper/sharedpreferenceshelper.dart';
import 'package:mate_project/models/analysis_response.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:permission_handler/permission_handler.dart';

class AnalysisRepository {
  Future<AnalysisResult> uploadFileToAnalysis(String filePath) async {
    var account = await SharedPreferencesHelper.getAdmin();
    http.MultipartRequest request = http.MultipartRequest(
        'POST', Uri.parse('http://14.225.217.104/api/analysis'));
    request.files.add(await http.MultipartFile.fromPath('file', filePath));
    request.headers.addAll({
      'Content-Type': 'multipart/form-data',
      'Authorization': 'Bearer ${account!.accessToken}',
    });

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      AnalysisResult analysisResult = AnalysisResult.fromJson(jsonData);
      return analysisResult;
    } else if (response.statusCode == 401 || response.statusCode == 403) {
      throw CustomException(type: Failure.System, content: "System error");
    } else {
      throw CustomException(type: Failure.System, content: "System error");
    }
  }

  Future<void> downloadExcelFile(int month, int year) async {
    var account = await SharedPreferencesHelper.getAdmin();

    // Yêu cầu quyền ghi bộ nhớ ngoài
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      status = await Permission.storage.request();
      if (!status.isGranted) {
        print('Permission denied');
        return;
      }
    }

    try {
      final response = await http.get(
        Uri.parse(
            "${Config.apiRoot}api/transaction/excel?month=$month&year=$year"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${account!.accessToken}',
        },
      );

      if (response.statusCode == 200) {
        final directory = await getExternalStorageDirectory();
        final downloadDirectory = Directory('${directory!.path}/Download');

        if (!await downloadDirectory.exists()) {
          await downloadDirectory.create(recursive: true);
        }

        final filePath = path.join(downloadDirectory.path, 'Data.xlsx');
        final file = File(filePath);

        await file.writeAsBytes(response.bodyBytes);
        print('Excel file downloaded successfully to $filePath');
      } else {
        print(
            'Failed to download Excel file. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error downloading Excel file: $e');
    }
  }
}
