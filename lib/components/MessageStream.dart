import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flash_chat/components/MessageBubble.dart';

class MessageStream extends StatelessWidget {
  MessageStream({super.key});

  final _fireStore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _fireStore.collection('messages').snapshots(),
      builder: (context, snapshot) {
        List<MessageBubble> messageBubbles = [];
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.blue,
            ),
          );
        }
        final messages = snapshot.data!.docs;

        for (var message in messages) {
          final messageText = message.get('text');
          final messageSender = message.get('sender');
          var messageBubble =
              MessageBubble(text: messageText, sender: messageSender);

          messageBubbles.add(messageBubble);
        }

        return Expanded(
          child: ListView(
            children: messageBubbles,
          ),
        );
      },
    );
  }
}
