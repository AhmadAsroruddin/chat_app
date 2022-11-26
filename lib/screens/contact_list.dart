import 'package:chat_app/screens/chat_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/landing/landing.dart';

class ContactList extends StatefulWidget {
  const ContactList({super.key});

  static const routeName = '/contact_list';

  @override
  State<ContactList> createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contact List"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> userSnap) {
          if (userSnap.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final docsUser = userSnap.data!.docs;
          return ListView.builder(
            itemCount: docsUser.length,
            itemBuilder: (ctx, index) => Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 5.0, horizontal: 3.0),
              child: Landing(
                name: docsUser[index]['username'],
                userImage: docsUser[index]['imageUrl'],
                userIdTarget: docsUser[index]['userid'],
                contact: true,
              ),
            ),
          );
        },
      ),
    );
  }
}
