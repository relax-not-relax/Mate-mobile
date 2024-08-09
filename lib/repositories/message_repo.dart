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
            List<Message> listTmp = [];
            for (var ele in element.children) {
              Message message = Message(
                  status: true,
                  customerId:
                      int.parse(ele.child('customerId').value.toString()),
                  avatar: ele.child('avatar').value.toString(),
                  name: ele.child('name').value.toString(),
                  lastMessage: ele.child('lastMessage').value.toString(),
                  time: DateTime.parse(ele.child('time').value.toString()),
                  isAdmin: bool.parse(ele.child('isAdmin').value.toString()));
              listTmp.add(message);
            }
            Message messageWithMaxTime =
                listTmp.reduce((a, b) => a.time.isAfter(b.time) ? a : b);
            rs.add(messageWithMaxTime);
          }
          rs.sort((a, b) => b.time.compareTo(a.time));
        }
        return rs;
      },
    );
    return rs;
  }
}
