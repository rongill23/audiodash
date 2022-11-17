import 'package:communication_app/src/services/firebaseMethods.dart';
import 'package:communication_app/src/views/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Intro extends StatefulWidget {
  const Intro({super.key, required this.id});

  final String id;
  @override
  State<Intro> createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  FirebaseMethods methods = FirebaseMethods();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: methods.getUser(widget.id),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            return Home();
          } else {
            return Scaffold(body: Center(child: Container(child: CircularProgressIndicator())));
          }
        });
  }
}
