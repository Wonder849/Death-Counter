import 'package:death_counter/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:death_counter/styles/sizes.dart';

// Own icon button preset
class MyIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final double contSize;
  final double iconSize;
  final bool borderRadius;

  const MyIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.contSize = MySizes.buttonIconContSz,
    this.iconSize = MySizes.buttonIconSz,
    this.borderRadius = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      hoverColor: MyColors.greyColor,
      splashColor: Colors.transparent,
      borderRadius: BorderRadius.circular(borderRadius? 50 : 0),
      child: Container(
        width: contSize,
        height: contSize,
        alignment: Alignment.center,
        child: Icon(icon, color: MyColors.whiteColor, size: iconSize),
      ),
    );
  }
}

class MyActionButton extends StatelessWidget {
  final Widget? icon;
  final String text;
  final VoidCallback onPressed;
  final double width;
  final double height;
  const MyActionButton({
    super.key,
    this.icon,
    this.text = "",
    required this.onPressed,
    this.width = MySizes.buttonActionWidth,
    this.height = MySizes.buttonActionHeight,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.all(
        Radius.circular(MySizes.buttonActionBorderRadius),
      ),
      hoverColor: MyColors.greyColor,
      splashColor: Colors.transparent,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(MySizes.buttonActionBorderRadius),
          ),
          border: Border.all(width: 0.5, color: MyColors.whiteColor),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if(icon != null) ...[
              icon!,
              if (text.isNotEmpty) ...[
                SizedBox(width: 8), 
              ]
            ],
            if(text.isNotEmpty) ...[
              Text(text, style: TextStyle(color: MyColors.whiteColor)),
            ]
          ],
        ),
      ),
    );
  }
}
