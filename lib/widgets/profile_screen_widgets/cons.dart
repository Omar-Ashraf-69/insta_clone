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
getUserDetials({required String uid}) {
  return  FirebaseFirestore.instance.collection('users').doc(uid).get();
}


getFollowersAndFollwingCount(
  {
    required String userId,
    required int followersCount,
    required int followingCount,
    required bool isFollowing,
  }
) async {
    QuerySnapshot followersCounter = await FirebaseFirestore.instance
        .collection('users')
        .doc( userId)
        .collection('followers')
        .get();
    QuerySnapshot followingCounter = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('following')
        .get();
        followersCounter.docs.isNotEmpty ? isFollowing = true : isFollowing = false;
    
        followersCount = followersCounter.docs.length;

        followingCount = followingCounter.docs.length;
      
  }