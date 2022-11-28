// Written by Ronald Gilliard Jr -> https://github.com/rongill23

// import 'package:firebase_core/firebase_core.dart';
import 'package:communication_app/src/data/store.dart';
import 'package:communication_app/src/models/userInfo.dart';
import 'package:communication_app/src/services/firebaseMethods.dart';
import 'package:communication_app/src/settings/settings_view.dart';
import 'package:communication_app/src/views/audioRecorder.dart';
import 'package:communication_app/src/views/audioTest.dart';
import 'package:communication_app/src/views/home.dart';
import 'package:communication_app/src/views/login.dart';
import 'package:communication_app/src/views/messages.dart';
import 'package:communication_app/src/views/profile.dart';
import 'package:communication_app/src/views/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:vxstate/vxstate.dart';

import 'firebase_options.dart';
import 'src/app.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Set up the SettingsController, which will glue user settings to multiple
  // Flutter Widgets.
  final settingsController = SettingsController(SettingsService());

  // Load the user's preferred theme while the splash screen is displayed.
  // This prevents a sudden theme change when the app is first displayed.
  await settingsController.loadSettings();
  await Firebase.initializeApp(
    name: "audiodash",
    options: DefaultFirebaseOptions.currentPlatform,
  );

//  This code listens to changes on the authentication state. If a user is logged out it will show the appropiate login screen.

  FirebaseAuth.instance.authStateChanges().listen((User? user) async {
    if (user == null) {
      runApp(MaterialApp(
          home: LogInPageWidget(),
          routes: {
            LogInPageWidget.routeName: (context) => LogInPageWidget(),
            ProfileView.routeName: (context) => ProfileView(),
            MessagesView.routeName: (context) => MessagesView(),
            SimpleRecorder.routeName: (context) => SimpleRecorder(),
            AudioRecorder.routeName: (context) => AudioRecorder(),
            Register.routeName: (context) => Register()
          },
          onGenerateRoute: (RouteSettings routeSettings) {
            return MaterialPageRoute<void>(
              settings: routeSettings,
              builder: (BuildContext context) {
                switch (routeSettings.name) {
                  case SettingsView.routeName:
                    return SettingsView(controller: settingsController);
                  case Home.routeName:
                    return const Home();
                  case ProfileView.routeName:
                    return const ProfileView();
                  case MessagesView.routeName:
                    return const MessagesView();
                  case SimpleRecorder.routeName:
                    return SimpleRecorder();
                  case AudioRecorder.routeName:
                    return AudioRecorder();
                  case LogInPageWidget.routeName:
                    return LogInPageWidget();
                  default:
                    return const Home();
                }
              },
            );
          }));
    } else {
      FirebaseMethods methods = FirebaseMethods();
      AppUser appUser = await methods.getUser(user.uid);

// The VXState wrapper for the MyApp widget is in a sense a data source for the entirety of the app. It allows the storage of frequently used data throughout the app.

      runApp(VxState(
          store: MyStore(),
          child: MyApp(
            id: user.uid,
            settingsController: settingsController,
            user: appUser,
          )));
    }
  });
}
