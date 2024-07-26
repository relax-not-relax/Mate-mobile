class BuyPackRequest {
  int customerId;
  int packId;
  String passConfirm;
  DateTime startDate;
  int amount;
  String paypalTransactionId;
  String title;
  String description;
  String status;
  DateTime paymentedDate;

  BuyPackRequest({
    required this.customerId,
    required this.packId,
    required this.passConfirm,
    required this.startDate,
    required this.amount,
    required this.paypalTransactionId,
    required this.title,
    required this.description,
    required this.status,
    required this.paymentedDate,
  });

  factory BuyPackRequest.fromJson(Map<String, dynamic> json) {
    return BuyPackRequest(
      customerId: json['customerId'],
      packId: json['packId'],
      passConfirm: json['passConfirm'],
      startDate: DateTime.parse(json['startDate']),
      amount: json['amount'],
      paypalTransactionId: json['paypalTransactionId'],
      title: json['title'],
      description: json['description'],
      status: json['status'],
      paymentedDate: DateTime.parse(json['paymentedDate']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'customerId': customerId,
      'packId': packId,
      'passConfirm': passConfirm,
      'startDate': startDate.toIso8601String(),
      'amount': amount,
      'paypalTransactionId': paypalTransactionId,
      'title': title,
      'description': description,
      'status': status,
      'paymentedDate': paymentedDate.toIso8601String(),
    };
  }
}
