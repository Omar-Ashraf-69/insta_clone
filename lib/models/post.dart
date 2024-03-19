import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  final String userId;
  String profilePic;
  String displayName;
  String userName;
  DateTime date;
  String postId;
  String postPic;
  dynamic like;
  String description;

  PostModel({
    required this.userId,
    required this.date,
    required this.displayName,
    required this.profilePic,
    required this.userName,
    required this.postId,
    required this.postPic,
    required this.like,
    required this.description,
  });

  factory PostModel.fromDocument(DocumentSnapshot snap) {
    Map<String, dynamic> snapshot = snap.data() as Map<String, dynamic>;
    return PostModel(
      userId: snapshot['userId'],
      date: snapshot['bio'],
      displayName: snapshot['displayName'],
      description: snapshot['description'],
      like: snapshot['like'],
      postId: snapshot['postId'],
      postPic: snapshot['postPic'],
      profilePic: snapshot['profilePic'],
      userName: snapshot['userName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'bio': date,
      'displayName': displayName,
      'like':like ,
      'userName': userName,
      'profilePic': profilePic,
      'postPic': postPic,
      'postId': postId,
      'description': description,
    };
  }
}
