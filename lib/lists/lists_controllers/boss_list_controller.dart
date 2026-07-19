import 'package:flutter/material.dart';
import 'package:death_counter/models/boss_model.dart';

// Controller of boss list 
// works independently of ui
class BossListController with ChangeNotifier {

  // All games list 
  List<BossModel> _bossList = [];

  BossListController(List<BossModel> bossList) {
   _bossList = bossList;
  }

  // getter
  List<BossModel> get bossList => _bossList;

  void AddBoss({required BossModel boss}) {


    bossList.add(boss);

    // Used for redrawing widgets
    notifyListeners();
  }

  void DeleteBoss(int index) {

    bossList.removeAt(index);

    notifyListeners();
  }

  // Method need for swapping current list
  // because of chosen game all list need to be swapped
  void LoadBosses(List<BossModel>? bosses) {
    _bossList = bosses ?? [];

    notifyListeners();
  }

  void ChangeBossInfo({required int bossIndex, ImageProvider? bossIcon, String? bossTitle, String? bossSubTitle, int? bossDeaths}) {

    var boss = bossList?.elementAt(bossIndex);

    boss?.bossIcon = bossIcon ?? boss.bossIcon;

    boss?.bossTitle = bossTitle ?? boss.bossTitle;
    boss?.bossSubTitle = bossSubTitle;

    boss?.bossDeaths = bossDeaths;

    notifyListeners();
  }
}
