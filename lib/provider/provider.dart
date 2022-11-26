import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  String userid = "";

  String getUser() {
    return userid;
  }

  Future<void> addUserId(String userId) async {
    userid = userId;
    notifyListeners();
  }
}
