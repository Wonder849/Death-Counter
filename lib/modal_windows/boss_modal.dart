import 'package:death_counter/modal_windows/inform_modal.dart';
import 'package:death_counter/models/boss_model.dart';
import 'package:death_counter/styles/colors.dart';
import 'package:death_counter/styles/sizes.dart';
import 'package:death_counter/utils/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BossModal extends StatefulWidget {

  // Need to display name of game in 
  // title of modal window
  final String gameName;

  final BossModel? boss;

  const BossModal({super.key, required this.gameName, this.boss});

  @override
  State<BossModal> createState() => _BossModalState();
}

class _BossModalState extends State<BossModal> {

    final List<String> _iconsList = [
    'Img/sword_icon.png',
    'Img/demon_skull.png',
    'Img/dragon.png',
    
    'Img/Plus.png'
  ];

  late bool isBossEdit;
  
  late final _titleController = isBossEdit? TextEditingController(text: widget.boss?.bossTitle ?? ""): TextEditingController();
  late final _subTitleController = isBossEdit? TextEditingController(text: widget.boss?.bossSubTitle ?? ""): TextEditingController();
  late final _deathsController = isBossEdit? TextEditingController(text: (widget.boss?.bossDeaths != null)? (widget.boss?.bossDeaths.toString()) : ""): TextEditingController();

  late bool _isChecked = isBossEdit? widget.boss?.isDefeated ?? false : false; 

  String selectedIcon = "Img/question_mark.png";
  int? selectedIndex;

  // Need to select icon that was selected previously
  // for editing boss
  @override
  void initState() {
    super.initState();
    isBossEdit = (widget.boss != null);

    if (isBossEdit && widget.boss?.bossIconPath != null) {
      final bossIconPath = widget.boss!.bossIconPath;

      selectedIndex = _iconsList.indexWhere((icon) => icon == bossIconPath);

      if (selectedIndex != -1) {
        selectedIcon = _iconsList[selectedIndex!];
      } else {
        selectedIndex = null;
        selectedIcon = bossIconPath;
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

  void submitBoss() async {
    int? bossDeaths = int.tryParse(_deathsController.text);
    if (bossDeaths != null && bossDeaths < 0) {
      await showDialog(
        context: context,
        builder: (context) =>
            InformModal(title: "Error", message: "Deaths can't be negative"),
      );
      return;
    }
    // To get a boss out of modal window
    // right to boss list
    BossModel boss = BossModel(
      bossTitle: _titleController.text,
      bossSubTitle: _subTitleController.text,
      bossIconPath: selectedIcon,
      bossDeaths: int.tryParse(_deathsController.text),
      isDefeated: _isChecked,
    );
    Navigator.of(context).pop(boss);
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
        child: CallbackShortcuts(
          bindings: {
            const SingleActivator(LogicalKeyboardKey.enter) : submitBoss
          },
          child: Focus(
            autofocus: true,
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
                              final String iconPath = entry.value;
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
                          MyActionButton(text: (isBossEdit? "Save" : "Add Boss"), onPressed: submitBoss),
                          MyActionButton(text: "Cancel", onPressed: () {Navigator.of(context).pop(null);})
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}