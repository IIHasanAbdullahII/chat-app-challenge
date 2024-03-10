import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MessageBubble extends StatelessWidget {
  final String? sender;
  final String? text;
  final bool isMe;
  final Timestamp? time;

  MessageBubble({this.sender, this.text, required this.isMe, this.time});

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = time!.toDate();
    String formattedTime = DateFormat.jm().format(dateTime);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      child: 
      Row(
        mainAxisAlignment: isMe? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: isMe? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          isMe ?  const SizedBox() : const CircleAvatar(
            radius: 25,
            backgroundImage: AssetImage("images/facebook.png"),
          ),
          const SizedBox(width: 5,),
          Column(
            crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              isMe ? const SizedBox() : Text(
          sender!,
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
              const SizedBox(height: 5,),
              Material(
            borderRadius: isMe? const BorderRadius.only(
                bottomLeft: Radius.circular(30.0),
                topLeft: Radius.circular(30.0),
                bottomRight: Radius.circular(30.0)):
                const BorderRadius.only(
                bottomLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
                bottomRight: Radius.circular(30.0)),
                
            color: isMe ? Colors.lightBlueAccent: Colors.black54,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Text(
                text!,
                style: TextStyle(
                  color: isMe ? Colors.white: Colors.white,
                  fontSize: 15.0,
                ),
              ),
            )),
            const SizedBox(height: 5),
            Text(
            formattedTime.toString(),
            style: const TextStyle(
              fontSize: 12.0,
              color: Colors.black54,
            ),
          ),
            ],
          ),
          
        ],
      )
    );
  }
}