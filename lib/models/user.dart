import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String userId;
  String password;
  String email;
  String profilePic;
  List followers;
  List following;
  String displayName;
  String bio;

  UserModel({
    required this.userId,
    required this.bio,
    required this.displayName,
    required this.email,
    required this.followers,
    required this.following,
    required this.password,
    required this.profilePic,
  });

  factory UserModel.fromDocument(DocumentSnapshot snap) {
    Map<String, dynamic> snapshot = snap.data() as Map<String, dynamic>;
    return UserModel(
      userId: snapshot['userId'],
      bio: snapshot['bio'],
      displayName: snapshot['displayName'],
      email: snapshot['email'],
      followers: snapshot['followers'],
      following: snapshot['following'],
      password: snapshot['password'],
      profilePic: snapshot['profilePic'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId':userId,
      'bio':bio,
      'displayName':displayName,
      'email':email,
      'followers':followers,
      'following':following,
      'password':password,
      'profilePic':profilePic,
    };
  }
}
