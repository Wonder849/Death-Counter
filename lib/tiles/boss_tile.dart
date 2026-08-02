import 'package:death_counter/models/boss_model.dart';
import 'package:death_counter/pages/boss_page.dart';
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
    return InkWell(
      onDoubleTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 500),
            pageBuilder: (context, animation, secondaryAnimation) => 
              BossPage(boss: widget.boss),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                final tween = Tween<Offset>(
                  begin: const Offset(1.0, 0.0), 
                  end: Offset.zero,  
                ).chain(CurveTween(curve: Curves.easeOutCubic));

                return SlideTransition(
                  position: animation.drive(tween),
                  child: child,
                );
              },
          ),
        );
      },
      hoverColor: MyColors.greyColor,
      splashColor: Colors.transparent,
      child: Container(
        height: MySizes.tilesHight,
        padding: EdgeInsets.only( left:widget.boss.isDefeated? 10 : 40 ),
        decoration: BoxDecoration(
          color: isSelected ? MyColors.activeTileBg : Colors.transparent,
          border: Border(
          )
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if(widget.boss.isDefeated) ...[
              Image(
                image: AssetImage('Img/defeated_boss.png'),
                height: MySizes.iconsSz - 15, 
                width: MySizes.iconsSz, 
                fit: BoxFit.contain,
                color: MyColors.defeatedBossColor, 
              )
            ],
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
      ),
    );
  }
}