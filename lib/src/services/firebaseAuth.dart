import 'package:communication_app/src/data/store.dart';
import 'package:communication_app/src/services/firebaseMethods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/rendering.dart';
import 'package:vxstate/vxstate.dart';

class Authentication {
  FirebaseAuth instance = FirebaseAuth.instance;
  FirebaseMethods methods = FirebaseMethods();
  Future<bool?> signInWithEmailAndPassword(email, password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        final MyStore store = VxState.store as MyStore;

        var user = await methods.getUser(value.user?.uid);

        UpdateUserMutation updateUserMutation = UpdateUserMutation();

        await updateUserMutation.update(user).then((value) {
          print(user.email);
        });
        debugPrint("Signed in");
        return true;
      });
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  void registerWithEmailAndPassword(email, password, name) {
    instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      methods.createUserInDatabase(value.user, name);
    });
  }

  signOut() {
    instance.signOut();
  }
}
