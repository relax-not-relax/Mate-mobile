class DateWeekday {
  final DateTime dateTime;
  final String weekday;
  bool? isSelected;

  DateWeekday({
    required this.dateTime,
    required this.weekday,
    this.isSelected,
  });
}
