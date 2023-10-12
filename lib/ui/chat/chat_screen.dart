import 'dart:developer';

import 'package:chat_app_main/model/message_data.dart';
import 'package:chat_app_main/repository/chat/chat_repository.dart';
import 'package:chat_app_main/ui/chat/widgets/send_message_box.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});


  final TextEditingController _messageController = TextEditingController();

  final ChatRepository _chatRepository = ChatRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Screen'),
      ),
      body: Stack(
        children: [
          Positioned(
            bottom: 100,
            left: 0,
            right: 0,
            top: 0,
            child: SizedBox(
              height: MediaQuery.of(context).size.height - 158,
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('messages')
                      .orderBy('timeStamp', descending: true)
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasData) {
                      return ListView.builder(
                        reverse: true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          return Text(
                              snapshot.data!.docs[index]['messageBody']);
                        },
                      );
                    } else {
                      return const Center(
                        child: Text('No messages'),
                      );
                    }
                  }),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SendMessageBox(
              messageController: _messageController,
              onPressed: () async {
                log('Send button pressed');
                await sendMessage();
                _messageController.clear();
              },
            ),
          )
        ],
      ),
    );
  }

  Future sendMessage() async {
    final uid = await FirebaseAuth.instance.currentUser!.uid;
    final timeStamp = DateTime.now().millisecondsSinceEpoch;
    final message = Message(
        messageBody: _messageController.text,
        senderUid: uid,
        senderEmail: '',
        timeStamp: timeStamp.toString(),
        receiverUid: '');
    _chatRepository.sendMessage(message: message);
  }
}
