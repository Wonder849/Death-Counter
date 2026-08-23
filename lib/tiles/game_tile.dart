import 'package:death_counter/modal_windows/game_modal.dart';
import 'package:death_counter/modal_windows/inform_modal.dart';
import 'package:death_counter/models/game_model.dart';
import 'package:death_counter/services/firestore_service.dart';
import 'package:death_counter/styles/colors.dart';
import 'package:death_counter/styles/sizes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
  
  final _firestoreService = FirestoreService();
  String get _uid => FirebaseAuth.instance.currentUser!.uid;

  void editGame() async {
    final newGame = await showDialog(
      context: context,
      builder: (context) {
        return GameModal(game: widget.game);
      },
    );

    if (newGame != null) {
      await _firestoreService.updateGame(
        _uid, 
        widget.game.gameId!,
        widget.game.gameIconPath, 
        widget.game.gameName,
        widget.game.gameDeaths
      );
    }
  }

  void deleteGame() async {
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
      await _firestoreService.deleteGame(_uid, widget.game.gameId!);
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
