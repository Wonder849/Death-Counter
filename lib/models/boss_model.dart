import 'package:flutter/material.dart';

// Boss information 
class BossModel {
  ImageProvider bossIcon = AssetImage('Img/dragon.png');
  
  String bossTitle = "Boss";
  String? bossSubTitle;

  int? bossDeaths;

  BossModel({ImageProvider? bossImage, required this.bossTitle, bossSubtitle, int? deaths})
  {
    this.bossIcon = bossImage ?? AssetImage('Img/dragon.png');
    this.bossTitle = bossTitle;
    this.bossSubTitle = bossSubtitle;
    this.bossDeaths = deaths;
  }
}