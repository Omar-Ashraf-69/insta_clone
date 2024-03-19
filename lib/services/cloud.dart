import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_app/models/post.dart';
import 'package:uuid/uuid.dart';

class CloudMethods {
  //CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<String> addPost({
    required String userId,
    String? profilePic,
    required String displayName,
    required String userName,
    required String postPic,
    required String description,
  }) async {
    String response;
    String postId = const Uuid().v1();
    PostModel postModel = PostModel(
      userId: userId,
      date: DateTime.now(),
      displayName: displayName,
      profilePic: profilePic ?? '',
      userName: userName,
      postId: postId,
      postPic: postPic,
      like: [],
      description: description,
    );
    try {
      await FirebaseFirestore.instance
          .collection('posts')
          .doc(postId)
          .set(postModel.toJson());
      log("Success Brooooo");
      response = 'succes';
    } catch (e) {
      log("Error Broooooo");
      response = e.toString();
    }
    return response;
  }
}
