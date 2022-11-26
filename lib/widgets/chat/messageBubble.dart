import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  MessageBubble(
      {required this.message,
      required this.isMe,
      required this.userImage,
      required this.key,
      required this.senderName,
      required this.userTarget});
  Key key;
  String message;
  bool isMe;
  String senderName;
  final String userImage;
  String userTarget;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Row(
          mainAxisAlignment:
              isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              constraints: BoxConstraints(maxWidth: mediaQuery.width * 0.7),
              decoration: BoxDecoration(
                color: isMe
                    ? Colors.grey[300]
                    : const Color.fromRGBO(106, 247, 130, 1),
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(12),
                  topRight: const Radius.circular(12),
                  bottomRight: isMe
                      ? const Radius.circular(0)
                      : const Radius.circular(12),
                  bottomLeft: !isMe
                      ? const Radius.circular(0)
                      : const Radius.circular(12),
                ),
              ),
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 10,
              ),
              margin: const EdgeInsets.symmetric(
                vertical: 5,
                horizontal: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    senderName,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(message),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
