import 'package:death_counter/lists/lists_controllers/boss_list_controller.dart';
import 'package:death_counter/models/boss_model.dart';
import 'package:death_counter/models/game_model.dart';
import 'package:death_counter/tiles/boss_tile.dart';
import 'package:death_counter/tiles/game_tile.dart';
import 'package:death_counter/lists/lists_controllers/games_list_controller.dart';
import 'package:flutter/material.dart';

// Widget for games list that manages games
// and display them on ui
class GamesListBody extends StatelessWidget {

  final GamesListController listNotifier;
  final void Function(int index) onGameTap;

  GamesListBody({super.key, required this.listNotifier, required this.onGameTap});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: listNotifier,
      builder: (context, child) {
        // Rebuild the ListView each time the list changes,
        // so that the framework knows to update the rendering
        final List<GameModel> updatedGamesList = listNotifier.gamesList;

        return ListView.builder(
          itemCount: updatedGamesList.length,
          itemBuilder: (context, index) =>
              GameTile(
                game: updatedGamesList[index],
                isSelected: listNotifier.selectedIndex == index,
                onTap: () => onGameTap(index),
              ),
        );
      },
    );
  }
}

// Works same way that GamesListBody
class BossListBody extends StatelessWidget {
  final BossListController listNotifier;
  
  BossListBody({super.key, required this.listNotifier});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: listNotifier,
      builder: (context, child) {
        // Rebuild the ListView each time the list changes,
        // so that the framework knows to update the rendering
        final List<BossModel> updatedBossList = listNotifier.bossList;

        return ListView.builder(
          itemCount: updatedBossList.length,
          itemBuilder: (context, index) =>
              BossTile(boss: updatedBossList[index]),
        );
      },
    );
  }
}