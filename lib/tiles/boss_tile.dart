import 'package:death_counter/modal_windows/boss_modal.dart';
import 'package:death_counter/modal_windows/inform_modal.dart';
import 'package:death_counter/models/boss_model.dart';
import 'package:death_counter/pages/boss_page.dart';
import 'package:death_counter/services/firestore_service.dart';
import 'package:death_counter/utils/buttons.dart';
import 'package:death_counter/styles/colors.dart';
import 'package:death_counter/styles/sizes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// Widget that contains boss info 
// also contains button to interactive page
// for changing boss info
class BossTile extends StatefulWidget {
  
  final BossModel boss;
  final String gameName;
  final String gameId;
  final bool isHeighestDeaths;

  
  const BossTile({
    super.key,
    required this.boss,
    required this.gameId,
    required this.gameName,
    required this.isHeighestDeaths,
  });

  @override
  State<BossTile> createState() => _BossTileState();
}

class _BossTileState extends State<BossTile> {
  final _firestoreService = FirestoreService();
  String get _uid => FirebaseAuth.instance.currentUser!.uid;

   void editBoss() async {
    final newBoss = await showDialog<BossModel>(
      context: context,
      builder: (context) {
        return BossModal(
          boss: widget.boss,
          gameName: widget.gameName
        );
      },
    );

    if (newBoss != null) {
      await _firestoreService.updateBoss(
        _uid,
        widget.gameId,
        widget.boss.bossId!,
        newBoss.bossIconPath,
        newBoss.bossTitle,
        newBoss.bossSubTitle,
        newBoss.bossDeaths,
        newBoss.isDefeated,
      );
    }
  }

  void deleteBoss() async {
    bool? answer = await showDialog(
      context: context,
      builder: (context) {
        return InformModal(
          title: "Delete",
          message: "Are you sure you want to delete this boss?",
          isTwoButtons: true,
        );
      },
    );

     if (answer != null && answer == true) {
      await _firestoreService.deleteBoss(
        _uid,
        widget.gameId, 
        widget.boss.bossId!, 
        widget.boss.bossDeaths ?? 0
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onSecondaryTapDown: (TapDownDetails details) {
        showMenu(
          context: context,
          position: RelativeRect.fromLTRB(
            details.globalPosition.dx,
            details.globalPosition.dy,
            details.globalPosition.dx,
            details.globalPosition.dy,
          ),
          color: MyColors.mainDarkColor,
          menuPadding: EdgeInsets.all(0),
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: MyColors.whiteColor,
              width: MySizes.borderWidth,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 0,
          clipBehavior: Clip.antiAlias,
          items: [
            PopupMenuItem(
              onTap: deleteBoss,
              child: Row(
                spacing: 5,
                children: [
                  Icon(Icons.delete, color: MyColors.whiteColor),
                  Text("Delete", style: TextStyle(color: MyColors.whiteColor)),
                ],
              ),
            ),
            PopupMenuItem(
              onTap: editBoss,
              child: Row(
                spacing: 5,
                children: [
                  Icon(Icons.edit, color: MyColors.whiteColor),
                  Text("Edit", style: TextStyle(color: MyColors.whiteColor)),
                ],
              ),
            ),
          ],
        ).then((value) {});
      },
      onDoubleTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 500),
            pageBuilder: (context, animation, secondaryAnimation) => 
              BossPage(boss: widget.boss, gameId: widget.gameId, gameName: widget.gameName),
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
              image: widget.boss.bossIcon, 
              height: MySizes.iconsSz, 
              width: MySizes.iconsSz, 
              fit: BoxFit.contain
            ),
            Expanded(
              child: Padding(
              padding: EdgeInsets.only(left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, 
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.boss.bossTitle.isNotEmpty? widget.boss.bossTitle : "Uknown",
                    style: TextStyle(
                      color: widget.isHeighestDeaths? MyColors.almostYellowColor : MyColors.whiteColor,
                      fontSize: MySizes.tilesTextSz,
                    ),
                  ),
                  Text(
                    widget.boss.bossSubTitle?.toString() ?? '',
                    style: TextStyle(color: MyColors.whiteColor, fontSize: 10),
                  ),
                ],
              ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 5,
                children: [
                  Text(
                    widget.boss.bossDeaths?.toString() ?? '0',
                    style: TextStyle(
                      color:  widget.isHeighestDeaths? MyColors.yellowColor : MyColors.whiteColor,
                      fontSize: 20
                    ),
                  ),
                  MyIconButton(
                    icon: Icons.chevron_right, 
                    borderRadius: true,
                    onPressed: () => {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          transitionDuration: const Duration(milliseconds: 500),
                          pageBuilder: (context, animation, secondaryAnimation) => 
                            BossPage(boss: widget.boss, gameId: widget.gameId, gameName: widget.gameName),
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
                      )
                    }, 
                    contSize: 30, 
                    iconSize: 20
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}