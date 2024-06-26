class Location {
  final String display_name;
  final int place_id;

  const Location({
    required this.display_name,
    required this.place_id,
  });

  Map<String, dynamic> toJson() {
    return {'place_id': place_id, 'display_name': display_name};
  }

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      display_name: json['display_name'] as String,
      place_id: json['place_id'] as int,
    );
  }

  @override
  String toString() {
    return 'Location{display_name: $display_name, place_id: $place_id,}';
  }
}
