import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../widgets/auth/auth_form.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isLoading = false;

  void _submit(String email, String username, String password, File image,
      bool isLogin, BuildContext ctx) async {
    UserCredential authResult;
    setState(() {
      isLoading = true;
    });
    final addExtraData;
    try {
      if (isLogin) {
        authResult = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        final ref = FirebaseStorage.instance
            .ref()
            .child('user_image')
            .child('${authResult.user!.uid}.jpg');
        await ref.putFile(image);
        final imageUrl = await ref.getDownloadURL();
        await FirebaseFirestore.instance
            .collection("users")
            .doc(authResult.user!.uid)
            .set(
          {
            'username': username,
            'email': email,
            'imageUrl': imageUrl,
            'userid': authResult.user!.uid
          },
        );
      }
  
      setState(() {
        isLoading = false;
      });
    } catch (err) {
      setState(() {
        isLoading = false;
      });

      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
        content: const Text("Username atau Password anda salah"),
        backgroundColor: Theme.of(ctx).errorColor,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: AuthForm(_submit, isLoading));
  }
}
