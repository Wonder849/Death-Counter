import 'package:death_counter/lists/lists_appearance/lists_body.dart';
import 'package:death_counter/lists/lists_controllers/boss_list_controller.dart';
import 'package:death_counter/modal_windows/add_boss_modal.dart';
import 'package:death_counter/modal_windows/add_game_modal.dart';
import 'package:death_counter/models/boss_model.dart';
import 'package:death_counter/models/game_model.dart';
import 'package:death_counter/styles/colors.dart';
import 'package:death_counter/styles/sizes.dart';
import 'package:death_counter/lists/lists_controllers/games_list_controller.dart';
import 'package:death_counter/lists/lists_appearance/lists_headers.dart';
import 'package:death_counter/utils/buttons.dart';
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
  final GamesListController _gamesListController = GamesListController([GameModel(gameName: "asd", bosses: [BossModel(bossTitle: "1",isDefeated: false), BossModel(bossTitle: "2",isDefeated: false)]),GameModel(gameName: "AAAsd", bosses: [BossModel(bossTitle: "3",isDefeated: false), BossModel(bossTitle: "4",isDefeated: false)])]);

  // Same as games list but for bosses
  final BossListController _bossListController = BossListController([]);
  
  // Manages clicking on game tiles and 
  // updating current displayable boss list
  void onGameSelected(int index) {
    _gamesListController.SelectGame(index);
    _bossListController.LoadBosses(_gamesListController.gamesList[index].bosses);
  }

  // For adding games to game list
  // Opens a modal window and waiting for
  // user to type a game info and send
  void addGame() async
  {
    final newGame = await showDialog<GameModel>(
      context: context, 
      builder: (context) { return AddGameModal(); }
    );

    if(newGame != null) {
      _gamesListController.AddGame(game: newGame);
    }
  }

  void addBoss() async {
    final newBoss = await showDialog(
      context: context, 
      builder: (context) {
        return AddBossModal(
          gameName: _gamesListController.gamesList[_gamesListController.selectedIndex].gameName
        );
      } 
    );

    if(newBoss != null) {
      _bossListController.AddBoss(boss: newBoss);
    }
  }

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
                        child: GamesListBody(
                          listNotifier: _gamesListController,
                          onGameTap: onGameSelected,
                          ),
                      ),
                      MyActionButton( icon: Icons.add, iconSize: 18, text: "Add Game", onPressed: () => addGame())
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
                      BossListHeader(listNotifier: _gamesListController,  onButtonClicked: addBoss),
                      // For list knows its hight limits
                      // other way its not working XD
                      Expanded(child: BossListBody(listNotifier: _bossListController))
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