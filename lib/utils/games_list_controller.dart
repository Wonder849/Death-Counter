import 'package:death_counter/models/game_model.dart';
import 'package:flutter/material.dart';
import 'package:death_counter/models/boss_model.dart';

// Controller of games list 
// works independently of ui
class GamesListController with ChangeNotifier {

  // All games list 
  List<GameModel> _gamesList = [];

  GamesListController(List<GameModel> gamesList) {
   _gamesList = gamesList;
  }

  // getter
  List<GameModel> get gamesList => _gamesList;

  void AddGame({required GameModel game}) {


    gamesList?.add(game);

    // Used for redrawing widgets
    notifyListeners();
  }

  void DeleteGame(int index) {

    gamesList?.removeAt(index);

    notifyListeners();
  }

  void ChangeGameInfo(int gameIndex, ImageProvider? gameIcon, String gameName, int? gameDeaths, List<BossModel>? bosses) {

    var game = gamesList?.elementAt(gameIndex);

    game?.gameName = gameName;
    game?.gameDeaths = gameDeaths;
    game?.bosses = bosses;

    notifyListeners();
  }
}
