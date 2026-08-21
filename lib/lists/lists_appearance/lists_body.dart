import 'package:death_counter/models/boss_model.dart';
import 'package:death_counter/models/game_model.dart';
import 'package:death_counter/tiles/boss_tile.dart';
import 'package:death_counter/tiles/game_tile.dart';
import 'package:flutter/material.dart';

// Widget for games list that manages games
// and display them on ui
class GamesListBody extends StatelessWidget {

  final List<GameModel> games;
  final String? selectedId;
  final void Function(GameModel game) onGameTap;

  const GamesListBody({super.key, required this.games, required this.selectedId, required this.onGameTap});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: games.length,
      itemBuilder: (context, index) {
        final game = games[index];
        return GameTile(
          game: game, 
          isSelected: selectedId == game.gameId, 
          onTap: () => onGameTap(game)
        );
      },
    );
  }
}

// Works same way that GamesListBody
class BossListBody extends StatelessWidget {

  final String gameId;
  final String gameName;

  final List<BossModel> bosses; 
  
  const BossListBody({
    super.key,
    required this.gameId,
    required this.gameName,
    required this.bosses
  });

  @override
  Widget build(BuildContext context) {
    final int maxDeaths = bosses.isEmpty? 0 
      : bosses.map((boss) => boss.bossDeaths ?? 0).reduce((a, b) => (a > b)? a :  b);
    return ListView.builder(
      itemCount: bosses.length,
      itemBuilder: (context, index) {
        final boss = bosses[index];
        return BossTile(
          boss: boss, 
          gameId: gameId, 
          gameName: gameName, 
          isHeighestDeaths: maxDeaths > 0 && (boss.bossDeaths ?? 0) == maxDeaths  
        );
      },
    );
  }
}