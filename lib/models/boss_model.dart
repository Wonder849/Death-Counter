import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:death_counter/models/boss_session.dart';
import 'package:flutter/material.dart';

// Boss information 
class BossModel {
  String? bossId;

  String bossIconPath;
  
  String bossTitle;
  String? bossSubTitle;

  int? bossDeaths;

  bool isDefeated;

  List<BossSession> bossSessions;

  BossModel({
    this.bossId,
    this.bossIconPath = 'Img/question_mark.png',
    this.bossTitle = "Boss",
    this.bossSubTitle,
    this.bossDeaths,
    this.isDefeated = false,
    this.bossSessions = const []
  });

  factory BossModel.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return BossModel(
      bossId: doc.id,
      bossIconPath : data['bossIconPath'] ?? 'Img/dragon.png',
      bossTitle : data['bossTitle'] ?? 'Boss',
      bossSubTitle : data['bossSubTitle'],
      bossDeaths : data['bossDeaths'],
      isDefeated : data['isDefeated'],
      bossSessions : (data['sessions'] as List<dynamic>?)
        ?.map((session) => BossSession.fromMap(session as Map<String, dynamic>)).toList() ?? []
    );
  }

  Map<String, dynamic> toFirestore() => {
    'bossIconPath' : bossIconPath,
    'bossTitle' : bossTitle,
    'bossSubTitle' : bossSubTitle,
    'bossDeaths' : bossDeaths,
    'isDefeated' : isDefeated,
    'sessions': bossSessions.map((session) => session.toMap()).toList(),
  };

  ImageProvider get bossIcon => bossIconPath.startsWith('http') ? NetworkImage(bossIconPath) : AssetImage(bossIconPath);
}