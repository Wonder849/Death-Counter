import 'package:flutter/material.dart';

// Boss information 
class BossModel {
  ImageProvider? bossIcon = AssetImage('Img/skull.png');
  
  String bossTitle = "Boss";
  String? bossSubTitle;

  int? deaths;

  BossModel({ImageProvider? bossImage, required this.bossTitle, bossSubtitle, int? deaths})
  {
    bossIcon = bossImage;
    bossTitle = bossTitle;
    bossSubTitle = bossSubtitle;
    deaths = deaths;
  }
}