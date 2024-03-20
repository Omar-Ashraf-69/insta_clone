import 'dart:developer';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_app/models/post.dart';
import 'package:social_app/services/storage.dart';
import 'package:uuid/uuid.dart';

class CloudMethods {
  //CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<String> addPost({
    required String userId,
    String? profilePic,
    required String displayName,
    required String userName,
    required Uint8List file,
    required String description,
  }) async  {
    String response;
    String postId = const Uuid().v1();
    String postPic = await StorageMethods().uploadImageToStorage(file);
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
