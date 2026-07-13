import 'package:death_counter/models/game_model.dart';
import 'package:death_counter/styles/colors.dart';
import 'package:death_counter/styles/sizes.dart';
import 'package:flutter/material.dart';

// Widget that contains game info
class GameTile extends StatefulWidget {
  final GameModel game;

  const GameTile({required this.game, super.key});

  @override
  State<GameTile> createState() => _GameTileState();
}

class _GameTileState extends State<GameTile> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MySizes.tilesHight,
      decoration: BoxDecoration(
        color: isSelected ? MyColors.activeTileBg : Colors.transparent,
        border: Border(
          left: isSelected? BorderSide(width: 2, color: MyColors.yellowColor) : BorderSide(color: Colors.transparent),
          bottom: BorderSide(color: MyColors.bordersColor, width: 1)
        )
      ),
      child: Container(
        padding: EdgeInsets.only(left: 30),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(
              image: widget.game.gameIcon, height: MySizes.iconsSz, width: MySizes.iconsSz, fit: BoxFit.contain
            ),
            Container(
              padding: EdgeInsets.only(left: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.game.gameName,
                    style: TextStyle(
                      color: isSelected? MyColors.almostYellowColor : MyColors.whiteColor,
                      fontSize: MySizes.tilesTextSz,
                    ),
                  ),
                  Text(
                    widget.game.gameDeaths?.toString() ?? '0',
                    style: TextStyle(color: MyColors.yellowColor, fontSize: 10),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
