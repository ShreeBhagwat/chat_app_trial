import 'dart:async';
import 'dart:developer';

import 'package:chat_app_main/model/user_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class AuthRepository {
  late FirebaseAuth _firebaseAuth;
  late FirebaseFirestore _firebaseFirestore;
  AuthRepository() {
    _firebaseAuth = FirebaseAuth.instance;
    _firebaseFirestore = FirebaseFirestore.instance;
  }

  Future<UserCredential?> loginWithEmailAndPassword(
      {required String email, required String password}) async {
    UserCredential? userCredential;
    await _firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      userCredential = value;
    }).catchError((e) {
      return e;
    });
    return userCredential;
  }

  Future<UserCredential?> createUserWithEmailAndPassword(
      {required String email, required String password}) async {
    UserCredential? userCredential;
    await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      userCredential = value;
    }).catchError((e) {
      log(e.toString());
      return e;
    });
    return userCredential;
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<bool> addUserToFirestoreDatabase({required UserData userData}) async {
    bool isAdded = false;
    await _firebaseFirestore
        .collection('users')
        .doc(userData.uid)
        .set(userData.toJson())
        .catchError((e) {
      isAdded = false;
    }).then((value) {
      isAdded = true;
    });

    return isAdded;
  }
}
