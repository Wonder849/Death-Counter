import 'package:death_counter/models/game_model.dart';
import 'package:flutter/material.dart';
import 'package:death_counter/models/boss_model.dart';

// Controller of games list 
// works independently of ui
class GamesListController {
  List<GameModel>? gamesList;

  GamesListController(List<GameModel>? gamesList) {
    gamesList = gamesList;
  }

  void AddGame({required GameModel game}){
    this.gamesList?.add(game);
  }

  void DeleteGame(){

  }

  void ChangeGameInfo(Image? gameIcon, gameName,int? gameDeaths, List<BossModel>? bosses){

  }
}
