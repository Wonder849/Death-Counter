import 'package:death_counter/styles/colors.dart';
import 'package:death_counter/styles/sizes.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';
import 'buttons.dart';
// Custom title bar with title,
// Close, Hide to Tray and Setting buttons
class CustomTitleBar extends StatelessWidget {
  const CustomTitleBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: MyColors.bordersColor, width: MySizes.borderWidth),
        ),
      ),
      child: Row(
        children: [
          MyIconButton(icon: (Icons.settings), onPressed: () => {}),
          Expanded(child: DragToMoveArea(
            child: Text(
              "DEATH COUNTER",
              textAlign: TextAlign.center, 
              style: TextStyle(
                color:MyColors.whiteColor,
                fontSize: 18,
              ),
            )
          )),
          MyIconButton(
            icon: (Icons.remove),
            onPressed: () => {windowManager.minimize()}
          ),
          MyIconButton(
            icon: (Icons.close),
            onPressed: () => {windowManager.close()}
          ),
        ],
      ),
    );
  }
}