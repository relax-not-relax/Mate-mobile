class TotalAttendanceResponse {
  int present;
  int absent;

  TotalAttendanceResponse({required this.present, required this.absent});

  // Tạo từ JSON
  factory TotalAttendanceResponse.fromJson(Map<String, dynamic> json) {
    return TotalAttendanceResponse(
      present: json['present'],
      absent: json['absent'],
    );
  }

  // Chuyển đổi thành JSON
  Map<String, dynamic> toJson() {
    return {
      'present': present,
      'absent': absent,
    };
  }
}
