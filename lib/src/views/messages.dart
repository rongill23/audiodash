import 'package:communication_app/src/widgets/Drawer.dart';
import 'package:flutter/material.dart';

class MessagesView extends StatefulWidget {
  const MessagesView({super.key});
  static const routeName = "/messages";
  @override
  State<MessagesView> createState() => _MessagesViewState();
}

class _MessagesViewState extends State<MessagesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Messages"),
        ),
        drawer: DrawerWidget(),
        body: Container(child: Text("Messages")));
  }
}
