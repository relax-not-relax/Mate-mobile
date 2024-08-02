import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mate_project/enums/failure_enum.dart';
import 'package:mate_project/helper/custom_exception.dart';
import 'package:mate_project/helper/sharedpreferenceshelper.dart';
import 'package:mate_project/models/analysis_response.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart';

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
}
