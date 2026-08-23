import 'package:death_counter/models/boss_model.dart';
import 'package:death_counter/models/game_model.dart';
import 'package:death_counter/styles/colors.dart';
import 'package:death_counter/styles/sizes.dart';
import 'package:flutter/material.dart';

// Displays all games deaths 
class CustomFooterBarGamesPart extends StatelessWidget {

  final List<GameModel> games;

  const CustomFooterBarGamesPart({
    super.key,
    required this.games,
  });

  int countAllDeaths() {
    int deaths = 0;
    for(int i = 0; i < games.length; ++i) {
      deaths += games[i].gameDeaths?? 0;
    }

    return deaths;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MySizes.footerBarHeight,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            countAllDeaths().toString(),
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
  }
}


// Displays selected game info
class CustomFooterBarBossPart extends StatelessWidget {

  final List<BossModel> bosses;

  const CustomFooterBarBossPart({
    super.key,
    required this.bosses,
  });

  @override
  Widget build(BuildContext context) {
    final total = bosses.fold(0, (sum, boss) => sum + (boss.bossDeaths?? 0) );
    final maxDeaths = bosses.isEmpty? 0 : bosses.map((boss) => boss.bossDeaths ?? 0).reduce((a,b) => a > b ? a : b);
    final average = bosses.isEmpty? 0 : (total / bosses.length).round();
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
                total.toString(),
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
                maxDeaths.toString(),
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
                average.toString(),
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
  }
}