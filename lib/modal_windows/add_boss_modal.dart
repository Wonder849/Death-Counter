import 'package:death_counter/models/boss_model.dart';
import 'package:death_counter/styles/colors.dart';
import 'package:death_counter/styles/sizes.dart';
import 'package:death_counter/utils/buttons.dart';
import 'package:flutter/material.dart';

class AddBossModal extends StatefulWidget {

  // Need to display name of game in 
  // title of modal window
  final String gameName;

  const AddBossModal({super.key, required this.gameName});

  @override
  State<AddBossModal> createState() => _AddBossModalState();
}

class _AddBossModalState extends State<AddBossModal> {

    final List<ImageProvider> _iconsList = [
    AssetImage('Img/sword_icon.png'),
    AssetImage('Img/demon_skull.png'),
    AssetImage('Img/dragon.png'),
    
    AssetImage('Img/Plus.png')
  ];

  // Controller to get boss name
  final _titleController = TextEditingController();

  // Controller to get boss subtitle
  final _subTitleController = TextEditingController();

  int? selectedIndex;
  ImageProvider selectedIcon = AssetImage('Img/question_mark.png');

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
          maxHeight: MediaQuery.sizeOf(context).height * 0.8
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
                    Text("Add Boss" + " • " + widget.gameName, style: TextStyle(fontSize: MySizes.modalTextHeadingsSz),),
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
              flex: 5,
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
                          controller: _titleController,
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
                          "Subtitle",
                          style: TextStyle(
                            fontSize: MySizes.modalTextHeadingsSz,
                          ),
                        ),
                        TextField(
                          controller: _subTitleController,
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
                          final ImageProvider iconAsset = entry.value;
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
                                  image: iconAsset, 
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
                      MyActionButton(text: "Add Boss", onPressed: () {
                        // To get a boss out of modal window 
                        // right to boss list
                        BossModel boss = BossModel(bossTitle: _titleController.text, bossSubtitle: _subTitleController.text, bossImage: selectedIcon);
                        Navigator.of(context).pop(boss);
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