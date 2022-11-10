import 'package:communication_app/src/services/firebaseAuth.dart';
import 'package:communication_app/src/views/audioRecorder.dart';
import 'package:communication_app/src/views/audioTest.dart';
import 'package:communication_app/src/views/home.dart';
import 'package:communication_app/src/views/login.dart';
import 'package:communication_app/src/views/messages.dart';
import 'package:communication_app/src/views/profile.dart';
import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {

    Authentication auth = Authentication();


    return SafeArea(
      child: Drawer(
          child: Column(
        children: [
          ListTile(
            title: Text("Home"),
            onTap: () {
              Navigator.restorablePushNamed(context, Home.routeName);
            },
          ),
          ListTile(
            title: Text("Profile"),
            onTap: () {
              Navigator.restorablePushNamed(context, ProfileView.routeName);
            },
          ),
          ListTile(
            title: Text("Messages"),
            onTap: () {
              Navigator.restorablePushNamed(context, MessagesView.routeName);
            },
          ),
          ListTile(
            title: Text("Recorder"),
            onTap: () {
              Navigator.restorablePushNamed(context, SimpleRecorder.routeName);
            },
          ),
          ListTile(
            title: Text("LoginPage"),
            onTap: () {
              Navigator.restorablePushNamed(context, LogInPageWidget.routeName);
            },
          ),
           ListTile(
            title: Text("Record Audio"),
            onTap: () {
              Navigator.restorablePushNamed(context, AudioRecorder.routeName);
            },
          ),
          Expanded(
              child: Align(
            alignment: FractionalOffset.bottomCenter,
            child: ListTile(
              onTap: (){
                auth.signOut();
              },
              title: Text("Sign Out"),
            ),
          ))
        ],
      )),
    );
  }
}
