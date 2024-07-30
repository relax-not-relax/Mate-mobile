class CheckAttendance {
  int customerId;
  int staffId;
  String status;
  DateTime checkDate;

  CheckAttendance({
    required this.customerId,
    required this.staffId,
    required this.status,
    required this.checkDate,
  });

  // Phương thức chuyển đổi object thành JSON
  Map<String, dynamic> toJson() {
    return {
      'customerId': customerId,
      'staffId': staffId,
      'status': status.toString(),
      'checkDate': checkDate.toIso8601String(),
    };
  }

  // Phương thức tạo object từ JSON
  factory CheckAttendance.fromJson(Map<String, dynamic> json) {
    return CheckAttendance(
      customerId: json['customerId'],
      staffId: json['staffId'],
      status: json['status'],
      checkDate: DateTime.parse(json['checkDate']),
    );
  }
}
