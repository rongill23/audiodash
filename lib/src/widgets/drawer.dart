import 'package:communication_app/src/views/home.dart';
import 'package:communication_app/src/views/messages.dart';
import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      children: [
        ListTile(
          title: Text("Home"),
          onTap: () {
            Navigator.restorablePushNamed(context, Home.routeName);
          },
        ),
        ListTile(
          title: Text("Item 2"),
        ),
        ListTile(
          title: Text("Item 3"),
          onTap: () {
            Navigator.restorablePushNamed(context, MessagesView.routeName);
          },
        ),
      ],
    ));
  }
}
