import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import './messageBubble.dart';
import '../../provider/provider.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    String userIdTarget = Provider.of<UserProvider>(context).getUser();
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .where('userId', whereIn: [userIdTarget, user?.uid])
          .orderBy(
            'createdAt',
            descending: true,
          )
          .snapshots(),
      builder: (ctx, AsyncSnapshot<QuerySnapshot> chatSnap) {
        if (chatSnap.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final chatDocs = chatSnap.data!.docs;

        return ListView.builder(
          reverse: true,
          shrinkWrap: true,
          itemCount: chatDocs.length,
          itemBuilder: (ctx, index) {
            return Padding(
              padding: const EdgeInsets.only(top: 1.0),
              child: chatDocs[index]['targetUser'] != user?.uid &&
                      chatDocs[index]['targetUser'] != userIdTarget
                  ? null
                  : MessageBubble(
                      message: chatDocs[index]['text'],
                      senderName: chatDocs[index]['senderName'],
                      isMe: chatDocs[index]['userId'] == user?.uid,
                      userImage: chatDocs[index]['imageUrl'],
                      userTarget: chatDocs[index]['targetUser'],
                      key: ValueKey(chatDocs[index].id),
                    ),
            );
          },
        );
      },
    );
  }
}
