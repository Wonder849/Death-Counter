import 'package:death_counter/firebase_options.dart';
import 'package:death_counter/styles/colors.dart';
import 'package:death_counter/utils/auth_gate.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
    titleBarStyle: TitleBarStyle.hidden, // Hide classic title bar
    size: Size(900, 750),
    minimumSize: Size(900, 750),
    maximumSize: Size(1360, 1280),
    center: true
  );

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );

  // Pass all uncaught errors to Crashlytics
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Death Counter',
      theme: ThemeData(textTheme: ThemeData.dark().textTheme.apply(
        bodyColor: MyColors.whiteColor,
        fontFamily: 'IBMPlexMono'
      ),
      hoverColor: MyColors.greyColor,
      splashColor: Colors.transparent,
    ),
      home: AuthGate()
    );
  }
}