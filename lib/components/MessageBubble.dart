import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  MessageBubble({required this.text, required this.sender});

  final String text;
  final String sender;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
        Text(
          sender,
          style: TextStyle(fontSize: 12.0, color: Colors.black54),
        ),
        Material(
          elevation: 5.0,
          borderRadius: BorderRadius.circular(30.0),
          color: Colors.lightBlueAccent,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20.0),
            child: Text(text),
          ),
        ),
      ]),
    );
  }
}
