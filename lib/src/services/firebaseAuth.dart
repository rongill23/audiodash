import 'package:communication_app/src/data/store.dart';
import 'package:communication_app/src/models/userInfo.dart';
import 'package:communication_app/src/services/firebaseMethods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/rendering.dart';
import 'package:vxstate/vxstate.dart';

class Authentication {
  FirebaseAuth instance = FirebaseAuth.instance;
  FirebaseMethods methods = FirebaseMethods();
  Future<AppUser?> signInWithEmailAndPassword(email, password) async {

      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) async {

        var user = await methods.getUser(value.user?.uid);
        UpdateUserMutation updateUserMutation = UpdateUserMutation();
        updateUserMutation.update(user);
        debugPrint("Signed in");
        return user;
      });
    
  }

  void registerWithEmailAndPassword(email, password, name) {
    instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      methods.createUserInDatabase(value.user, name);
    });
  }

  signOut() {
    instance.signOut().then((value) => {print("Signed Out")});
  }
}
