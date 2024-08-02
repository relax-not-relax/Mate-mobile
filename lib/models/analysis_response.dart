import 'dart:convert';

import 'package:mate_project/models/cash_flow.dart';

class AnalysisResult {
  String advice;
  final List<CashFlow> listCashFlow;

  AnalysisResult({
    required this.advice,
    required this.listCashFlow,
  });

  // Chuyển đổi từ JSON thành AnalysisResult
  factory AnalysisResult.fromJson(Map<String, dynamic> json) {
    var list = json['listCashFlow'] as List;
    List<CashFlow> cashFlows =
        list.map((i) => CashFlow.fromJson(i as Map<String, dynamic>)).toList();

    return AnalysisResult(
      advice: json['advice'] as String,
      listCashFlow: cashFlows,
    );
  }

  // Chuyển đổi từ AnalysisResult thành JSON
  Map<String, dynamic> toJson() {
    return {
      'advice': advice,
      'listCashFlow':
          listCashFlow.map((cashFlow) => cashFlow.toJson()).toList(),
    };
  }
}
