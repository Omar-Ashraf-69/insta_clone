import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String userId;
  String password;
  String email;
  String profilePic;
  List followers;
  List following;
  String displayName;
  String userName;
  String? bio;

  UserModel({
    required this.userId,
    required this.userName,
    required this.displayName,
    required this.email,
    required this.followers,
    required this.following,
    required this.password,
    required this.profilePic,
    this.bio,
  });

  factory UserModel.fromDocument(DocumentSnapshot snap) {
    Map<String, dynamic> snapshot = snap.data() as Map<String, dynamic>;
    return UserModel(
      userId: snapshot['userId'],
      userName: snapshot['userName'],
      displayName: snapshot['displayName'],
      email: snapshot['email'],
      followers: snapshot['followers'],
      following: snapshot['following'],
      password: snapshot['password'],
      profilePic: snapshot['profilePic'],
      bio: snapshot['bio'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'userName': userName,
      'displayName': displayName,
      'email': email,
      'followers': followers,
      'following': following,
      'password': password,
      'profilePic': profilePic,
      'bio': bio,
    };
  }
}
