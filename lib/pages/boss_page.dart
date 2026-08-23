import 'package:death_counter/modal_windows/boss_modal.dart';
import 'package:death_counter/modal_windows/inform_modal.dart';
import 'package:death_counter/models/boss_model.dart';
import 'package:death_counter/services/firestore_service.dart';
import 'package:death_counter/styles/colors.dart';
import 'package:death_counter/styles/sizes.dart';
import 'package:death_counter/utils/buttons.dart';
import 'package:death_counter/utils/title_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// Page for interacting with boss info 
class BossPage extends StatefulWidget {

  final String gameId;
  final String gameName;
  final BossModel boss;

  const BossPage({
    super.key, 
    required this.gameId,
    required this.gameName,
    required this.boss
  });

  @override
  State<BossPage> createState() => _BossPageState();
}

class _BossPageState extends State<BossPage> {
  final FirestoreService _firestoreService = FirestoreService();
  String get _uid => FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _firestoreService
          .bossesCollection(_uid, widget.gameId)
          .doc(widget.boss.bossId)
          .snapshots(),
      builder: (context, bossSnapshot) {
        final currentBoss = (bossSnapshot.hasData && bossSnapshot.data!.exists)? 
          BossModel.fromFirestore(bossSnapshot.data!) : widget.boss;
        return Scaffold(
          backgroundColor: MyColors.mainDarkColor,
          body: Column(
            children: [
              CustomTitleBar(isEnabled: true,),
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
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              spacing: 10,
                              children: [
                                Image(
                                  image: AssetImage(currentBoss.bossIconPath),
                                  height: MySizes.bossPageIconSz,
                                  width: MySizes.bossPageIconSz,
                                  fit: BoxFit.contain,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      currentBoss.bossTitle.isNotEmpty
                                          ? currentBoss.bossTitle
                                          : "Uknown",
                                      style: TextStyle(
                                        color: MyColors.almostYellowColor,
                                        fontSize: MySizes.bossPageTitleTextSz,
                                        height: 1,
                                      ),
                                    ),
                                    if (currentBoss.bossSubTitle?.isNotEmpty ??
                                        false) ...[
                                      Text(
                                        currentBoss.bossSubTitle!,
                                        style: TextStyle(
                                          fontSize:
                                              MySizes.bossPageTitleTextSz - 5,
                                          height: 1,
                                        ),
                                      ),
                                    ] else ...[
                                      const SizedBox.shrink(),
                                    ],
                                  ],
                                ),
                              ],
                            ),
                          ),
                          MyActionButton(
                            width: MySizes.buttonActionWidth - 5,
                            text: "Edit",
                            onPressed: () async {
                              final newBoss = await showDialog<BossModel>(
                                context: context,
                                builder: (context) {
                                  return BossModal(boss: currentBoss, gameName: widget.gameName);
                                },
                              );

                              if (newBoss != null) {
                                await _firestoreService.updateBoss(
                                  _uid,
                                  widget.gameId, 
                                  currentBoss.bossId!, 
                                  newBoss.bossIconPath, 
                                  newBoss.bossTitle, 
                                  newBoss.bossSubTitle, 
                                  newBoss.bossDeaths, 
                                  newBoss.isDefeated
                                );
                              }
                            },
                          ),
                        ],
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 50),
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: MyColors.yellowColor,
                                      width: 2,
                                    ),
                                  ),
                                ),
                                width: MySizes.bossPageDeathsWidth,
                                child: Text(
                                  (currentBoss.bossDeaths != null)
                                      ? currentBoss.bossDeaths.toString()
                                      : "0",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: MySizes.bossPageDeathsTextSz,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: MySizes.bossPageContentPdd * 2,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  spacing: 30,
                                  children: [
                                    MyActionButton(
                                      width: MySizes.bossPageAddBtnSz / 1.6,
                                      height: MySizes.bossPageAddBtnSz / 1.6,
                                      icon: Icon(
                                        Icons.remove,
                                        size: MySizes.bossPageIconSz,
                                        color: MyColors.whiteColor,
                                      ),
                                      onPressed: () async {
                                        if(currentBoss.bossDeaths != null && (currentBoss.bossDeaths! - 1) < 0) {
                                          await showDialog(
                                            context: context, 
                                            builder: (context) => InformModal(
                                              title: "Error",
                                              message: "Deaths can't be negative",
                                            ),
                                          );
                                          return;
                                        }
                                        await _firestoreService.adjustBossDeaths(
                                          _uid, 
                                          widget.gameId,
                                          currentBoss.bossId!, 
                                          -1
                                        );
                                      },
                                    ),
                                    MyActionButton(
                                      width: MySizes.bossPageAddBtnSz,
                                      height: MySizes.bossPageAddBtnSz,
                                      icon: Icon(
                                        Icons.add,
                                        size: MySizes.bossPageIconSz,
                                        color: MyColors.whiteColor,
                                      ),
                                      onPressed: () async {
                                        await _firestoreService.adjustBossDeaths(
                                          _uid, 
                                          widget.gameId,
                                          currentBoss.bossId!, 
                                          1
                                        );
                                      },
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
                                        bool? answer = await showDialog(
                                          context: context,
                                          builder: (context) {
                                            return InformModal(
                                              message:
                                                  "Are you sure you want to reset deaths?",
                                              title: "Edit",
                                              isTwoButtons: true,
                                            );
                                          },
                                        );

                                        if (answer != null && answer == true) {
                                          await _firestoreService.adjustBossDeaths(
                                            _uid, 
                                            widget.gameId,
                                            currentBoss.bossId!, 
                                            - (currentBoss.bossDeaths ?? 0)
                                          );
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: MySizes.bossPageContentPdd * 2,
                                ),
                                child: MyActionButton(
                                  onPressed: () async {
                                    await _firestoreService.updateBossDefeated(
                                      _uid,
                                      widget.gameId,
                                      currentBoss.bossId!,
                                      !currentBoss.isDefeated,
                                    );
                                  },
                                  icon: Image.asset(
                                    "Img/defeated_boss.png",
                                    color: currentBoss.isDefeated
                                        ? MyColors.yellowColor
                                        : MyColors.greyColor,
                                    width: MySizes.bossPageIconSz / 2,
                                    height: MySizes.bossPageIconSz / 2,
                                  ),
                                  text: "Mark As ${currentBoss.isDefeated ? "Undefeated" : "Defeated"}",
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
      },
    );
  }
}
