import 'package:flutter/material.dart';

// Boss information 
class BossModel {
  ImageProvider bossIcon = AssetImage('Img/dragon.png');
  
  String bossTitle = "Boss";
  String? bossSubTitle;

  int? bossDeaths;

  bool isDefeated = false;

  BossModel({ImageProvider? bossImage, required bossTitle, String? bossSubtitle, int? deaths, required isDefeated})
  {
    this.bossIcon = bossImage ?? AssetImage('Img/dragon.png');
    this.bossTitle = bossTitle;
    this.bossSubTitle = bossSubtitle;
    this.bossDeaths = deaths;
    this.isDefeated = isDefeated;
  }
}