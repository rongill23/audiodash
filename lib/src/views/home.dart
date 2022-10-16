import 'package:communication_app/src/views/messages.dart';
import 'package:communication_app/src/widgets/Drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  static const routeName = '/';
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Communication App")),
      drawer: DrawerWidget(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
            height: 300,
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.all(20.0),
              children: [
                Column(
                  children: [
                    ListTile(
                      title: Text("Sample"),
                    )
                  ],
                )
              ],
            )),
      ),
    );
  }
}
