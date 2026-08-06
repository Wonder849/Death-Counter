import 'package:death_counter/lists/lists_controllers/boss_list_controller.dart';
import 'package:death_counter/lists/lists_controllers/games_list_controller.dart';
import 'package:death_counter/models/boss_model.dart';
import 'package:death_counter/models/game_model.dart';
import 'package:death_counter/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';
import 'package:provider/provider.dart';

import 'pages/main_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
    titleBarStyle: TitleBarStyle.hidden, // Hide classic title bar
    size: Size(800, 600),
    minimumSize: Size(800, 600),
    maximumSize: Size(1200, 800),
    center: true
  );

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => GamesListController([GameModel(gameName: "asd", bosses: [BossModel(bossTitle: "1",isDefeated: false, deaths: 2), BossModel(bossTitle: "2",isDefeated: false)]),GameModel(gameName: "AAAsd", bosses: [BossModel(bossTitle: "3",isDefeated: false), BossModel(bossTitle: "4",isDefeated: false)])])),
        ChangeNotifierProvider(create: (context) => BossListController([]))
      ],
      child: MyApp(),
    )
  );
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
      )),
      home: MainPage()
    );
  }
}