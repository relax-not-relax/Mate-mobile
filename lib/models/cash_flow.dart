import 'dart:convert';

class CashFlow {
  final DateTime time;
  final double revenue;
  final double cost;
  final double profit;

  const CashFlow({
    required this.time,
    required this.revenue,
    required this.cost,
    required this.profit,
  });

  // Chuyển đổi từ JSON thành CashFlow
  factory CashFlow.fromJson(Map<String, dynamic> json) {
    return CashFlow(
      time: DateTime.parse(json['time'] as String),
      revenue: (json['revenue'] as num).toDouble(),
      cost: (json['cost'] as num).toDouble(),
      profit: (json['profit'] as num).toDouble(),
    );
  }

  // Chuyển đổi từ CashFlow thành JSON
  Map<String, dynamic> toJson() {
    return {
      'time': time.toIso8601String(),
      'revenue': revenue,
      'cost': cost,
      'profit': profit,
    };
  }

  @override
  String toString() {
    return "CashFlow (time: $time, revenue: $revenue, cost: $cost, profit: $profit)";
  }
}
