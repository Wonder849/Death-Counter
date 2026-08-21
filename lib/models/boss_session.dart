import 'package:cloud_firestore/cloud_firestore.dart';

class BossSession {
  int sessionDeaths;

  Duration sessionDuration;

  BossSession({required this.sessionDeaths, required this.sessionDuration});

  factory BossSession.fromMap(Map<String, dynamic> map) => BossSession(
    sessionDeaths: map['deaths'] ?? 0,
    sessionDuration: Duration(seconds: map['durationSeconds'] ?? 0),
  );

  Map<String, dynamic> toMap() => {
    'deaths' : sessionDeaths,
    'durationSeconds' : sessionDuration.inSeconds
  };
}