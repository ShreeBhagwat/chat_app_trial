import 'package:chat_app_main/model/message_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatRepository {
  late FirebaseFirestore _firestore;

  ChatRepository() {
    _firestore = FirebaseFirestore.instance;
  }

   Stream getMessages() async* {
    yield _firestore
        .collection('messages')
        .orderBy('timeStamp', descending: true)
        .snapshots();
   }
  Future sendMessage({required Message message}) async {
    await _firestore.collection('messages').add(message.toJson());
  }
}
