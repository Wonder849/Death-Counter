import 'package:death_counter/lists/lists_appearance/lists_body.dart';
import 'package:death_counter/lists/lists_controllers/boss_list_controller.dart';
import 'package:death_counter/models/boss_model.dart';
import 'package:death_counter/models/game_model.dart';
import 'package:death_counter/styles/colors.dart';
import 'package:death_counter/styles/sizes.dart';
import 'package:death_counter/lists/lists_controllers/games_list_controller.dart';
import 'package:death_counter/lists/lists_appearance/lists_headers.dart';
import 'package:death_counter/utils/title_bar.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  // Creating empty games list
  // that contains all games info
  final GamesListController _gamesListController = GamesListController([]);

  // Same as games list but for bosses
  final BossListController _bossListController = BossListController([]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.mainDarkColor,
      body: Column(
        children: [
          CustomTitleBar(),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      GameListHeader(),
                      // For list knows its hight limits
                      // other way its not working XD
                      Expanded(
                        child: GamesListBody(listNotifier: _gamesListController),
                      )
                    ],
                  ),
                ),
                VerticalDivider(
                  width: MySizes.borderWidth,
                  color: MyColors.bordersColor,
                  thickness: MySizes.borderWidth,
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      BossListHeader(),
                      Expanded(child: BossListBody(listNotifier: _bossListController))
                      //BossTile(boss: BossModel(bossTitle: "Boss", bossSubtitle: "asd"))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}