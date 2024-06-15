class Pack {
  final int packId;
  final double price;
  final String packName;
  final String description;
  final int duration;
  final bool status;

  Pack({
    required this.packId,
    required this.price,
    required this.packName,
    required this.description,
    required this.duration,
    required this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      'packId': packId,
      'price': price,
      'packName': packName,
      'description': description,
      'duration': duration,
      'status': status,
    };
  }

  factory Pack.fromJson(Map<String, dynamic> json) {
    return Pack(
      packId: json['packId'] as int,
      price: json['price'] as double,
      packName: json['packName'],
      description: json['description'],
      duration: json['duration'] as int,
      status: json['status'] as bool,
    );
  }
}
