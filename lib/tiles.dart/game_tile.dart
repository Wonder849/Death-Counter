import 'package:death_counter/models/game_model.dart';
import 'package:death_counter/styles/colors.dart';
import 'package:death_counter/styles/sizes.dart';
import 'package:flutter/material.dart';

// Widget, contains game info
class GameTile extends StatefulWidget {
  final GameModel game;

  GameTile({required this.game, super.key});

  @override
  State<GameTile> createState() => _GameTileState();
}

class _GameTileState extends State<GameTile> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: isSelected ? MyColors.activeTileBg : Colors.transparent,
        border: Border(
          left: isSelected? BorderSide(width: 2, color: MyColors.yellowColor) : BorderSide(color: Colors.transparent),
          bottom: BorderSide(width: MySizes.borderWidth, color: MyColors.bordersColor),
          right: BorderSide(width: MySizes.borderWidth, color: MyColors.bordersColor)
        )
      ),
      child: Container(
        padding: EdgeInsets.only(left: 30),
        child: Row(
          children: [
            Image(
              image: widget.game.gameIcon, height: MySizes.iconsSz, width: MySizes.iconsSz, fit: BoxFit.contain
            ),
            Container(
              padding: EdgeInsets.only(left: 20),
              child: Column(
                children: [
                  Text(
                    widget.game.gameName,
                    style: TextStyle(
                      color: isSelected? MyColors.almostYellowColor : MyColors.whiteColor,
                      fontSize: 10,
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
