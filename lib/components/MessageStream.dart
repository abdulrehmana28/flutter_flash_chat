import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flash_chat/components/MessageBubble.dart';
import 'package:flutter_flash_chat/screens/chat_screen.dart';

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

        messages.sort((a, b) {
          Timestamp aTimestamp = a['timestamp'] ?? Timestamp.now();
          Timestamp bTimestamp = b['timestamp'] ?? Timestamp.now();
          return bTimestamp.compareTo(aTimestamp);
        });

        for (var message in messages) {
          final messageText = message.get('text');
          final messageSender = message.get('sender');
          final currentUser = loggedInUser!.email;
          var messageBubble = MessageBubble(
            text: messageText,
            sender: messageSender,
            isMe: currentUser == messageSender,
          );

          messageBubbles.add(messageBubble);
        }

        return Expanded(
          child: ListView(
            reverse: true,
            children: messageBubbles,
          ),
        );
      },
    );
  }
}
