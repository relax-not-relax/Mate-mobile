class Attendance {
  final int attendanceId;
  final int customerId;
  final int staffId;
  final DateTime checkDate;
  final int status;

  const Attendance({
    required this.attendanceId,
    required this.customerId,
    required this.staffId,
    required this.checkDate,
    required this.status,
  });
}
