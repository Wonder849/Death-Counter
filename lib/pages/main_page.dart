import 'package:death_counter/styles/colors.dart';
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
          Row(
            children: [
              Expanded(flex: 1, child: GameListHeader()),
              Expanded(flex: 2, child: BossListHeader()),
            ],
          ),
        ],
      ),
    );
  }
}
