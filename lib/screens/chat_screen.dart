import 'package:flutter/material.dart';
import 'package:zchat/components/widgets.dart';
import 'package:zchat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);
  static String id = 'chat_screen';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  final _controller = TextEditingController();

  String messageText = '';
  late User loggedInUser;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
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
      backgroundColor: kAppBackgroundColor,
      appBar: AppBar(
        leading: null,
        actions: [
          IconButton(
              onPressed: () {
                _auth.signOut();
                Navigator.pop(context);
              },
              icon: const Icon(Icons.close))
        ],
        title: const Text('Chats'),
        backgroundColor: kAppBarBackgroundColor,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            MessageStream(firestore: _firestore),
            Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      child: Padding(
                    padding: kBodyPadding,
                    child: TextField(
                      controller: _controller,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                          hintText: 'Type your message',
                          hintStyle: TextStyle(color: kFocusColor)),
                      style: kThemeTextColor,
                      onChanged: (value) {
                        messageText = value;
                      },
                    ),
                  )),
                  TextButton(
                      onPressed: () {
                        _controller.clear();
                        _firestore.collection('messages').add({
                          'text': messageText,
                          'sender': loggedInUser.email,
                        });
                      },
                      child: const Icon(
                        Icons.send,
                        color: kAppBarBackgroundColor,
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
