import 'package:death_counter/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:death_counter/styles/sizes.dart';

// TitleBar Button preset
class MyIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final double contSize;
  final double iconSize;

  const MyIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.contSize = MySizes.buttonIconContSz,
    this.iconSize = MySizes.buttonIconSz
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      hoverColor: MyColors.hoverTitleBarColor,
      splashColor: Colors.transparent,
      child: Container(
        width: contSize,
        height: contSize,
        alignment: Alignment.center,
        child: Icon(icon, color: MyColors.whiteColor, size: iconSize),
      ),
    );
  }
}
