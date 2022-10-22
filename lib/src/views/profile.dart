import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});
  static const routeName = "/profile";
  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile")),
      body: Container(
          height: MediaQuery.of(context).size.height - 56,
          child: Column(
            children: [],
          )),
    );
  }
}
