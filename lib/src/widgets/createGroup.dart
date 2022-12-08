// Written by Ronald Gilliard Jr -> https://github.com/rongill23


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:communication_app/src/data/store.dart';
import 'package:communication_app/src/services/firebaseMethods.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:vxstate/vxstate.dart';


class CreateGroupWidget extends StatefulWidget {
  const CreateGroupWidget(
      {super.key,
      required List<QueryDocumentSnapshot<Map<String, dynamic>>> this.users});

  final List<QueryDocumentSnapshot<Map<String, dynamic>>> users;

  @override
  State<CreateGroupWidget> createState() => _CreateGroupWidgetState();
}

class _CreateGroupWidgetState extends State<CreateGroupWidget> {
  Map<int, String> selectedUsers = {};
  bool tapped = false;
  late List<dynamic> search;
  final TextEditingController controller = TextEditingController();

  MyStore store = VxState.store as MyStore;

  @override
  void initState() {
    // TODO: implement initState
    search = widget.users
        .where((element) => element["name"]
            .toLowerCase()
            .contains(controller.text.toLowerCase()))
        .toList();
    controller.addListener(() {
      search = widget.users
          .where((element) => element["name"]
              .toLowerCase()
              .contains(controller.text.toLowerCase()))
          .toList();
      setState(() {});
      print(controller.text);
      print(search);
    });

    super.initState();
  }

  @override
  void dispose() {
    selectedUsers = {};
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final users = widget.users;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    // final TextEditingController controller = TextEditingController();
    // List<dynamic> search = users
    //     .where((element) => element["name"].contains(controller.text))
    //     .toList();

    return Container(
      height: height * .6,
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: <
          Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Select Members"),
        ),
        TextFormField(
          controller: controller,
          autofocus: true,
          obscureText: false,
          decoration: InputDecoration(
            hintText: 'Search',
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
                width: 1,
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(4.0),
                topRight: Radius.circular(4.0),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
                width: 1,
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(4.0),
                topRight: Radius.circular(4.0),
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xFFFF0000),
                width: 1,
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(4.0),
                topRight: Radius.circular(4.0),
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xFFFF0000),
                width: 1,
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(4.0),
                topRight: Radius.circular(4.0),
              ),
            ),
          ),
        ),
        Container(
            height: height * .35,
            child: search.length > 0
                ? ListView.builder(
                    itemCount: search.length,
                    itemBuilder: ((context, index) {
                      return ListTile(
                        onTap: () {
                          setState(() {
                            tapped = !tapped;
                            if (tapped) {
                              selectedUsers.update(
                                index,
                                (value) => search[index].get("userID"),
                                ifAbsent: () => search[index].get("userID"),
                              );
                            } else {
                              selectedUsers.remove(index);
                            }
                          });
                        },
                        title: Text(users[index].get("name")),
                        selected: tapped,
                        leading: Icon(Icons.person),
                        trailing: Container(
                            width: width * .2,
                            child: Row(children: [
                              Text("Status: "),
                              Icon(
                                Icons.circle,
                                size: 10,
                                color: users[index].get("status")
                                    ? Colors.green
                                    : Colors.red,
                              )
                            ])),
                      );
                    }))
                : Text("No Results")),
        Container(
            child: ElevatedButton(
          onPressed: () {
            TextEditingController groupNameController = TextEditingController();

            showModalBottomSheet(
                context: context,
                builder: (context) {
                  return Container(
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Group Name:"),
                        ),
                        TextFormField(
                          controller: groupNameController,
                          autofocus: true,
                          obscureText: false,
                          // onChanged: (value) {
                          //   setState(() {
                          //     controller.text = value;
                          //     //   // search = users

                          //     //   //   .where(
                          //     //   //       (element) => element["name"].contains(value))
                          //     //   //   .toList();
                          //   });

                          // },
                          decoration: InputDecoration(
                            hintText: 'Group Name..',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                                width: 1,
                              ),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(4.0),
                                topRight: Radius.circular(4.0),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                                width: 1,
                              ),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(4.0),
                                topRight: Radius.circular(4.0),
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFFF0000),
                                width: 1,
                              ),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(4.0),
                                topRight: Radius.circular(4.0),
                              ),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFFF0000),
                                width: 1,
                              ),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(4.0),
                                topRight: Radius.circular(4.0),
                              ),
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (selectedUsers.length > 0) {
                              FirebaseMethods methods = FirebaseMethods();
                              List<String> values = List<String>.from(selectedUsers.values);
                              values.add(store.user.userID);
                              methods
                                  .createGroup(
                                    values,
                                      groupNameController.text,
                                      store.user.userID)
                                  .then((value) {
                                Navigator.pop(context);
                                Navigator.pop(context);
                              }).onError((error, stackTrace) {
                                print(error);
                              });
                            }
                          },
                          child: Text("Create Group"),
                        ),
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.close)),
                      ],
                    ),
                  );
                });

          },
          child: Text("Add Group with ${selectedUsers.length +1} Member(s)"),
        )),
        IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.close)),
      ]),
    );
  }
}
