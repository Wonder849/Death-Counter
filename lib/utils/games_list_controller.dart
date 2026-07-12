import 'package:death_counter/models/game_model.dart';
import 'package:flutter/material.dart';
import 'package:death_counter/models/boss_model.dart';

// Controller of games list 
// works independently of ui
class GamesListController {
  static List<GameModel>? gamesList;

  GamesListController(List<GameModel>? gamesList) {
    gamesList = gamesList;
  }

  void AddGame({required GameModel game}) {
    GamesListController.gamesList?.add(game);

    print("${game.gameName} game was added.");
  }

  void DeleteGame(int index) {
    GamesListController.gamesList?.removeAt(index);
    
    print("${GamesListController.gamesList?.elementAt(index).gameName} game was deleted.");
  }

  void ChangeGameInfo(int gameIndex, ImageProvider? gameIcon, gameName,int? gameDeaths, List<BossModel>? bosses) {
    var game = GamesListController.gamesList?.elementAt(gameIndex);

    game?.gameName = gameName;
    game?.gameDeaths = gameDeaths;
    game?.bosses = bosses;

    print("${game?.gameName} game info was changed.");
  }
}
