class AddToRoomRequest {
  int roomId;
  int customerId;
  DateTime joinDate;

  AddToRoomRequest({
    required this.roomId,
    required this.customerId,
    required this.joinDate,
  });

  factory AddToRoomRequest.fromJson(Map<String, dynamic> json) {
    return AddToRoomRequest(
      roomId: json['roomId'],
      customerId: json['customerId'],
      joinDate: DateTime.parse(json['joinDate']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'roomId': roomId,
      'customerId': customerId,
      'joinDate': joinDate.toIso8601String(),
    };
  }
}
