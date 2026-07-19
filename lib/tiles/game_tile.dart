import 'package:death_counter/models/game_model.dart';
import 'package:death_counter/styles/colors.dart';
import 'package:death_counter/styles/sizes.dart';
import 'package:flutter/material.dart';

// Widget that contains game info
class GameTile extends StatelessWidget {
  final GameModel game;
  final bool isSelected;
  final VoidCallback onTap;

  const GameTile({required this.game, required this.isSelected, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      hoverColor: MyColors.hoverButtonTilesColor,
      splashColor: Colors.transparent,
      child: Container(
        height: MySizes.tilesHight,
        decoration: BoxDecoration(
          color: isSelected ? MyColors.activeTileBg : Colors.transparent,
          border: Border(
            left: isSelected ? BorderSide(width: 2, color: MyColors.yellowColor) : BorderSide(color: Colors.transparent),
            bottom: BorderSide(color: MyColors.bordersColor, width: 1),
          ),
        ),
        child: Container(
          padding: EdgeInsets.only(left: 30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image(image: game.gameIcon, height: MySizes.iconsSz, width: MySizes.iconsSz, fit: BoxFit.contain),
              Container(
                padding: EdgeInsets.only(left: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(game.gameName, style: TextStyle(color: isSelected ? MyColors.almostYellowColor : MyColors.whiteColor, fontSize: MySizes.tilesTextSz)),
                    Text(game.gameDeaths?.toString() ?? '0', style: TextStyle(color: isSelected ? MyColors.yellowColor : MyColors.whiteColor, fontSize: 10)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}