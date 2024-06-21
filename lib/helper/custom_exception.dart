import 'package:mate_project/enums/failure_enum.dart';

class CustomException implements Exception {
  final Failure type;
  final String content;

  CustomException({required this.type, required this.content});
}
