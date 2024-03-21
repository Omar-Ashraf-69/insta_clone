import 'package:flutter/material.dart';
import 'package:social_app/models/user.dart';
import 'package:social_app/services/auth.dart';

class UserProvider with ChangeNotifier {
  UserModel? user;
  bool isLoading = true;

  getUserDetails() async {
    user = await Authentication().getUserDetails();
    isLoading = false;
    notifyListeners();
  }
}
