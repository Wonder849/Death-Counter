import 'package:death_counter/models/boss_model.dart';
import 'package:flutter/material.dart';

// Game information
class GameModel {
  Image? gameIcon = Image(image: AssetImage('Img/skull.png'));

  String gameName = "Game";

  int? gameDeaths;

  List<BossModel>? bosses;

  GameModel({Image? gameIcon, required this.gameName,int? gameDeaths,List<BossModel>? bosses}) {
    gameName = gameName;
    gameDeaths = gameDeaths;
    bosses = bosses;
  }
}
