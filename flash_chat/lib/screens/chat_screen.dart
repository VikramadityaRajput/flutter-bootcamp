import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import 'welcome_screen.dart';

final _firestore = FirebaseFirestore.instance; // the database

class ChatScreen extends StatefulWidget {
  static const String id = 'chat_screen';

  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  String? loggedInUserEmail;
  String messageText = '';

  @override
  void initState() {
    super.initState();
    // Who's signed in right now?
    loggedInUserEmail = _auth.currentUser?.email;
  }

  @override
  void dispose() {
    messageTextController.dispose();
    super.dispose();
  }

  Future<void> signOut() async {
    await _auth.signOut();
    if (!mounted) return;
    Navigator.popUntil(context, ModalRoute.withName(WelcomeScreen.id));
  }

  void sendMessage() {
    if (messageText.trim().isEmpty) return;

    // Write a new document into the "messages" collection.
    _firestore.collection('messages').add({
      'text': messageText.trim(),
      'sender': loggedInUserEmail,
      'createdAt': FieldValue.serverTimestamp(), // let the server timestamp it
    });

    messageTextController.clear();
    messageText = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: signOut,
          ),
        ],
        title: const Text('⚡️ Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            MessagesStream(currentUserEmail: loggedInUserEmail),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: sendMessage,
                    child: const Text('Send', style: kSendButtonTextStyle),
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

// Listens to the messages collection and rebuilds whenever it changes.
class MessagesStream extends StatelessWidget {
  const MessagesStream({super.key, required this.currentUserEmail});

  final String? currentUserEmail;

  @override
  Widget build(BuildContext context) {
    // A Stream is a sequence of values over time. .snapshots() pushes a fresh
    // snapshot every time the collection changes — that's what makes the chat
    // update live, with no refresh button.
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('messages').orderBy('createdAt').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Expanded(
            child: Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.lightBlueAccent,
              ),
            ),
          );
        }

        // Newest first, because the ListView below is reversed.
        final messages = snapshot.data!.docs.reversed;
        final List<MessageBubble> messageBubbles = [];

        for (final message in messages) {
          final data = message.data() as Map<String, dynamic>;
          final text = data['text'] as String? ?? '';
          final sender = data['sender'] as String? ?? '';

          messageBubbles.add(
            MessageBubble(
              sender: sender,
              text: text,
              isMe: currentUserEmail == sender, // my messages look different
            ),
          );
        }

        return Expanded(
          child: ListView(
            reverse: true, // newest at the bottom, scrolled into view
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 20.0,
            ),
            children: messageBubbles,
          ),
        );
      },
    );
  }
}

// One chat bubble. Styled differently depending on whether it's yours.
class MessageBubble extends StatelessWidget {
  const MessageBubble({
    super.key,
    required this.sender,
    required this.text,
    required this.isMe,
  });

  final String sender;
  final String text;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            sender,
            style: const TextStyle(fontSize: 12.0, color: Colors.black54),
          ),
          Material(
            elevation: 5.0,
            color: isMe ? Colors.lightBlueAccent : Colors.white,
            borderRadius: isMe
                ? const BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                  )
                : const BorderRadius.only(
                    topRight: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                  ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 20.0,
              ),
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 15.0,
                  color: isMe ? Colors.white : Colors.black54,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
