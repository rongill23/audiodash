import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CreateGroupWidget extends StatefulWidget {
  const CreateGroupWidget(
      {super.key,
      required AsyncSnapshot<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
          this.users});

  final AsyncSnapshot<List<QueryDocumentSnapshot<Map<String, dynamic>>>> users;
  @override
  State<CreateGroupWidget> createState() => _CreateGroupWidgetState();
}

class _CreateGroupWidgetState extends State<CreateGroupWidget> {
  @override
  Widget build(BuildContext context) {
    final users = widget.users;
    final width = MediaQuery.of(context).size.width;
    return Container(
      height: MediaQuery.of(context).size.height * .6,
      child: Column(children: <Widget>[
        Text("Select Members"),
        ListView.builder(
            itemCount: users.data?.length,
            itemBuilder: ((context, index) {
              return ListTile(
                title: Text(users.data?[index].get("name")),
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
            }))
      ]),
    );
  }
}
