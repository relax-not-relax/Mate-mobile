class Room {
  final int roomId;
  final int managerId;
  final String roomName;

  Room({
    required this.roomId,
    required this.managerId,
    required this.roomName,
  });

  // fromJson method
  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      roomId: json['roomId'],
      managerId: json['managerId'],
      roomName: json['roomName'],
    );
  }

  // toJson method
  Map<String, dynamic> toJson() {
    return {
      'roomId': roomId,
      'managerId': managerId,
      'roomName': roomName,
    };
  }
}
