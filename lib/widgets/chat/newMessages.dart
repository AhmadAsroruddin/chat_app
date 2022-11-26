import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/provider.dart';

class NewMessages extends StatefulWidget {
  const NewMessages({Key? key}) : super(key: key);

  @override
  State<NewMessages> createState() => _NewMessagesState();
}

class _NewMessagesState extends State<NewMessages> {
  var _enteredMessages = '';
  // ignore: unnecessary_new
  final textFieldController = new TextEditingController();

  void _sendMesseges() async {
    FocusScope.of(context).unfocus();
    final user = FirebaseAuth.instance.currentUser;
    //user Target
    final userTarget =
        Provider.of<UserProvider>(context, listen: false).getUser();
    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get();
    FirebaseFirestore.instance.collection('chat').add(
      {
        'text': _enteredMessages,
        'createdAt': Timestamp.now(),
        'userId': user.uid,
        'senderName': userData['username'],
        'imageUrl': userData['imageUrl'],
        'targetUser': userTarget
      },
    );
    textFieldController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextFormField(
              controller: textFieldController,
              decoration: const InputDecoration(
                labelText: "Send Messages",
              ),
              onChanged: ((value) {
                setState(() {
                  _enteredMessages = value;
                });
              }),
            ),
          ),
          IconButton(
              color: Theme.of(context).primaryColor,
              icon: const Icon(Icons.send),
              onPressed:
                  _enteredMessages.isEmpty ? null : () => _sendMesseges())
        ],
      ),
    );
  }
}
