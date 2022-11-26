import 'package:flutter/material.dart';
import '../widgets/chat/messages.dart';
import '../widgets/chat/newMessages.dart';

class ChatScreen extends StatefulWidget {
  static const routeName = '/chatscreen';

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments as Map;
    return Scaffold(
      appBar: AppBar(
        title: Text(arguments['targetName']),
      ),
      body: Container(
        child: Column(
          children: <Widget>[Expanded(child: Messages()), NewMessages()],
        ),
      ),
    );
  }
}
