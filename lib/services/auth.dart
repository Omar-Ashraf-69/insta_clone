import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

class Authentication {
  Future<void>  createUserWithEmailAndPassword(
      {required String email, required String pass}) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: pass,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        log('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        log('The account already exists for that email.');
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
      if (e.code == 'user-not-found') {
        log('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        log('Wrong password provided for that user.');
      }
    }
  }
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
