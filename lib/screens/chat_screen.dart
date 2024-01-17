import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _firebasestore = FirebaseFirestore.instance;
User? loggedInUser;

class ChatScreen extends StatefulWidget {
  static const String id = 'chat_screen';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextController = TextEditingController();
  late String messagesText;
  final _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                _auth.signOut();
                Navigator.pop(context);
              }),
        ],
        title: const Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const MessageStream(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      onChanged: (value) {
                        messagesText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      messageTextController.clear();
                      _firebasestore.collection('messages').add({
                        'text': messagesText,
                        'sender': loggedInUser!.email,
                        'ts': Timestamp.now(),
                      });
                    },
                    child: const Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageStream extends StatelessWidget {
  const MessageStream({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firebasestore.collection('messages').orderBy('ts',descending: true).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        //final messages = snapshot.data!.docs;
        List<MessageBubble> messageBubbles = [];
        for (var message in snapshot.data!.docs) {
          final data = message.data() as Map;
          final messageText = data['text'];
          final messageSender = data['sender'];
          final Timestamp messageTime = message['ts'] as Timestamp;
          final currentUser = loggedInUser!.email;

          final messageBubble = MessageBubble(
              text: messageText,
              sender: messageSender,
              isMe: currentUser == messageSender,
              time: messageTime,
             );

          messageBubbles.add(messageBubble);
        }
        return Expanded(
            child: ListView(
          reverse: true,
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
          children: messageBubbles,
        ));
      },
    );
  }
}

class MessageBubble extends StatelessWidget {
  final String? sender;
  final String? text;
  final bool isMe;
  final Timestamp? time;

  MessageBubble({this.sender, this.text, required this.isMe, this.time});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column( crossAxisAlignment: isMe? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(
          sender!,
          style: const TextStyle(
            color: Colors.black54,
          ),
        ),
        Material(
            borderRadius: isMe? const BorderRadius.only(
                bottomLeft: Radius.circular(30.0),
                topLeft: Radius.circular(30.0),
                bottomRight: Radius.circular(30.0)):
                const BorderRadius.only(
                bottomLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
                bottomRight: Radius.circular(30.0)),
                elevation: 5.0,
            color: isMe ? Colors.lightBlueAccent: Colors.white,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Text(
                text!,
                style: TextStyle(
                  color: isMe ? Colors.white: Colors.black54,
                  fontSize: 15.0,
                ),
              ),
            )),
            Text(
            time!.toDate().toString(),
            style: const TextStyle(
              fontSize: 12.0,
              color: Colors.black54,
            ),
          ),
      ]),
    );
  }
}
