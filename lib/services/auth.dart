import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_app/models/user.dart';

class Authentication {
  Future<void> createUserWithEmailAndPassword(
      {required String email,
      required String pass,
      required String displayName,
      required String userName}) async {
    try {
      final userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: pass,
      );
      UserModel userModel = UserModel(
        userId: userCredential.user!.uid,
        bio: '',
        displayName: displayName,
        email: email,
        followers: [],
        following: [],
        password: pass,
        profilePic: '',
      );
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set(userModel.toJson());

      log("Done Brrrrrrrrro");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        log('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        log('The account already exists for that email.');
      } else {
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> signInWithEmailAndPassword(
      {required String email, required String pass}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: pass);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        log('No user found for that email.');
      } else if (e.code == 'invalid-credential') {
        log('Wrong password provided for that user.');
      } 
      else {
        log("Error ${e.code}");
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
