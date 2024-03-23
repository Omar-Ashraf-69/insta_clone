import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FollowingsAndFollowersProvider extends ChangeNotifier {
  int followersCount = 0;
  int followingCount = 0;
  getFollowersAndFollwingCount() async {
    dynamic currentUserData = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    followersCount = currentUserData['followers'].length;

    followingCount = currentUserData['following'].length;
    notifyListeners();
  }
}
