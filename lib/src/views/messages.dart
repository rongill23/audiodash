import 'package:communication_app/src/widgets/Drawer.dart';
import 'package:flutter/material.dart';

class MessagesView extends StatefulWidget {
  const MessagesView({super.key});

  static const routeName = "/messages";
  @override
  State<MessagesView> createState() => _MessagesViewState();
}

class _MessagesViewState extends State<MessagesView> {
  var messages = ["Hi Annia", "I'm the king"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(

          title: Text("Messages"),
          
        ),
        drawer: DrawerWidget(),
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Text("Messages"),
                  height: MediaQuery.of(context).size.height * .25 - 56,
                ),
                Container(
                  height: MediaQuery.of(context).size.height  * .75,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    itemCount: messages.length,
                      itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(messages[index]),
                      subtitle: Text("From: Howdy"),
                      textColor: Colors.white,
                      trailing: IconButton(onPressed: () {}, icon: Icon(Icons.play_arrow)),
                    );
                  }),
                )
              ],
            )));
  }
}
