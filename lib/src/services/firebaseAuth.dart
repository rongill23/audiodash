// Written by Ronald Gilliard Jr -> https://github.com/rongill23

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:communication_app/src/data/store.dart';
import 'package:communication_app/src/models/userInfo.dart';
import 'package:communication_app/src/services/firebaseMethods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/rendering.dart';
import 'package:vxstate/vxstate.dart';

class Authentication {
  FirebaseAuth instance = FirebaseAuth.instance;
  FirebaseMethods methods = FirebaseMethods();
  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<AppUser?> signInWithEmailAndPassword(email, password) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) async {
      var user = await methods.getUser(value.user?.uid);

      db
          .collection("users")
          .doc(user.userID)
          .update({"status": true})
          .then((value) => {})
          .catchError((onError) {
            print(onError);
          });

      UpdateUserMutation updateUserMutation = UpdateUserMutation();
      updateUserMutation.update(user);
      debugPrint("Signed in");
      return user;
    }).catchError((onError) {
      print(onError);
    });
  }

  void registerWithEmailAndPassword(email, password, name) {
    instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      methods.createUserInDatabase(value.user, name);
    }).catchError((onError) {
      print(onError);
    });
  }

  signOut(id) {
    instance.signOut().then((value) {
      FirebaseFirestore instance = FirebaseFirestore.instance;
      instance.collection("users").doc(id).update({"status": false});
    }).catchError((onError) {
      print(onError);
    });
  }
}
