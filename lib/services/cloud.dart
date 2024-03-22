import 'dart:developer';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
  }) async {
    String response;
    String postId = const Uuid().v1();
    String postPic =
        await StorageMethods().uploadImageToStorage(file, 'posts', true);
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
      response = 'success';
    } catch (e) {
      log("Error Broooooo");
      response = e.toString();
    }
    return response;
  }

  editProfile({
    required String uId,
    required String userName,
    String profilePic = '',
    required String displayName,
    Uint8List? file,
    String bio = '',
  }) async {
    String response = 'some eerror error';
    try {
      profilePic = file != null
          ? await StorageMethods().uploadImageToStorage(file, 'users', false)
          : '';
      if (userName.isNotEmpty && displayName.isNotEmpty) {
        await FirebaseFirestore.instance.collection('users').doc(uId).update({
          'userId': uId,
          'userName': userName,
          'displayName': displayName,
          'bio': bio,
          'profilePic': profilePic,
        });
        
      }
      response = 'success';
    } catch (e) {
      log(e.toString());
      response = e.toString();
    }
    return response;
  }
}
