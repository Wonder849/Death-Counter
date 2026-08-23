import 'package:death_counter/lists/lists_appearance/lists_body.dart';
import 'package:death_counter/modal_windows/boss_modal.dart';
import 'package:death_counter/modal_windows/game_modal.dart';
import 'package:death_counter/modal_windows/inform_modal.dart';
import 'package:death_counter/models/boss_model.dart';
import 'package:death_counter/models/game_model.dart';
import 'package:death_counter/services/firestore_service.dart';
import 'package:death_counter/styles/colors.dart';
import 'package:death_counter/styles/sizes.dart';
import 'package:death_counter/lists/lists_appearance/lists_headers.dart';
import 'package:death_counter/utils/buttons.dart';
import 'package:death_counter/utils/footer_bar.dart';
import 'package:death_counter/utils/title_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  final FirestoreService _firestoreService = FirestoreService();
  String get _uid => FirebaseAuth.instance.currentUser!.uid;

  String? _selectedGameId;

  // For adding games to game list
  // Opens a modal window and waiting for
  // user to type a game info and send
  void addGame() async {
    final newGame = await showDialog<GameModel>(
      context: context, 
      builder: (context) {
        return GameModal();
      },
    );

    if(newGame != null) {
      await _firestoreService.addGame(_uid, newGame);
    }
  }

  void addBoss(GameModel? selectedGame) async {
  if (selectedGame == null) {
    await showDialog(
      context: context,
      builder: (context) => InformModal(
        title: "Add Boss",
        message: "Please select the game for which you want to add a Boss to",
      ),
    );
    return;
  }

  final newBoss = await showDialog<BossModel>(
    context: context,
    builder: (context) => BossModal(gameName: selectedGame.gameName),
  );

  if (newBoss != null) {
    await _firestoreService.addBoss(_uid, selectedGame.gameId!, newBoss);
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.mainDarkColor,
      body: Column(
        children: [
          CustomTitleBar(isEnabled: true,),
          Expanded(
            child: StreamBuilder(
              stream: _firestoreService.gamesStream(_uid),
              builder: (context, gamesSnapshot) {
                final games = gamesSnapshot.data ?? [];
                final findMatchesGame = games.where((game) => game.gameId == _selectedGameId);
                final selectedGame = findMatchesGame.isEmpty? null : findMatchesGame.first;
                return Row(
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
                              games: games,
                              selectedId: _selectedGameId,
                              onGameTap: (game) => setState(() {
                                _selectedGameId = game.gameId;
                              }),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: MyActionButton(icon: Icon(Icons.add, size: 18, color: MyColors.whiteColor,), text: "Add Game", onPressed: () => addGame()),
                          ),
                          CustomFooterBarGamesPart(games: games,)
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
                      child: selectedGame == null
                          ? games.isEmpty 
                            ? Column(
                                children: [
                                  BossListHeader(
                                    selectedGame: null,
                                    bossCount: 0,
                                    onButtonClicked: () => addBoss(null),
                                  ),
                                  const Expanded(
                                    child: Center(child: Text('')),
                                  ),
                                ],
                              ) : Column(
                                children: [
                                  BossListHeader(
                                    selectedGame: null,
                                    bossCount: 0,
                                    onButtonClicked: () => addBoss(null),
                                  ),
                                  const Expanded(
                                    child: Center(child: Text('Select a game')),
                                  ),
                                ],
                              )
                          : StreamBuilder<List<BossModel>>(
                              stream: _firestoreService.bossesStream(
                                _uid,
                                selectedGame.gameId!,
                              ),
                              builder: (context, bossesSnapshot) {
                                final bosses = bossesSnapshot.data ?? [];
                                return Column(
                                  children: [
                                    BossListHeader(
                                      selectedGame: selectedGame,
                                      bossCount: bosses.length,
                                      onButtonClicked: () => addBoss(selectedGame),
                                    ),
                                    Expanded(
                                      child: BossListBody(
                                        gameId: selectedGame.gameId!,
                                        gameName: selectedGame.gameName,
                                        bosses: bosses,
                                      ),
                                    ),
                                    CustomFooterBarBossPart(bosses: bosses),
                                  ],
                                );
                              },
                            ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}