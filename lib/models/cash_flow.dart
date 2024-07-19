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

  @override
  String toString() {
    return "CashFlow (time: $time, revenue: $revenue, cost: $cost)";
  }
}
