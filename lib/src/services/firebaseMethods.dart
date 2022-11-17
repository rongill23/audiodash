import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:communication_app/src/data/store.dart';
import 'package:communication_app/src/models/userInfo.dart';
import 'package:communication_app/src/views/audioTest.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:vxstate/vxstate.dart';

class FirebaseMethods {
  FirebaseFirestore _db = FirebaseFirestore.instance;
  final _storageRef = FirebaseStorage.instance.ref('');

  final metaData = SettableMetadata(contentType: "video/mp4");

  Future<AppUser> getUser(id) async {
    var userTemp = await _db.collection('users').doc(id).get();

    AppUser user =
        AppUser(userTemp["email"], id, userTemp["name"], userTemp["groups"]);

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
        }).then((value) {
          _db
              .collection("groups")
              .doc(messageInfo.groupID)
              .update({"dateOfLastMessage": FieldValue.serverTimestamp()});
        });
      });
    } on Exception catch (e) {
      print(e);
      print("\n\n Howdyyyyyyyyyyyyyyyyyyyy");
    }
  }

// Function that notifies all members of a group that their is a new message | cloud functions

  void createUserInDatabase(user, name) {
    final newUser = <String, dynamic>{
      "userID": user.uid,
      "email": user.email,
      "messages": [],
      "groups": [],
      "name": name,
      "status": true,
    };

    _db.collection("users").doc(user.uid).set(newUser).then((value) {
      debugPrint("Added user");
    });
  }

  Future<void> createGroup(members, groupName, userID) async {
    String id = await _db.collection('groups').doc().id;

    final group = <String, dynamic>{
      "members": members,
      "messages": [],
      "name": groupName,
      "groupID": id,
    };

    _db.collection('groups').doc(id).set(group).then((value) {
      List<String> groupId = [id];
      _db
          .collection('users')
          .doc(userID)
          .update({"groups": FieldValue.arrayUnion(groupId)});
    });
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getAllUserGroups(
      id) async {
    return _db
        .collection("groups")
        .where("members", arrayContains: id)
        .get()
        .then((value) {
      return value.docs;
    }).catchError((onError) {
      print(onError);
    });
    ;
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
      getOtherUsers() async {
    return _db.collection('users').limit(50).get().then((value) {
      return value.docs;
    }).catchError((onError) {
      print(onError);
    });
  }

  Future<List<List<QueryDocumentSnapshot<Map<String, dynamic>>>>>
      loadHomeScreenData(id) async {
    var groups = await getAllUserGroups(id);
    var users = await getAllUserGroups(id);
    return [groups, users];
  }

  Future getMessage(id) async {
    return _db.collection("messages").doc(id).get();
  }
}
