import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:communication_app/src/models/userInfo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class FirebaseMethods {
  FirebaseFirestore _db = FirebaseFirestore.instance;
  final _storageRef = FirebaseStorage.instance.ref('');

  final metaData = SettableMetadata(contentType: "video/mp4");

  Future<AppUser> getUser(id) async {
    var userTemp = await _db.collection('users').doc(id).get();

    AppUser user = AppUser();

    user.email = userTemp["email"];
    user.name = userTemp["name"];
    user.groups = userTemp["groups"];
    return user;
  }

  void createAudioMessage(file, messageInfo) {
    String id = _db.collection('messages').doc().id;

    try {
      late final audio_storageRef =
          _storageRef.child('audio/${messageInfo.groupID}/audio.mp4');
      audio_storageRef.putFile(file, metaData).then((p0) {
        print("\n\n Done");
        _db.collection('messages').doc(id).set({
          "audioURL": "audio/${messageInfo.groupID}/audio.mp4",
          "sentFrom": messageInfo.userID,
          "groupID": messageInfo.groupID
        });
      });
    } on Exception catch (e) {
      print(e);
      print("\n\n Howdyyyyyyyyyyyyyyyyyyyy");
    }
  }

  void createUserInDatabase(user, name) {
    final newUser = <String, dynamic>{
      "userID": user.uid,
      "email": user.email,
      "messages": [],
      "groups": [],
      "name": name,
      "status": true,
    };

    _db.collection("users").add(newUser).then((value) {
      debugPrint("Added user");
    });
  }

  Future<void> createGroup(groupInfo) async {
    String id = await _db.collection('groups').doc().id;

    final group = <String, dynamic>{
      "members": groupInfo.members,
      "messages": [],
      "createdOn": FieldValue.serverTimestamp(),
      "groupID": id
    };

    _db.collection('groups').doc(id).set(group);
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getOtherUsers() async {

    return  _db.collection('users').limit(50).get().then((value) {return value.docs;});

  }
}
