import 'package:death_counter/lists/lists_controllers/games_list_controller.dart';
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
          color: MyColors.whiteColor,
          fontSize: MySizes.titlesTextSz,
        ),
      ),
    );
  }
}

// Header above boses list
class BossListHeader extends StatelessWidget {
  final GamesListController listNotifier;
  const BossListHeader({super.key, required this.listNotifier});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: listNotifier,
      builder: (context, child) {
         final List<GameModel> updatedGamesList = listNotifier.gamesList;
         final int selectedIndex = listNotifier.selectedIndex;
         final int bossCount;
         if(selectedIndex == -1) {
          bossCount = 0;
         }
         else {
          bossCount = updatedGamesList[selectedIndex].bosses?.length ?? 0;
         }
         
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
                      selectedIndex == -1 ? "Game" : updatedGamesList[selectedIndex].gameName,
                      style: TextStyle(
                        color: MyColors.almostYellowColor,
                        fontSize: MySizes.titlesTextSz,
                      ),
                    ),
                    Text(
                      bossCount.toString() + (bossCount == 1 ? " boss" : " bosses"),
                      style: TextStyle(
                        color: MyColors.whiteColor,
                        fontSize: MySizes.subTitlesTextSz,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(right: 10),
                child: MyActionButton(
                  icon: Icons.add,
                  iconSize: 18,
                  text: "Add Boss",
                  onPressed: () => {},
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
