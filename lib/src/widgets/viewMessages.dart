import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:communication_app/src/services/firebaseMethods.dart';
import 'package:communication_app/src/widgets/playAudioMessageWidget.dart';
import 'package:communication_app/src/widgets/recordAudioMessage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

// Written by Ronald Gilliard Jr -> https://github.com/rongill23

class MessagesWidget extends StatefulWidget {
  const MessagesWidget({super.key, required this.groupInfo});
  static const routeName = "/messagesWidget";
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
          actions: [
            IconButton(
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      builder: ((context) {
                        return SizedBox(
                          height: MediaQuery.of(context).size.height * .6,
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  child: Text("Group Members"),
                                ),
                              ),
                              ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: widget.groupInfo["members"].length,
                                  itemBuilder: ((context, index) {
                                    return FutureBuilder(
                                      future: methods.getUser(
                                          widget.groupInfo["members"][index]),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return ListTile(
                                            leading: Icon(Icons.person),
                                            title: Text(snapshot.data!.name),
                                            trailing: Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .3,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    .2,
                                                child: Row(children: [
                                                  Text("Status: "),
                                                  Icon(
                                                    Icons.circle,
                                                    size: 10,
                                                    color: snapshot.data!.status
                                                        ? Colors.green
                                                        : Colors.red,
                                                  )
                                                ])),
                                          );
                                        }

                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        }
                                        return Container(
                                          child: Text("No Data"),
                                        );
                                      },
                                    );
                                  })),
                              IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: Icon(Icons.close)),
                            ],
                          ),
                        );
                      }));
                },
                icon: Icon(Icons.people))
          ],
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
                  List<dynamic> messages = snapshot.data["messages"];
                  return Container(
                    child: Column(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * .7,
                          child: ListView.builder(
                              itemCount: messages.length,
                              itemBuilder: ((context, index) {
                                return FutureBuilder<dynamic>(
                                    future: methods.getMessage(messages[index]),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<dynamic> snapshot2) {
                                      if (snapshot2.connectionState ==
                                          ConnectionState.waiting) {
                                        return Center(
                                            child: CircularProgressIndicator());
                                      }
                                      if (snapshot2.hasData) {
                                        return Container(
                                          child: Column(
                                            children: [
                                              PlayAudioMessage(
                                                messageInfo: {
                                                  "sentBy":
                                                      snapshot2.data["sentBy"],
                                                  "groupID": widget
                                                      .groupInfo["groupID"],
                                                  "messageID": messages[index],
                                                  "timestamp": snapshot2
                                                      .data["timestamp"]
                                                },
                                              ),
                                            ],
                                          ),
                                        );
                                      }
                                      if (snapshot.connectionState ==
                                          ConnectionState.none) {
                                        return Center(
                                          child: Text("No Internet Connection"),
                                        );
                                      }

                                      return Center(
                                        child: Text("Error Getting Message"),
                                      );
                                    });
                              })),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: ElevatedButton.icon(
                              onPressed: () {
                                showModalBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return Container(
                                        child: Center(
                                          child: RecordAudioMessage(),
                                        ),
                                      );
                                    });
                              },
                              icon: Icon(Icons.mic),
                              label: Text("Send Message")),
                        )
                      ],
                    ),
                  );
                  return FutureBuilder<dynamic>(
                      future: methods.getMessage(messages[messages.length - 1]),
                      builder: (BuildContext context,
                          AsyncSnapshot<dynamic> snapshot2) {
                        if (snapshot2.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }
                        if (snapshot2.hasData) {
                          return ListTile(
                              title: Text(snapshot2.data["sentBy"]));
                        }
                        if (snapshot.connectionState == ConnectionState.none) {
                          return Center(
                            child: Text("No Internet Connection"),
                          );
                        }

                        return Center(
                          child: Text("Error Getting Message"),
                        );
                      });
                }
                return Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("No Messages"),
                    ),
                    Expanded(child: Container()),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: ElevatedButton.icon(
                          onPressed: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return Container(
                                    child: Center(
                                      child: RecordAudioMessage(),
                                    ),
                                  );
                                });
                          },
                          icon: Icon(Icons.mic),
                          label: Text("Send Message")),
                    )
                  ],
                ));
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
