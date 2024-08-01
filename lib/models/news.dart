class News {
  final String avatar;
  final String title;
  final String description;
  final DateTime time;
  bool status;
  final String id;

  News({
    required this.id,
    required this.avatar,
    required this.title,
    required this.description,
    required this.time,
    required this.status,
  });
}
