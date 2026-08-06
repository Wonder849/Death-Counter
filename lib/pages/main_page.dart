import 'package:death_counter/lists/lists_appearance/lists_body.dart';
import 'package:death_counter/lists/lists_controllers/boss_list_controller.dart';
import 'package:death_counter/modal_windows/add_boss_modal.dart';
import 'package:death_counter/modal_windows/add_game_modal.dart';
import 'package:death_counter/modal_windows/inform_modal.dart';
import 'package:death_counter/models/game_model.dart';
import 'package:death_counter/styles/colors.dart';
import 'package:death_counter/styles/sizes.dart';
import 'package:death_counter/lists/lists_controllers/games_list_controller.dart';
import 'package:death_counter/lists/lists_appearance/lists_headers.dart';
import 'package:death_counter/utils/buttons.dart';
import 'package:death_counter/utils/footer_bar.dart';
import 'package:death_counter/utils/title_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // Manages clicking on game tiles and 
  // updating current displayable boss list
  void onGameSelected(int index) {
    final GamesListController gamesListController = context.read<GamesListController>();
    final BossListController bossListController = context.read<BossListController>();

    gamesListController.SelectGame(index);
    bossListController.LoadBosses(gamesListController.gamesList[index].bosses);
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
      final GamesListController gamesListController = context.read<GamesListController>();
      gamesListController.AddGame(game: newGame);
    }
  }

  void addBoss() async {
    final GamesListController gamesListController = context.read<GamesListController>();
    final BossListController bossListController = context.read<BossListController>();

    final newBoss = await showDialog(
      context: context, 
      builder: (context) {
        if(gamesListController.selectedIndex == -1) {
          return InformModal(message: "",);
        }
        else {
          return AddBossModal(
            gameName: gamesListController.gamesList[gamesListController.selectedIndex].gameName
          );
        }
      } 
    );

    if(newBoss != null) {
      bossListController.AddBoss(boss: newBoss);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Obtain controllers via Provider to make sure
    // that info updates
    final gamesListController = context.watch<GamesListController>();
    final bossListController = context.watch<BossListController>();

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
                          listNotifier: gamesListController,
                          onGameTap: onGameSelected,
                          ),
                      ),
                      MyActionButton(icon: Icon(Icons.add, size: 18, color: MyColors.whiteColor,), text: "Add Game", onPressed: () => addGame()),
                      CustomFooterBarGamesPart(gamesListNotifier: gamesListController, bossListNotifier: bossListController)
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
                      BossListHeader(listNotifier: gamesListController,  onButtonClicked: addBoss),
                      // For list knows its hight limits
                      // other way its not working XD
                      Expanded(child: BossListBody(listNotifier: bossListController)),
                      CustomFooterBarBossPart(gamesListNotifier: gamesListController, bossListNotifier: bossListController)
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