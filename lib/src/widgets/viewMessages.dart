import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:communication_app/src/services/firebaseMethods.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class MessagesWidget extends StatefulWidget {
  const MessagesWidget({super.key, required this.groupInfo});

  final Map<String, dynamic> groupInfo;
  @override
  State<MessagesWidget> createState() => _MessagesWidgetState();
}

class _MessagesWidgetState extends State<MessagesWidget> {
  FirebaseMethods methods = FirebaseMethods();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.groupInfo["name"]),
        ),
        body: Container(
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("groups")
                .doc(widget.groupInfo["groupID"])
                .snapshots(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data["messages"].length > 0) {
                  List<String> messages = snapshot.data["messages"];
                  return FutureBuilder<dynamic>(
                      future: methods.getMessage(messages[messages.length - 1]),
                      builder: (BuildContext context,
                          AsyncSnapshot<dynamic> snapshot2) {
                        return ListTile(title: Text(snapshot2.data["sentBy"]));
                      });
                }
                return Text("No Messages");
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }
              return Container(
                child: Text("No Data"),
              );
            },
          ),
        ));
  }
}
