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
      required AsyncSnapshot<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
          this.users});

  final AsyncSnapshot<List<QueryDocumentSnapshot<Map<String, dynamic>>>> users;

  @override
  State<CreateGroupWidget> createState() => _CreateGroupWidgetState();
}

Map<int, String> selectedUsers = {};

class _CreateGroupWidgetState extends State<CreateGroupWidget> {
  bool tapped = false;
  final TextEditingController textController1 = TextEditingController();


 MyStore store = VxState.store as MyStore;
 


@override
  void dispose() {
    textController1.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final users = widget.users;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;



    return Container(
      height: height * .6,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Select Members"),
            ),
            Container(
              height: height * .03,
              child: TextFormField(
                controller: textController1,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: 'Name',
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
            ),
            Container(
              height: height * .35,
              child: ListView.builder(
                  itemCount: users.data?.length,
                  itemBuilder: ((context, index) {
                    return ListTile(
                      onTap: () {
                        setState(() {
                          tapped = !tapped;
                          if (tapped) {
                            selectedUsers.update(
                              index,
                              (value) => users.data?[index].get("userID"),
                              ifAbsent: () => users.data?[index].get("userID"),
                            );
                          } else {
                            selectedUsers.remove(index);
                          }
                        });
                      },
                      title: Text(users.data?[index].get("name")),
                      selected: tapped,
                      leading: Icon(Icons.person),
                      trailing: Container(
                          width: width * .2,
                          child: Row(children: [
                            Text("Status: "),
                            Icon(
                              Icons.circle,
                              size: 10,
                              color: users.data?[index].get("status")
                                  ? Colors.green
                                  : Colors.red,
                            )
                          ])),
                    );
                  })),
            ),
            Container(
                child: ElevatedButton(
              onPressed: () {


                
                // if (selectedUsers.length > 0) {
                //   FirebaseMethods methods = FirebaseMethods();

                //   methods
                //       .createGroup(List<String>.from(selectedUsers.values),
                //           textController1.text, store.user.userID)
                //       .then((value) => print('Done'))
                //       .onError((error, stackTrace) => print(error));
                // }
              },
              child: Text("Add Group with ${selectedUsers.length} Member(s)"),
            )),
          ]),
    );
  }
}
