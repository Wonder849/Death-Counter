import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

import 'pages/main_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
    titleBarStyle: TitleBarStyle.hidden, // Hide classic title bar
    size: Size(800, 600),
    minimumSize: Size(800, 600),
    maximumSize: Size(800, 600)
  );

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Death Counter',
      theme: ThemeData(fontFamily: 'IBMPlexMono'),
      home: MainPage()
    );
  }
}