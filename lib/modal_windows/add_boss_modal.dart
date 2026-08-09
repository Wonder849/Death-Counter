import 'package:death_counter/models/boss_model.dart';
import 'package:death_counter/styles/colors.dart';
import 'package:death_counter/styles/sizes.dart';
import 'package:death_counter/utils/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddBossModal extends StatefulWidget {

  // Need to display name of game in 
  // title of modal window
  final String gameName;

  final BossModel? boss;

  const AddBossModal({super.key, required this.gameName, this.boss});

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

  late bool isBossEdit;
  
  late final _titleController = isBossEdit? TextEditingController(text: widget.boss?.bossTitle ?? ""): TextEditingController();
  late final _subTitleController = isBossEdit? TextEditingController(text: widget.boss?.bossSubTitle ?? ""): TextEditingController();
  late final _deathsController = isBossEdit? TextEditingController(text: (widget.boss?.bossDeaths != null)? (widget.boss?.bossDeaths.toString()) : ""): TextEditingController();

  late bool _isChecked = isBossEdit? widget.boss?.isDefeated ?? false : false; 

  ImageProvider selectedIcon = AssetImage("Img/question_mark.png");
  int? selectedIndex;

  // Need to select icon that was selected previously
  // for editing boss
  @override
  void initState() {
    super.initState();
    isBossEdit = (widget.boss != null);

    if (isBossEdit && widget.boss?.bossIcon != null) {
      final bossIcon = widget.boss!.bossIcon;

      selectedIndex = _iconsList.indexWhere((icon) => icon == bossIcon);

      if (selectedIndex != -1) {
        selectedIcon = _iconsList[selectedIndex!];
      } else {
        selectedIndex = null;
        selectedIcon = bossIcon;
      }
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _subTitleController.dispose();
    _deathsController.dispose();
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
        borderRadius: BorderRadius.circular(10)
      ),
      backgroundColor: MyColors.mainDarkColor,
      content: Container(
        constraints: BoxConstraints(
          minHeight: MediaQuery.sizeOf(context).height * 0.6,
        ),
        width: MediaQuery.sizeOf(context).width * 0.6,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
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
                    Text( 
                      "${isBossEdit? "Edit Boss" : "Add Boss"} • ${widget.gameName.isNotEmpty? widget.gameName : "Uknown"}", 
                      style: TextStyle(fontSize: MySizes.modalTextHeadingsSz),
                    ),
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
              flex: 8,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(MySizes.modalContPdd),
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
                          "Subtitle (Optional)",
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
                          "Deaths (Optional)",
                          style: TextStyle(
                            fontSize: MySizes.modalTextHeadingsSz,
                          ),
                        ),
                        TextField(
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly, // Blocks all letter inputs completely
                          ],
                          controller: _deathsController,
                          cursorColor: MyColors.whiteColor,
                          decoration: InputDecoration(
                            suffixIcon: Material(
                              color: Colors.transparent, 
                              type: MaterialType.circle,
                              clipBehavior: Clip.antiAlias,
                              child: MyIconButton( icon: Icons.add, onPressed: () {
                                int? number = int.tryParse(_deathsController.text);
                                number ??= 0;
                                _deathsController.text = (number + 1).toString(); 
                              }),
                            ),
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
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Defeated?",
                          style: TextStyle(
                            fontSize: MySizes.modalTextHeadingsSz,
                          ),
                        ),
                        Checkbox(
                          value: _isChecked, 
                          checkColor: Colors.transparent,
                          fillColor: WidgetStateProperty.resolveWith<Color>((states) {
                            if (states.contains(WidgetState.selected)) {
                              return MyColors.yellowColor; 
                            }
                            return Colors.transparent; 
                          }),
                          side: WidgetStateBorderSide.resolveWith((states) {
                            if (states.contains(WidgetState.selected)) {
                              return const BorderSide(color: Colors.transparent);
                            }
                            return const BorderSide(color: MyColors.greyColor, width: MySizes.borderWidth);
                          }),
                          onChanged: (value) {
                            setState(() {
                              _isChecked = value ?? false;
                            });
                          },
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
                          final bool isSelected = (selectedIndex == index);

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
              ),
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
                      MyActionButton(text: (isBossEdit? "Edit Boss" : "Add Boss"), onPressed: () {
                        // To get a boss out of modal window 
                        // right to boss list
                        BossModel boss = BossModel(
                          bossTitle: _titleController.text, 
                          bossSubtitle: _subTitleController.text, 
                          bossImage: selectedIcon, 
                          deaths: int.tryParse(_deathsController.text),
                          isDefeated: _isChecked
                        );
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