import 'package:death_counter/styles/colors.dart';
import 'package:death_counter/styles/sizes.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

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
          TitleBarButton(icon: Icons.settings, onPressed: () => {}),
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
          TitleBarButton(
            icon: Icons.remove,
            onPressed: () => {windowManager.minimize()},
          ),
          TitleBarButton(
            icon: Icons.close,
            onPressed: () => {windowManager.close()},
          ),
        ],
      ),
    );
  }
}

// TitleBar Button preset
class TitleBarButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const TitleBarButton({
    super.key,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      hoverColor: MyColors.hoverTitleBarColor,
      splashColor: Colors.transparent,
      child: Container(
        width: 40,
        height: 40,
        alignment: Alignment.center,
        child: Icon(icon, color: MyColors.whiteColor, size: 20,),
      ),
    );
  }
}
