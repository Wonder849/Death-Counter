import 'package:death_counter/styles/colors.dart';
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
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: MyColors.bordersColor, width: MySizes.borderWidth))),
      child: Text(
        "GAMES",
        style: TextStyle(color: MyColors.whiteColor, fontSize: MySizes.titlesTextSz),
      ),
    );
  }
}

// Header above boses list
class BossListHeader extends StatefulWidget {
  const BossListHeader({super.key});

  @override
  State<BossListHeader> createState() => _BossListHeaderState();
}

class _BossListHeaderState extends State<BossListHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MySizes.headersHeight,
      padding: EdgeInsets.only(left: MySizes.textPad20),
      decoration: BoxDecoration(border: Border(bottom: BorderSide(width: MySizes.borderWidth, color: MyColors.bordersColor))),
      child: Row(
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Header", style: TextStyle(color: MyColors.almostYellowColor, fontSize: MySizes.titlesTextSz)),
                Text("Subheader", style: TextStyle(color: MyColors.whiteColor, fontSize: MySizes.subTitlesTextSz))
              ],
            ),
          )
          //button
        ],
      ),
    );
  }
}