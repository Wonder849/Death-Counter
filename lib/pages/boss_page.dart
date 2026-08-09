import 'package:death_counter/lists/lists_controllers/boss_list_controller.dart';
import 'package:death_counter/lists/lists_controllers/games_list_controller.dart';
import 'package:death_counter/modal_windows/add_boss_modal.dart';
import 'package:death_counter/modal_windows/inform_modal.dart';
import 'package:death_counter/models/boss_model.dart';
import 'package:death_counter/styles/colors.dart';
import 'package:death_counter/styles/sizes.dart';
import 'package:death_counter/utils/buttons.dart';
import 'package:death_counter/utils/title_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Page for interacting with boss info 
class BossPage extends StatefulWidget {

  final BossModel boss;

  const BossPage({super.key, required this.boss});

  @override
  State<BossPage> createState() => _BossPageState();
}

class _BossPageState extends State<BossPage> {

  late bool isDefeated = widget.boss.isDefeated;
  @override
  Widget build(BuildContext context) {
    final gamesListController = context.watch<GamesListController>();
    final bossListController = context.watch<BossListController>();

    int bossIndex = bossListController.bossList.indexOf(widget.boss);
    // Fallback to widget.boss if index not found (-1)
    final currentBoss = bossIndex != -1 ? bossListController.bossList[bossIndex] : widget.boss;
    
    return Scaffold(
      backgroundColor: MyColors.mainDarkColor,
      body: Column(
        children: [
          CustomTitleBar(),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(MySizes.bossPageContentPdd),
              child: Column(
                children: [
                  Row(
                    children: [
                      MyIconButton(
                        icon: Icons.chevron_left_rounded, 
                        iconSize: 40, 
                        borderRadius: true, 
                        onPressed: () {Navigator.of(context).pop();}
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: 10,
                          children: [
                            Image(
                              image: currentBoss.bossIcon, height: MySizes.bossPageIconSz, width: MySizes.bossPageIconSz, fit: BoxFit.contain
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  currentBoss.bossTitle.isNotEmpty? currentBoss.bossTitle : "Uknown",
                                  style: TextStyle(
                                    color: MyColors.almostYellowColor,
                                    fontSize: MySizes.bossPageTitleTextSz,
                                    height: 1
                                  ),
                                ),
                                if(currentBoss.bossSubTitle?.isNotEmpty ?? false) ...[
                                  Text(
                                    currentBoss.bossSubTitle!,
                                    style: TextStyle(
                                      fontSize: MySizes.bossPageTitleTextSz - 5,
                                      height: 1
                                    ),
                                  )
                                ]
                                else  
                                ...[
                                  const SizedBox.shrink()
                                ]
                              ],
                            )
                          ],
                        ),
                      ),
                      MyActionButton(width: MySizes.buttonActionWidth - 5, text: "Edit", onPressed: () async {
                        final newBoss = await showDialog(
                          context: context, 
                          builder: (context) {
                            if(gamesListController.selectedIndex == -1) {
                              return InformModal(message: "",);
                            }
                            else {
                              return AddBossModal(
                                gameName: gamesListController.selectedIndex != -1
                                ? gamesListController.gamesList[gamesListController.selectedIndex].gameName
                                : "",
                                boss: currentBoss,
                              );
                            }
                          } 
                        );
            
                      if(newBoss != null) {
                        bossListController.ChangeBossInfo(
                          bossIndex: bossListController.bossList.indexOf(currentBoss),
                          bossTitle: newBoss.bossTitle,
                          bossSubTitle: newBoss.bossSubTitle,
                          bossDeaths: newBoss.bossDeaths,
                          bossIcon: newBoss.bossIcon,
                          isDefeated: newBoss.isDefeated,                      
                        );

                        if(newBoss.isDefeated != isDefeated) {
                          isDefeated = newBoss.isDefeated;
                        }
                      }
                      })
                    ],
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border(bottom: BorderSide(
                                color: MyColors.yellowColor,
                                width: 2
                              ))
                            ),
                            width: MySizes.bossPageDeathsWidth,
                            child: Text(
                              (currentBoss.bossDeaths != null)? currentBoss.bossDeaths.toString() : "0",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: MySizes.bossPageDeathsTextSz,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: MySizes.bossPageContentPdd * 2),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              spacing: 30,
                              children: [
                                MyActionButton(
                                  width: MySizes.bossPageAddBtnSz / 1.6, 
                                  height: MySizes.bossPageAddBtnSz / 1.6 , 
                                  icon: Icon(
                                    Icons.remove,
                                    size: MySizes.bossPageIconSz,
                                    color: MyColors.whiteColor,
                                  ), 
                                  onPressed: (){
                                    bossListController.ChangeBossInfo(
                                      bossIndex: bossListController.bossList.indexOf(currentBoss),
                                      bossDeaths: ((currentBoss.bossDeaths ?? 0) - 1)                      
                                    );
                                  }
                                ),
                                MyActionButton(
                                  width: MySizes.bossPageAddBtnSz, 
                                  height: MySizes.bossPageAddBtnSz , 
                                  icon: Icon(
                                    Icons.add,
                                    size: MySizes.bossPageIconSz,
                                    color: MyColors.whiteColor,
                                  ), 
                                  onPressed: (){
                                    bossListController.ChangeBossInfo(
                                      bossIndex: bossListController.bossList.indexOf(currentBoss),
                                      bossDeaths: ((currentBoss.bossDeaths ?? 0) + 1)                      
                                    );
                                  }
                                ),
                                MyActionButton(
                                  width: MySizes.bossPageAddBtnSz / 1.8, 
                                  height: MySizes.bossPageAddBtnSz / 1.8, 
                                  icon: Icon(
                                    Icons.autorenew,
                                    size: MySizes.bossPageIconSz,
                                    color: MyColors.whiteColor,
                                  ), 
                                  onPressed: () async {
                                    bool? answer =  await showDialog(
                                      context: context, 
                                      builder: (context) { return InformModal(
                                        message: "Are you sure you want to reset deaths?",
                                        title: "Edit",
                                        isTwoButtons: true,
                                      );} 
                                    );

                                    if(answer != null && answer == true) {
                                      bossListController.ChangeBossInfo(
                                        bossIndex: bossListController.bossList.indexOf(currentBoss),
                                        bossDeaths: 0
                                      );
                                    }
                                  }
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: MySizes.bossPageContentPdd * 2),
                            child: MyActionButton(
                              onPressed: (){
                                setState(() {
                                  isDefeated = !isDefeated;
                                });
                                bossListController.ChangeBossInfo(
                                  bossIndex: bossListController.bossList.indexOf(currentBoss), 
                                  isDefeated: isDefeated
                                );
                              },
                              icon: Image.asset(
                                "Img/defeated_boss.png", 
                                color: isDefeated? MyColors.yellowColor : MyColors.greyColor,
                                width: MySizes.bossPageIconSz / 2,
                                height: MySizes.bossPageIconSz / 2,
                              ),
                              text: "Mark As " + (isDefeated? "Undefeated" : "Defeated"),
                              width: 250,
                              height: 40,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}