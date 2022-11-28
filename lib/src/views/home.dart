import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:communication_app/src/data/store.dart';
import 'package:communication_app/src/services/firebaseAuth.dart';
import 'package:communication_app/src/services/firebaseMethods.dart';
import 'package:communication_app/src/views/login.dart';
import 'package:communication_app/src/widgets/createGroup.dart';
import 'package:communication_app/src/widgets/drawer.dart';
import 'package:communication_app/src/widgets/viewMessages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vxstate/vxstate.dart';

FirebaseMethods methods = FirebaseMethods();

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  static const routeName = "/";

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  MyStore store = VxState.store as MyStore;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      key: scaffoldKey,
      drawer: DrawerWidget(),
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.1),
        child: AppBar(
          title: Text(
            'Home Page',
          ),
          iconTheme: IconThemeData(color: Colors.white),
          centerTitle: true,
          elevation: 8,
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {});
                },
                icon: Icon(Icons.refresh))
          ],
        ),
      ),
      body: SafeArea(
          child: GestureDetector(
              child: FutureBuilder<
                      List<List<QueryDocumentSnapshot<Map<String, dynamic>>>>>(
                  future: methods.loadHomeScreenData(store.user.userID),
                  builder: (context,
                      AsyncSnapshot<
                              List<
                                  List<
                                      QueryDocumentSnapshot<
                                          Map<String, dynamic>>>>>
                          snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasData) {
                      return Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 100,
                            decoration: BoxDecoration(),
                            alignment: AlignmentDirectional(0, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Align(
                                  alignment: AlignmentDirectional(0, 0),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        10, 0, 0, 0),
                                    child: Container(
                                      width: 60,
                                      height: 60,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Align(
                                    alignment: AlignmentDirectional(-0.75, 0),
                                    child: Text(
                                      'Welcome back, ${store.user.name}',
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Align(
                                    alignment: AlignmentDirectional(1, 0),
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        Authentication auth = Authentication();
                                        auth.signOut(store.user.userID);
                                      },
                                      child: Text('Sign Out'),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Align(
                              alignment: AlignmentDirectional(0, 0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Divider(
                                    height: 1,
                                    thickness: 1,
                                    color: Color(0x84848484),
                                  ),
                                  Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Align(
                                          alignment: AlignmentDirectional(0, 0),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    16, 0, 0, 0),
                                            child: Text(
                                              'My Groups',
                                            ),
                                          ),
                                        ),
                                        IconButton(
                                            color: Colors.transparent,
                                            iconSize: 40,
                                            icon: Icon(
                                              Icons.add_circle,
                                              color: Color(0xFF00FF2A),
                                              size: 20,
                                            ),
                                            onPressed: () async {
                                              showModalBottomSheet(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    height: height * .6,
                                                    child: CreateGroupWidget(
                                                        users:
                                                            snapshot.data![1]),
                                                  );
                                                },
                                              );
                                            })
                                      ]),
                                  ListView(
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    children: [
                                      Container(
                                        width: 100,
                                        height: height * .4,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            FutureBuilder(
                                                future:
                                                    methods.getAllUserGroups(
                                                        store.user.userID),
                                                builder: (context,
                                                    AsyncSnapshot<
                                                            List<
                                                                QueryDocumentSnapshot<
                                                                    Map<String,
                                                                        dynamic>>>>
                                                        snapshot2) {
                                                  return Container(
                                                    height: height * .25,
                                                    width: width,
                                                    child: ListView.builder(
                                                        itemCount: snapshot2
                                                            .data?.length,
                                                        itemBuilder:
                                                            (BuildContext
                                                                    context,
                                                                int index) {
                                                          return ListTile(
                                                            leading: Icon(Icons.people),
                                                            title: Text(snapshot2
                                                                    .hasData
                                                                ? snapshot2
                                                                    .data![
                                                                        index]
                                                                    .get("name")
                                                                : ""),
                                                            onTap: () {
                                                              store.groupID =
                                                                  snapshot2
                                                                      .data![
                                                                          index]
                                                                      .get(
                                                                          "groupID");
                                                              store.groupInfo =
                                                                  {
                                                                "members": snapshot2.data![index].get("members"),
                                                                "groupID": snapshot2
                                                                    .data![
                                                                        index]
                                                                    .get(
                                                                        "groupID"),
                                                                "name": snapshot2
                                                                    .data![
                                                                        index]
                                                                    .get(
                                                                        "name"),
                                                              };
                                                              Navigator.pushNamed(
                                                                  context,
                                                                  MessagesWidget
                                                                      .routeName);

                                                              // showBottomSheet(
                                                              //     context:
                                                              //         context,
                                                              //     builder:
                                                              //         (context) {
                                                              //       return MessagesWidget(
                                                              //           groupInfo: {
                                                              //             "groupID": snapshot2
                                                              //                 .data![index]
                                                              //                 .get("groupID"),
                                                              //             "name": snapshot2
                                                              //                 .data![index]
                                                              //                 .get("name"),
                                                              //           });
                                                              //     });
                                                            },
                                                          );
                                                        }),
                                                  );
                                                }),
                                            Expanded(
                                              child: Align(
                                                alignment: AlignmentDirectional(
                                                    0.55, 0),
                                                child: Text(
                                                  'Online',
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(
                                    height: 1,
                                    thickness: 1,
                                    color: Color(0x84848484),
                                  ),
                                  Align(
                                    alignment: AlignmentDirectional(-0.9, 0),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 10, 0, 10),
                                      child: Text(
                                        'Members',
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: ListView(
                                      padding: EdgeInsets.zero,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      children: [
                                        Container(
                                            width: width,
                                            height: height * .35,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.rectangle,
                                            ),
                                            child: Column(
                                              children: [
                                                Container(
                                                  height: height * .2,
                                                  width: width,
                                                  child: ListView.builder(
                                                      itemCount: snapshot
                                                          .data?[1].length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        if (snapshot.hasData) {
                                                          print(snapshot.data);
                                                          return ListTile(
                                                            title: snapshot
                                                                    .hasData
                                                                ? Text(snapshot
                                                                    .data?[1]
                                                                        [index]
                                                                    .get(
                                                                        "name"))
                                                                : Text(
                                                                    "No Data"),
                                                            leading: Icon(
                                                                Icons.person),
                                                            trailing: Container(
                                                                width:
                                                                    width * .2,
                                                                child: Row(
                                                                    children: [
                                                                      Text(
                                                                          "Status: "),
                                                                      Icon(
                                                                        Icons
                                                                            .circle,
                                                                        size:
                                                                            10,
                                                                        color: snapshot.data?[1][index].get("status")
                                                                            ? Colors.green
                                                                            : Colors.red,
                                                                      )
                                                                    ])),
                                                          );
                                                        } else {
                                                          return Container(
                                                              child: Text(
                                                                  "No Data"));
                                                        }
                                                      }),
                                                ),
                                              ],
                                            ))
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    }

                    return Container(child: Text("No Data"));
                  }))),
    );
  }
}
