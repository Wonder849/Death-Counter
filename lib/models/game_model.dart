import 'package:death_counter/models/boss_model.dart';
import 'package:flutter/material.dart';

// Game information
class GameModel {
  ImageProvider gameIcon = AssetImage('Img/skull.png');

  String gameName = "Game";

  int? gameDeaths;

  List<BossModel>? bosses;

  GameModel({ImageProvider? gameIcon, required this.gameName,int? gameDeaths,List<BossModel>? bosses}) {
    this.gameIcon = gameIcon ?? AssetImage('Img/skull.png');
    this.gameName = gameName;
    this.gameDeaths = gameDeaths;
    this.bosses = bosses;
  }

  @override
  String toString() {
    return gameName;
  }
}
