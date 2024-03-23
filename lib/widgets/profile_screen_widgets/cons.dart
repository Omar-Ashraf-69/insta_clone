import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Stream<QuerySnapshot> getPostsStream({String? userId}) {
  String currentUserUid = FirebaseAuth.instance.currentUser!.uid;

  return userId == null
      ? FirebaseFirestore.instance
          .collection('posts')
          .where('userId',
              isEqualTo:
                  currentUserUid) // Assuming 'userId' field in Firestore represents the user's UID
          .orderBy('date', descending: true)
          .snapshots()
      : FirebaseFirestore.instance
          .collection('posts')
          .where('userId',
              isEqualTo:
                  userId) // Assuming 'userId' field in Firestore represents the user's UID
          .orderBy('date', descending: true)
          .snapshots();
}

getUserData(String uid) {
  return FirebaseFirestore.instance.collection('users').doc(uid).snapshots();
}
