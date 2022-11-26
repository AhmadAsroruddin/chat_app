import 'dart:io';

import 'package:flutter/material.dart';
import '../picker/user_image_picker.dart';

class AuthForm extends StatefulWidget {
  AuthForm(this.submitFunc, this.isLoading);

  bool isLoading;
  final void Function(String email, String username, String password,
      File userImage, bool isLogin, BuildContext ctx) submitFunc;

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final form_key = GlobalKey<FormState>();
  //this variable initiated by value from form
  String _userName = '';
  String _userEmail = '';
  String _userPassword = '';
  File? _userImage;
  bool _isLogin = true;

  void _pickedImage(File image) {
    _userImage = image;
  }

  void _tryToSubmit() {
    final isValid = form_key.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (_userImage == null && !_isLogin) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please Upload Your Photo Profile"),
        ),
      );
      return;
    }

    if (isValid) {
      form_key.currentState!.save();
      
      widget.submitFunc(_userEmail.trim(), _userName.trim(),
          _userPassword.trim(), _userImage!, _isLogin, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: form_key,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  if (!_isLogin) ImageInput(_pickedImage),
                  TextFormField(
                    key: const ValueKey('email'),
                    validator: (value) {
                      if (value!.isEmpty || !value.contains("@")) {
                        return 'please enter valid email';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: "Email Address",
                    ),
                    onSaved: (value) {
                      _userEmail = value!;
                    },
                  ), //email
                  if (!_isLogin)
                    TextFormField(
                      key: const ValueKey('username'),
                      decoration: const InputDecoration(labelText: "Username"),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your username';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _userName = value!;
                      },
                    ), //username
                  TextFormField(
                    key: const ValueKey('password'),
                    decoration: const InputDecoration(labelText: "Password"),
                    obscureText: true,
                    validator: (value) {
                      if (value!.length <= 3 || value.isEmpty) {
                        return 'Your password is weak, Password must be at least 7 character long';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _userPassword = value!;
                    }, //give option to hide or show password
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  if (widget.isLoading) const CircularProgressIndicator(),
                  if (!widget.isLoading)
                    ElevatedButton(
                      onPressed: _tryToSubmit,
                      child: Text(_isLogin ? "Login" : "SignUp"),
                    ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _isLogin = !_isLogin;
                      });
                    },
                    child: Text(_isLogin
                        ? "Create a new account"
                        : "I Already have an Account"),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
