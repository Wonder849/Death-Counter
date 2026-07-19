import 'package:death_counter/models/boss_model.dart';
import 'package:death_counter/utils/buttons.dart';
import 'package:death_counter/styles/colors.dart';
import 'package:death_counter/styles/sizes.dart';
import 'package:flutter/material.dart';

// Widget that contains boss info 
// also contains button to interactive page
// for changing boss info
class BossTile extends StatefulWidget {
  
  final BossModel boss;
  
  const BossTile({super.key, required this.boss});

  @override
  State<BossTile> createState() => _BossTileState();
}

class _BossTileState extends State<BossTile> {
  
  bool isSelected = false; // to check if this tile is selected for changing bg
  bool isHighestDeaths = false; // to change deaths color

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MySizes.tilesHight,
      padding: EdgeInsets.only(left: 40),
      decoration: BoxDecoration(
        color: isSelected ? MyColors.activeTileBg : Colors.transparent,
        border: Border(
          bottom: BorderSide(color: MyColors.bordersColor, width: 1)
        )
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(
            image: widget.boss.bossIcon, height: MySizes.iconsSz, width: MySizes.iconsSz, fit: BoxFit.contain
          ),
          Expanded(
            child: Padding(
            padding: EdgeInsets.only(left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, 
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.boss.bossTitle,
                  style: TextStyle(
                    color: isSelected? MyColors.almostYellowColor : MyColors.whiteColor,
                    fontSize: MySizes.tilesTextSz,
                  ),
                ),
                Text(
                  widget.boss.bossSubTitle?.toString() ?? '',
                  style: TextStyle(color: isSelected? MyColors.yellowColor : MyColors.whiteColor, fontSize: 10),
                ),
              ],
            ),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.boss.bossDeaths?.toString() ?? '0',
                style: TextStyle(
                  color: isHighestDeaths? MyColors.yellowColor : MyColors.whiteColor,
                  fontSize: 20
                ),
              ),
              MyIconButton(icon: Icons.chevron_right, onPressed: () => {}, contSize: 30, iconSize: 20)
            ],
          )
        ],
      ),
    );
  }
}