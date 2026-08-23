import 'package:death_counter/lists/lists_controllers/boss_list_controller.dart';
import 'package:death_counter/lists/lists_controllers/games_list_controller.dart';
import 'package:death_counter/styles/colors.dart';
import 'package:death_counter/styles/sizes.dart';
import 'package:flutter/material.dart';

// Displays all games deaths 
class CustomFooterBarGamesPart extends StatelessWidget {
  final GamesListController gamesListNotifier;
  final BossListController bossListNotifier;

  const CustomFooterBarGamesPart({
    super.key,
    required this.gamesListNotifier,
    required this.bossListNotifier,
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: Listenable.merge([gamesListNotifier, bossListNotifier]),
      builder: (context, child) {
        return SizedBox(
          height: MySizes.footerBarHeight,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                gamesListNotifier.countAllDeaths().toString(),
                style: TextStyle(
                  color: MyColors.yellowColor,
                  fontSize: MySizes.titlesTextSz
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                " Total Deaths",
                style: TextStyle(
                  color: MyColors.whiteColor,
                  fontSize: MySizes.titlesTextSz - 5
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      },
    );
  }
}


// Displays selected game info
class CustomFooterBarBossPart extends StatelessWidget {
  final GamesListController gamesListNotifier;
  final BossListController bossListNotifier;

  const CustomFooterBarBossPart({
    super.key,
    required this.gamesListNotifier,
    required this.bossListNotifier,
  });

  String findMaxDeaths() {
    int maxDeathsIndex = bossListNotifier.FindMaxDeathsIndex();
    if(maxDeathsIndex != -1) {
      int? deaths = bossListNotifier.bossList[maxDeathsIndex].bossDeaths;
      if(deaths != null) {
        return deaths.toString();
      }
    }

    return "0";
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: Listenable.merge([gamesListNotifier, bossListNotifier]),
      builder: (context, child) {
        return SizedBox(
          height: MySizes.footerBarHeight,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(width: MySizes.footerBarBossSpacers,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    bossListNotifier.CountTotalDeaths().toString(),
                    style: TextStyle(
                      color: MyColors.almostYellowColor,
                      fontSize: MySizes.footerBarBossTextSz
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "Total",
                    style: TextStyle(
                      color: MyColors.whiteColor,
                      fontSize: MySizes.footerBarBossTextSz - 5
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    findMaxDeaths(),
                    style: TextStyle(
                      color: MyColors.yellowColor,
                      fontSize: MySizes.footerBarBossTextSz
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "Max",
                    style: TextStyle(
                      color: MyColors.whiteColor,
                      fontSize: MySizes.footerBarBossTextSz - 5
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    bossListNotifier.FindAverageDeaths().toString(),
                    style: TextStyle(
                      color: MyColors.almostYellowColor,
                      fontSize: MySizes.footerBarBossTextSz
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "Average",
                    style: TextStyle(
                      color: MyColors.whiteColor,
                      fontSize: MySizes.footerBarBossTextSz - 5
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              SizedBox(width: MySizes.footerBarBossSpacers,)
            ],
          ),
        );
      },
    );
  }
}