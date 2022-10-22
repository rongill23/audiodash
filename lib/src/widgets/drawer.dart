import 'package:communication_app/src/views/home.dart';
import 'package:communication_app/src/views/messages.dart';
import 'package:communication_app/src/views/profile.dart';
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
          title: Text("Profile"),
          onTap: (){
            Navigator.restorablePushNamed(context, ProfileView.routeName);
          },
        ),
        ListTile(
          title: Text("Messages"),
          onTap: () {
            Navigator.restorablePushNamed(context, MessagesView.routeName);
          },
        ),
      ],
    ));
  }
}
