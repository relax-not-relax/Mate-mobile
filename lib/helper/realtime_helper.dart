import 'package:firebase_database/firebase_database.dart';
import 'package:mate_project/models/message.dart';
import 'package:mate_project/models/notification.dart';

class RealTimeHelper {
  static final DatabaseReference database = FirebaseDatabase.instance.ref();
  static void sendMessage(Message message) {
    Map<String, dynamic> messageData = {
      'isAdmin': message.isAdmin,
      'avatar': message.avatar,
      'time': message.time.toString(),
      'lastMessage': message.lastMessage,
      'name': message.name,
      'customerId': message.customerId
    };
    DatabaseReference newMessageRef =
        database.child('chats/customer${message.customerId}').push();
    newMessageRef.set(messageData);
  }

  static void sendNotification(NotificationStaff notificaton) {
    DatabaseReference newMessageRef =
        database.child('notifications/staff${notificaton.staffId}').push();
    newMessageRef.set(notificaton.toJson());
  }
}
