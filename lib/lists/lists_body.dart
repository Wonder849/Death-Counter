import 'package:death_counter/models/game_model.dart';
import 'package:death_counter/tiles.dart/game_tile.dart';
import 'package:death_counter/utils/games_list_controller.dart';
import 'package:flutter/material.dart';

// Widget for games list that manages games
// and display them on ui
class GamesListBody extends StatelessWidget {
  final GamesListController listNotifier;

  GamesListBody({super.key, required this.listNotifier});

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
              GameTile(game: updatedGamesList[index]),
        );
      },
    );
  }
}

// Works same way that GamesListBody
class BossListBody extends StatelessWidget {
  final GamesListController listNotifier;
  
  BossListBody({super.key, required this.listNotifier});

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
              GameTile(game: updatedGamesList[index]),
        );
      },
    );
  }
}