import 'package:death_counter/models/game_model.dart';
import 'package:death_counter/styles/colors.dart';
import 'package:death_counter/styles/sizes.dart';
import 'package:death_counter/utils/buttons.dart';
import 'package:flutter/material.dart';

class GameModal extends StatefulWidget {

  final GameModel? game;

  const GameModal({super.key, this.game});

  @override
  State<GameModal> createState() => _GameModalState();
}

class _GameModalState extends State<GameModal> {
  final List<String> _iconsList = [
    'Img/sword_icon.png',
    'Img/demon_skull.png',
    'Img/dragon.png',
    
    'Img/Plus.png',
  ];

  late bool isGameEdit;

  // Controller to get a game title
  late final _controller = isGameEdit? TextEditingController(text: widget.game?.gameName ?? ""): TextEditingController();

  String selectedIcon = 'Img/question_mark.png';
  int? selectedIndex;

  @override
  void initState() {
    super.initState();
    isGameEdit = (widget.game != null);

    if (isGameEdit) {
      final gameIconPath = widget.game!.gameIconPath;

      selectedIndex = _iconsList.indexWhere((icon) => icon == gameIconPath);

      if (selectedIndex != -1) {
        selectedIcon = _iconsList[selectedIndex!];
      } else {
        selectedIndex = null;
        selectedIcon = gameIconPath;
      }
    }
  }

    @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void selectIcon(int index)
  {
    setState(() {
      selectedIndex = index;
      selectedIcon = _iconsList[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: MyColors.greyColor, width: MySizes.borderWidth), 
        borderRadius: BorderRadiusGeometry.circular(10)
      ),
      backgroundColor: MyColors.mainDarkColor,
      content: Container(
        constraints: BoxConstraints(
          minHeight: MediaQuery.sizeOf(context).height * 0.6,
          maxHeight: MediaQuery.sizeOf(context).height * 0.7
        ),
        width: MediaQuery.sizeOf(context).width * 0.6,
        decoration: BoxDecoration(
          borderRadius: BorderRadiusGeometry.circular(10),
        ),
        child: Column(
          children: [
            // Title bar with button X
            Container(
              height: MySizes.titleBarsHeight,
              width: MediaQuery.sizeOf(context).width * 0.6,
              decoration: BoxDecoration(border: Border(bottom: BorderSide(width: MySizes.borderWidth, color: MyColors.greyColor))),
              child: Stack(
                alignment: Alignment.center,
                  children: [
                    Text(isGameEdit? "Edit Game" : "Add Game", style: TextStyle(fontSize: MySizes.modalTextHeadingsSz),),
                    Positioned(
                      right: 0,
                      child: MyIconButton(
                        icon: (Icons.close),
                        onPressed: () => {Navigator.of(context).pop()}
                      ),
                    ),
                  ],
              ),
            ),
            // Rest of content: text fields, icons...
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.only(left: MySizes.modalContPdd, right: MySizes.modalContPdd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: MediaQuery.sizeOf(context).height / 30,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      spacing: MySizes.modalContGap,
                      children: [
                        Text(
                          "Title",
                          style: TextStyle(
                            fontSize: MySizes.modalTextHeadingsSz,
                          ),
                        ),
                        TextField(
                          controller: _controller,
                          cursorColor: MyColors.whiteColor,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor : MyColors.modalTextFieldColor,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(10),
                            )
                          ),
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      spacing: MySizes.modalContGap,
                      children: [
                        Text(
                          "Icon",
                          style: TextStyle(
                            fontSize: MySizes.modalTextHeadingsSz,
                          ),
                        ),
                       Wrap(
                        spacing: MySizes.modalIconsGap, // Horizontal gap
                        runSpacing: MySizes.modalIconsGap, // Vertical gap 
                        children: _iconsList.asMap().entries.map((entry) {
                          // Need to select icon
                          final int index = entry.key;
                          final String iconPath = entry.value;
                          final bool isSelected = selectedIndex == index;

                          return InkWell(
                            onTap: () => selectIcon(index),
                            borderRadius: BorderRadius.circular(MySizes.modalIconsBorderRadius),
                            hoverColor: MyColors.greyColor,
                            splashColor: Colors.transparent,
                            child: Container(
                              width: MySizes.buttonIconContSz,
                              height: MySizes.buttonIconContSz,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(MySizes.modalIconsBorderRadius), 
                                border: BoxBorder.all(color: MyColors.greyColor),
                                color: isSelected? MyColors.modalIconSelected : Colors.transparent
                              ),
                              child: Center(
                                child: Image(
                                  color: MyColors.whiteColor, 
                                  image: AssetImage(iconPath), 
                                  width: MySizes.modalIconsSize, 
                                  height: MySizes.modalIconsSize
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                       )
                      ],
                    )
                  ],
                ),
              )
            ),
            // Action buttons
            Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                  border: Border(top: BorderSide(width: MySizes.borderWidth, color: MyColors.greyColor))
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: MySizes.modalContPdd, right: MySizes.modalContPdd),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    spacing: 10,
                    children: [
                      MyActionButton(text: "Add Game", onPressed: () {
                        // To get a game out of modal window 
                        // right to games list
                        GameModel game = GameModel(gameIconPath: selectedIcon, gameName: _controller.text);
                        Navigator.of(context).pop(game);
                      }),
                      MyActionButton(text: "Cancel", onPressed: () {Navigator.of(context).pop(null);})
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
