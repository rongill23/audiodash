import 'package:communication_app/src/views/audioRecorder.dart';
import 'package:communication_app/src/views/audioTest.dart';
import 'package:communication_app/src/views/login.dart';
import 'package:communication_app/src/views/messages.dart';
import 'package:communication_app/src/views/profile.dart';
import 'package:communication_app/src/views/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'sample_feature/sample_item_details_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'settings/settings_controller.dart';
import 'settings/settings_view.dart';
import 'views/home.dart';

/// The Widget that configures your application.
class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.settingsController,
  });

  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    // Glue the SettingsController to the MaterialApp.
    //
    // The AnimatedBuilder Widget listens to the SettingsController for changes.
    // Whenever the user updates their settings, the MaterialApp is rebuilt.
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          return AnimatedBuilder(
            animation: settingsController,
            builder: (BuildContext context, Widget? child) {
              if (snapshot.data?.uid == null) {
                return MaterialApp(
                  // Providing a restorationScopeId allows the Navigator built by the
                  // MaterialApp to restore the navigation stack when a user leaves and
                  // returns to the app after it has been killed while running in the
                  // background.
                  restorationScopeId: 'app',

                  // Provide the generated AppLocalizations to the MaterialApp. This
                  // allows descendant Widgets to display the correct translations
                  // depending on the user's locale.
                  localizationsDelegates: const [
                    AppLocalizations.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  supportedLocales: const [
                    Locale('en', ''), // English, no country code
                  ],

                  // Use AppLocalizations to configure the correct application title
                  // depending on the user's locale.
                  //
                  // The appTitle is defined in .arb files found in the localization
                  // directory.
                  onGenerateTitle: (BuildContext context) =>
                      AppLocalizations.of(context)!.appTitle,

                  // Define a light and dark color theme. Then, read the user's
                  // preferred ThemeMode (light, dark, or system default) from the
                  // SettingsController to display the correct theme.
                  theme: ThemeData(),
                  darkTheme: ThemeData.dark(),
                  themeMode: settingsController.themeMode,

                  // Define a function to handle named routes in order to support
                  // Flutter web url navigation and deep linking.
                  onGenerateRoute: (RouteSettings routeSettings) {
                    return MaterialPageRoute<void>(
                      settings: routeSettings,
                      builder: (BuildContext context) {
                        // FirebaseAuth.instance.authStateChanges().listen((User? user) {
                        //   if (user == null) {
                        //     switch(routeSettings.name){
                        //       case LogInPageWidget.routeName:
                        //         Navigator.restorablePushNamed(context, LogInPageWidget.routeName);
                        //         break;
                        //     }
                        //   } else {
                        //     switch (routeSettings.name) {
                        //       // case SettingsView.routeName:
                        //       //   Navigator.restorablePushNamed(context, SettingsController.routeName);
                        //       //   break;
                        //       case SampleItemDetailsView.routeName:
                        //         Navigator.restorablePushNamed(context, SampleItemDetailsView.routeName);
                        //         break;
                        //       case Home.routeName:
                        //         Navigator.restorablePushNamed(context, Home.routeName);
                        //         break;
                        //       case ProfileView.routeName:
                        //         Navigator.restorablePushNamed(context, ProfileView.routeName);
                        //         break;
                        //       case MessagesView.routeName:
                        //         Navigator.restorablePushNamed(context, MessagesView.routeName);
                        //         break;
                        //       case SimpleRecorder.routeName:
                        //         Navigator.restorablePushNamed(context, SimpleRecorder.routeName);
                        //         break;
                        //       // case LogInPageWidget.routeName:
                        //       //   Navigator.restorablePushNamed(context, .routeName);
                        //       //   break;
                        //       default:
                        //         Navigator.restorablePushNamed(context, Home.routeName);
                        //     }
                        //   }
                        // });

                        switch (routeSettings.name) {
                          case Register.routeName:
                            return Register();
                          default:
                            return LogInPageWidget();
                        }
                      },
                    );
                  },
                );
              }
              return MaterialApp(
                // Providing a restorationScopeId allows the Navigator built by the
                // MaterialApp to restore the navigation stack when a user leaves and
                // returns to the app after it has been killed while running in the
                // background.
                restorationScopeId: 'app',

                // Provide the generated AppLocalizations to the MaterialApp. This
                // allows descendant Widgets to display the correct translations
                // depending on the user's locale.
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: const [
                  Locale('en', ''), // English, no country code
                ],

                // Use AppLocalizations to configure the correct application title
                // depending on the user's locale.
                //
                // The appTitle is defined in .arb files found in the localization
                // directory.
                onGenerateTitle: (BuildContext context) =>
                    AppLocalizations.of(context)!.appTitle,

                // Define a light and dark color theme. Then, read the user's
                // preferred ThemeMode (light, dark, or system default) from the
                // SettingsController to display the correct theme.
                theme: ThemeData(),
                darkTheme: ThemeData.dark(),
                themeMode: settingsController.themeMode,

                // Define a function to handle named routes in order to support
                // Flutter web url navigation and deep linking.
                onGenerateRoute: (RouteSettings routeSettings) {
                  return MaterialPageRoute<void>(
                    settings: routeSettings,
                    builder: (BuildContext context) {
                      // FirebaseAuth.instance.authStateChanges().listen((User? user) {
                      //   if (user == null) {
                      //     switch(routeSettings.name){
                      //       case LogInPageWidget.routeName:
                      //         Navigator.restorablePushNamed(context, LogInPageWidget.routeName);
                      //         break;
                      //     }
                      //   } else {
                      //     switch (routeSettings.name) {
                      //       // case SettingsView.routeName:
                      //       //   Navigator.restorablePushNamed(context, SettingsController.routeName);
                      //       //   break;
                      //       case SampleItemDetailsView.routeName:
                      //         Navigator.restorablePushNamed(context, SampleItemDetailsView.routeName);
                      //         break;
                      //       case Home.routeName:
                      //         Navigator.restorablePushNamed(context, Home.routeName);
                      //         break;
                      //       case ProfileView.routeName:
                      //         Navigator.restorablePushNamed(context, ProfileView.routeName);
                      //         break;
                      //       case MessagesView.routeName:
                      //         Navigator.restorablePushNamed(context, MessagesView.routeName);
                      //         break;
                      //       case SimpleRecorder.routeName:
                      //         Navigator.restorablePushNamed(context, SimpleRecorder.routeName);
                      //         break;
                      //       // case LogInPageWidget.routeName:
                      //       //   Navigator.restorablePushNamed(context, .routeName);
                      //       //   break;
                      //       default:
                      //         Navigator.restorablePushNamed(context, Home.routeName);
                      //     }
                      //   }
                      // });

                      switch (routeSettings.name) {
                        case SettingsView.routeName:
                          return SettingsView(controller: settingsController);
                        case SampleItemDetailsView.routeName:
                          return const SampleItemDetailsView();
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
                },
              );
            
            },
          );

        });
  }
}
