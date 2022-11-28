// Written by Ronald Gilliard Jr -> https://github.com/rongill23

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:communication_app/src/models/userInfo.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:vxstate/vxstate.dart';

class MyStore extends VxStore {
  final counter = Counter();
  var user = AppUser("", "", "", []);
  String groupID = "";
  Map<String, dynamic> groupInfo = {};
  bool isFetching = false;
  FirebaseFirestore _db = FirebaseFirestore.instance;
  // @override
  // String toString() {
  //   return "{counter: ${counter.count}, isFetching: $isFetching, data: $data}";
  // }
}

class UpdateUserMutation extends VxMutation<MyStore> {
  @override
  void perform() {}

  Future<void> update(user) async {
    store!.user = user;
  }
}

class Counter {
  int count = 0;

  void increment() {
    count++;
  }

  void decrement() {
    count--;
  }
}

class IncrementMutation extends VxMutation<MyStore> {
  @override
  Future<void> perform() async {
    await Future.delayed(const Duration(seconds: 1));
    store?.counter.increment();
  }

  @override
  void onException(e, StackTrace s) {
    super.onException(e, s);
  }
}

class DecrementMutation extends VxMutation<MyStore> {
  @override
  void perform() {
    store?.counter.decrement();
  }
}

abstract class HttpEffects implements VxEffects<http.Response> {
  @override
  Future<void> fork(http.Response result) async {
    if (result.statusCode == 200) {
      success(result);
    } else {
      fail(result);
    }
  }

  void success(http.Response res);
  void fail(http.Response res);
}

// class FetchApi extends VxMutation<MyStore> with HttpEffects {
//   @override
//   void fail(http.Response res) {
//     store?.data = "Failed";
//   }

//   @override
//   Future<http.Response> perform() async {
//     return http.get(Uri.parse("https://en8brj58lmty9.x.pipedream.net"));
//   }

//   @override
//   void success(http.Response res) {
//     store?.data = res.body;
//   }

//   @override
//   void onException(e, s) {
//     store?.data = "Exception";
//     super.onException(e, s);
//   }
// }

class LogInterceptor extends VxInterceptor {
  @override
  void afterMutation(VxMutation<VxStore?> mutation) {
    print("Next State ${mutation.store.toString()}");
  }

  @override
  bool beforeMutation(VxMutation<VxStore?> mutation) {
    print("Prev State ${mutation.store.toString()}");
    return true;
  }
}
