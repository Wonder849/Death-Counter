import 'package:death_counter/models/boss_model.dart';
import 'package:death_counter/styles/colors.dart';
import 'package:death_counter/utils/title_bar.dart';
import 'package:flutter/material.dart';

// Page for interacting with boss info 
class BossPage extends StatefulWidget {

  // Need for displaying correct info
  final BossModel boss;
  const BossPage({super.key, required this.boss});

  @override
  State<BossPage> createState() => _BossPageState();
}

class _BossPageState extends State<BossPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.mainDarkColor,
      body: Column(
        children: [
          CustomTitleBar(),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(onPressed: () => Navigator.pop(context), icon: Icon(Icons.chevron_left, color: Colors.white,)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}