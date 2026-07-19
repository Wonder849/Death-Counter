import 'package:death_counter/models/game_model.dart';
import 'package:flutter/material.dart';
import 'package:death_counter/models/boss_model.dart';

// Controller of games list 
// works independently of ui
class GamesListController with ChangeNotifier {

  // All games list 
  List<GameModel> _gamesList = [];
  int _selectedIndex = -1;

  GamesListController(List<GameModel> gamesList) {
   _gamesList = gamesList;
  }

  // getters
  List<GameModel> get gamesList => _gamesList;
  int get selectedIndex => _selectedIndex;

  // Need for select a game for displaying correct 
  // bosses list tiles
  void SelectGame(int index) {

    _selectedIndex = index;

    notifyListeners();
  }

  void AddGame({required GameModel game}) {


    gamesList.add(game);

    // Used for redrawing widgets
    notifyListeners();
  }

  void DeleteGame(int index) {

    gamesList.removeAt(index);

    notifyListeners();
  }

  void ChangeGameInfo(int gameIndex, ImageProvider? gameIcon, String gameName, int? gameDeaths, List<BossModel>? bosses) {

    var game = gamesList?.elementAt(gameIndex);

    game?.gameIcon = gameIcon ?? game.gameIcon;
    game?.gameName = gameName;
    game?.gameDeaths = gameDeaths;
    game?.bosses = bosses;

    notifyListeners();
  }
}
