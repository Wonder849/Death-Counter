import 'package:death_counter/lists/lists_controllers/games_list_controller.dart';
import 'package:death_counter/modal_windows/add_game_modal.dart';
import 'package:death_counter/modal_windows/inform_modal.dart';
import 'package:death_counter/models/game_model.dart';
import 'package:death_counter/styles/colors.dart';
import 'package:death_counter/styles/sizes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Widget that contains game info
class GameTile extends StatefulWidget {
  final GameModel game;
  final bool isSelected;
  final VoidCallback onTap;

  const GameTile({
    required this.game,
    required this.isSelected,
    required this.onTap,
    super.key,
  });

  @override
  State<GameTile> createState() => _GameTileState();
}

class _GameTileState extends State<GameTile> {

  void editGame() async {
    final gamesListController = context.read<GamesListController>();
    int index = gamesListController.gamesList.indexOf(widget.game);
    final newGame = await showDialog(
      context: context,
      builder: (context) {
        if (index == -1) {
          return InformModal(message: "");
        } else {
          return AddGameModal(game: widget.game);
        }
      },
    );

    if (newGame != null) {
      gamesListController.ChangeGameInfo(
        gameIndex: index,
        gameName: newGame.gameName,
        gameDeaths: newGame.gameDeaths,
        gameIcon: newGame.gameIcon,
      );
    }
  }

  void deleteGame() async {
    final gamesListController = context.read<GamesListController>();
    int index = gamesListController.gamesList.indexOf(widget.game);

    bool? answer = await showDialog(
      context: context,
      builder: (context) {
        return InformModal(
          message: "Are you sure you want to delete this game?",
          title: "Delete",
          isTwoButtons: true,
        );
      },
    );

     if (answer != null && answer == true) {
      gamesListController.DeleteGame(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
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
              onTap: deleteGame,
              child: Row(
                spacing: 5,
                children: [
                  Icon(Icons.delete, color: MyColors.whiteColor),
                  Text("Delete", style: TextStyle(color: MyColors.whiteColor)),
                ],
              ),
            ),
            PopupMenuItem(
              onTap: editGame,
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
      hoverColor: MyColors.greyColor,
      splashColor: Colors.transparent,
      child: Container(
        height: MySizes.tilesHight,
        decoration: BoxDecoration(
          color: widget.isSelected ? MyColors.activeTileBg : Colors.transparent,
          border: Border(
            left: widget.isSelected
                ? BorderSide(width: 2, color: MyColors.yellowColor)
                : BorderSide(color: Colors.transparent),
          ),
        ),
        child: Container(
          padding: EdgeInsets.only(left: 30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image(
                image: widget.game.gameIcon,
                height: MySizes.iconsSz,
                width: MySizes.iconsSz,
                fit: BoxFit.contain,
              ),
              Container(
                padding: EdgeInsets.only(left: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.game.gameName.isNotEmpty? widget.game.gameName : "Uknown",
                      style: TextStyle(
                        color: widget.isSelected
                            ? MyColors.almostYellowColor
                            : MyColors.whiteColor,
                        fontSize: MySizes.tilesTextSz,
                      ),
                    ),
                    Text(
                      widget.game.gameDeaths?.toString() ?? '0',
                      style: TextStyle(
                        color: widget.isSelected
                            ? MyColors.yellowColor
                            : MyColors.whiteColor,
                        fontSize: 10,
                      ),
                    ),
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
