import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// Game information
class GameModel {
  String? gameId;

  String gameIconPath;

  String gameName;

  int? gameDeaths;

  GameModel({
    this.gameId,
    this.gameIconPath = 'Img/question_mark.png',
    required this.gameName,
    this.gameDeaths,
  });

  factory GameModel.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return GameModel(
      gameId: doc.id,
      gameIconPath: data['gameIconPath'] ?? 'Img/question_mark.png',
      gameName: data['gameName'] ?? 'Game',
      gameDeaths: data['gameDeaths'] ?? 0,
    );
  }

  Map<String, dynamic> toFirestore() => {
    'gameIconPath' : gameIconPath,
    'gameName' : gameName,
    'gameDeaths' : gameDeaths
  };

  ImageProvider get gameIcon => gameIconPath.startsWith('http') ? NetworkImage(gameIconPath) : AssetImage(gameIconPath);

  @override
  String toString() {
    return gameName;
  }
}
