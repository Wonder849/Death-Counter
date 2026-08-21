import 'package:death_counter/models/game_model.dart';
import 'package:death_counter/styles/colors.dart';
import 'package:death_counter/utils/buttons.dart';
import 'package:flutter/material.dart';
import 'package:death_counter/styles/sizes.dart';

// Header above the games list
class GameListHeader extends StatelessWidget {
  const GameListHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MySizes.headersHeight,
      alignment: AlignmentGeometry.centerStart,
      padding: EdgeInsets.only(left: MySizes.textPad20),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: MyColors.bordersColor,
            width: MySizes.borderWidth,
          ),
        ),
      ),
      child: Text(
        "GAMES",
        style: TextStyle(
          fontSize: MySizes.titlesTextSz,
        ),
      ),
    );
  }
}

// Header above boses list
class BossListHeader extends StatelessWidget {

  final GameModel? selectedGame;
  final int bossCount;
  final VoidCallback onButtonClicked;

  const BossListHeader({
    super.key,
    required this.selectedGame,
    required this.bossCount,
    required this.onButtonClicked,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MySizes.headersHeight,
      padding: EdgeInsets.only(left: MySizes.textPad20),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: MySizes.borderWidth,
            color: MyColors.bordersColor,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  (selectedGame == null) ? "Game" : (selectedGame!.gameName.isNotEmpty? 
                  selectedGame!.gameName : "Uknown"),
                  style: TextStyle(
                    color: MyColors.almostYellowColor,
                    fontSize: MySizes.titlesTextSz,
                  ),
                ),
                Text(
                  bossCount.toString() + (bossCount == 1 ? " boss" : " bosses"),
                  style: TextStyle(fontSize: MySizes.subTitlesTextSz),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(right: 10),
            child: MyActionButton(
              icon: Icon(Icons.add, size: 18, color: MyColors.whiteColor),
              text: "Add Boss",
              onPressed: onButtonClicked,
            ),
          ),
        ],
      ),
    );
  }
}
