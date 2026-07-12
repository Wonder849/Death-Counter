import 'package:death_counter/models/game_model.dart';
import 'package:death_counter/styles/colors.dart';
import 'package:death_counter/styles/sizes.dart';
import 'package:death_counter/tiles.dart/game_tile.dart';
import 'package:death_counter/utils/lists_headers.dart';
import 'package:death_counter/utils/title_bar.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.mainDarkColor,
      body: Column(
        children: [
          CustomTitleBar(),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 1, child: Column(
                  children: [
                    GameListHeader(),
                    GameTile(game: GameModel(gameName: "asd"))
                  ],
                )),
                VerticalDivider(width: MySizes.borderWidth, color: MyColors.bordersColor, thickness: MySizes.borderWidth,),
                Expanded(flex: 2, child: BossListHeader()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
