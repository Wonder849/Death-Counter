import 'package:death_counter/lists/lists_controllers/boss_list_controller.dart';
import 'package:death_counter/lists/lists_controllers/games_list_controller.dart';
import 'package:death_counter/styles/sizes.dart';
import 'package:flutter/material.dart';

// Displays all games deaths and some
// boss deaths info
class CustomFooterBar extends StatelessWidget {
  final GamesListController gamesListNotifier;
  final BossListController bossListNotifier;

  const CustomFooterBar({
    super.key,
    required this.gamesListNotifier,
    required this.bossListNotifier,
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: Listenable.merge([gamesListNotifier, bossListNotifier]),
      builder: (context, child) {
        return SizedBox(
          height: MySizes.footerBarHeight,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: Text(""),
              ),
            ],
          ),
        );
      },
    );
  }
}
