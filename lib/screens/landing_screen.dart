import 'package:chat_app/screens/profile_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/landing/landing.dart';
import '../screens/contact_list.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  final thisId = FirebaseAuth.instance.currentUser!.uid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(ContactList.routeName);
        },
        child: const Icon(Icons.contact_page),
      ),
      appBar: AppBar(
        title: const Text("App Messenger"),
        actions: [
          DropdownButton(
            icon: Icon(
              Icons.more_vert,
              color: Theme.of(context).primaryIconTheme.color,
            ),
            items: [
              DropdownMenuItem(
                value: 'logout',
                child: Container(
                  child: Row(
                    children: const <Widget>[
                      Icon(
                        Icons.exit_to_app,
                        color: Colors.red,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text('Logout')
                    ],
                  ),
                ),
              ),
              DropdownMenuItem(
                value: 'profile',
                child: Container(
                  child: Row(
                    children: const <Widget>[
                      Icon(
                        Icons.account_circle,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text('Your Profile')
                    ],
                  ),
                ),
              ),
            ],
            onChanged: (itemIdentifier) {
              if (itemIdentifier == "profile") {
                Navigator.of(context)
                    .pushNamed(Profile.routeName, arguments: {"user": thisId});
              } else if (itemIdentifier == "logout") {
                FirebaseAuth.instance.signOut();
              }
            },
          ),
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chat')
            .where('targetUser', isEqualTo: thisId)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> chatSnap) {
          if (chatSnap.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else {
            return StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('chat')
                  .where('userId', isEqualTo: thisId)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else {
                  final docsChat = chatSnap.data!.docs;
                  final snap = snapshot.data!.docs;
                  var daftar = [];

                  if (docsChat.isEmpty && snap.isEmpty) {
                    print("jalanku");
                    print(snap.length);
                    return const Center(
                      child: Text("Let's Chat Your Friends"),
                    );
                  } else {
                    print("jalannya");
                    for (int i = 0; i < snap.length; i++) {
                      daftar.add(snap[i]['targetUser']);
                    }
                    for (int i = 0; i < docsChat.length; i++) {
                      daftar.add(docsChat[i]['userId']);
                    }
                    return StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .where("userid", whereIn: [...daftar]).snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> userSnap) {
                        if (userSnap.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        final docsUser = userSnap.data!.docs;

                        return ListView.builder(
                          itemCount: docsUser.length,
                          itemBuilder: (ctx, index) => Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5.0, horizontal: 3.0),
                            child: Landing(
                              name: docsUser[index]['username'],
                              userImage: docsUser[index]['imageUrl'],
                              userIdTarget: docsUser[index]['userid'],
                              contact: false,
                            ),
                          ),
                        );
                      },
                    );
                  }
                }
              },
            );
          }
        },
      ),
    );
  }
}
