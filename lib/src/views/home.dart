import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:communication_app/src/data/store.dart';
import 'package:communication_app/src/services/firebaseAuth.dart';
import 'package:communication_app/src/services/firebaseMethods.dart';
import 'package:communication_app/src/widgets/createGroup.dart';
import 'package:communication_app/src/widgets/drawer.dart';
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
  Widget build(BuildContext context) {
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
        ),
      ),
      body: SafeArea(
        child: GestureDetector(
          child: FutureBuilder<
                  List<QueryDocumentSnapshot<Map<String, dynamic>>>>(
              future: methods.getOtherUsers(),
              builder: (context,
                  AsyncSnapshot<
                          List<QueryDocumentSnapshot<Map<String, dynamic>>>>
                      snapshot) {
                final width = MediaQuery.of(context).size.width;
                final height = MediaQuery.of(context).size.height;

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
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
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
                                  'UserName',
                                ),
                              ),
                            ),
                            Expanded(
                              child: Align(
                                alignment: AlignmentDirectional(1, 0),
                                child: ElevatedButton(
                                  onPressed: () async {
                                    Authentication auth = Authentication();
                                    auth.signOut();
                                    setState(() {});
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
                              Row(mainAxisSize: MainAxisSize.max, children: [
                                Align(
                                  alignment: AlignmentDirectional(0, 0),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16, 0, 0, 0),
                                    child: Text(
                                      'My Groups',
                                    ),
                                  ),
                                ),
                                Align(
                                    alignment: AlignmentDirectional(0, 0),
                                    child: IconButton(
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
                                            builder: (BuildContext context) {
                                              return Container(
                                                width: MediaQuery.of(context).size.width,
                                                child: CreateGroupWidget(
                                                    users: snapshot),
                                              );
                                            },
                                          );
                                        }))
                              ]),
                              Expanded(
                                child: ListView(
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  children: [
                                    Container(
                                      width: 100,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                      ),
                                      child: InkWell(
                                        onTap: () async {
                                          // context.pushNamed('RecordingPage2');
                                        },
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(10, 0, 0, 0),
                                              child: Container(
                                                width: 40,
                                                height: 40,
                                                clipBehavior: Clip.antiAlias,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Align(
                                                alignment: AlignmentDirectional(
                                                    -0.85, 0),
                                                child: Text(
                                                  'User 1',
                                                ),
                                              ),
                                            ),
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
                                    ),
                                  ],
                                ),
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
                                        height: height * .15,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                        ),
                                        child: ListView.builder(
                                            itemCount: snapshot.data?.length,
                                            itemBuilder: (context, index) {
                                              return ListTile(
                                                title: Text(snapshot
                                                    .data?[index]
                                                    .get("name")),
                                                leading: Icon(Icons.person),
                                                trailing: Container(
                                                    width: width * .2,
                                                    child: Row(children: [
                                                      Text("Status: "),
                                                      Icon(
                                                        Icons.circle,
                                                        size: 10,
                                                        color: snapshot
                                                                .data?[index]
                                                                .get("status")
                                                            ? Colors.green
                                                            : Colors.red,
                                                      )
                                                    ])),
                                              );
                                            })
                                        // child: InkWell(
                                        //   onTap: () async {
                                        //     // context.pushNamed('RecordingPage2');
                                        //   },
                                        //   child: Row(
                                        //     mainAxisSize: MainAxisSize.max,
                                        //     children: [
                                        //       Padding(
                                        //         padding: EdgeInsetsDirectional.fromSTEB(
                                        //             10, 0, 0, 0),
                                        //         child: Container(
                                        //           width: 40,
                                        //           height: 40,
                                        //           clipBehavior: Clip.antiAlias,
                                        //           decoration: BoxDecoration(
                                        //             shape: BoxShape.circle,
                                        //           ),
                                        //           child: Image.network(
                                        //             'https://picsum.photos/seed/783/600',
                                        //             fit: BoxFit.contain,
                                        //           ),
                                        //         ),
                                        //       ),
                                        //       Expanded(
                                        //         child: Align(
                                        //           alignment:
                                        //               AlignmentDirectional(-0.85, 0),
                                        //           child: Text(
                                        //             'User 1',
                                        //           ),
                                        //         ),
                                        //       ),
                                        //       Expanded(
                                        //         child: Align(
                                        //           alignment:
                                        //               AlignmentDirectional(0.55, 0),
                                        //           child: Text(
                                        //             'Online',
                                        //           ),
                                        //         ),
                                        //       ),
                                        //     ],
                                        //   ),
                                        // ),

                                        ),
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
                return Center(
                  child: CircularProgressIndicator(),
                );
              }),
        ),
      ),
    );
  }
}
