import 'package:flutter/material.dart';

// Boss information 
class BossModel {
  Image? bossIcon = Image(image: AssetImage('Img/skull.png'));
  
  String bossTitle = "Boss";
  String? bossSubTitle;

  int? deaths;

  BossModel({Image? bossImage, required this.bossTitle, bossSubtitle, int? deaths})
  {
    bossIcon = bossImage;
    bossTitle = bossTitle;
    bossSubTitle = bossSubtitle;
    deaths = deaths;
  }
}