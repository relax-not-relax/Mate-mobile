import 'package:firebase_database/firebase_database.dart';
import 'package:mate_project/models/message.dart';

class MessageRepository {
  final DatabaseReference database = FirebaseDatabase.instance.ref();
  Future<List<Message>> getListMessage() async {
    List<Message> rs = [];
    await database.child('chats').once().then(
      (value) {
        if (value.snapshot.exists) {
          for (var element in value.snapshot.children) {
            var ele = element.children.last;
            Message message = Message(
                status: true,
                customerId: int.parse(ele.child('customerId').value.toString()),
                avatar: ele.child('avatar').value.toString(),
                name: ele.child('name').value.toString(),
                lastMessage: ele.child('lastMessage').value.toString(),
                time: DateTime.parse(ele.child('time').value.toString()),
                isAdmin: bool.parse(ele.child('isAdmin').value.toString()));
            rs.add(message);
          }
        }
        return rs;
      },
    );
    return rs;
  }
}
