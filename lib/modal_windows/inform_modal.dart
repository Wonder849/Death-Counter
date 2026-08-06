import 'package:death_counter/styles/colors.dart';
import 'package:death_counter/styles/sizes.dart';
import 'package:death_counter/utils/buttons.dart';
import 'package:flutter/material.dart';

class InformModal extends StatelessWidget {
  final bool isTwoButtons;
  final String title;
  final String message;

  const InformModal({super.key, required this.message , this.isTwoButtons = false, this.title = ""});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: MyColors.greyColor, width: MySizes.borderWidth),
        borderRadius: BorderRadius.circular(10),
      ),
      backgroundColor: MyColors.mainDarkColor,
      content: SizedBox(
        width: MediaQuery.sizeOf(context).width * 0.5,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: MySizes.titleBarsHeight,
              width: MediaQuery.sizeOf(context).width * 0.5,
              decoration: BoxDecoration(
                border: Border( bottom: BorderSide(
                  width: MySizes.borderWidth,
                  color: MyColors.greyColor,
                )),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: MySizes.modalTextHeadingsSz),
                  ),
                  Positioned(
                    right: 0,
                    child: MyIconButton(
                      icon: (Icons.close),
                      onPressed: () => {Navigator.of(context).pop()},
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsGeometry.all(20),
              child: Center(
                child: Text(
                  textAlign: TextAlign.center,
                  message,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: MyColors.greyColor))
              ),
              padding: EdgeInsets.only(top: 10, bottom: 10, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                spacing: 15,
                children: [
                  if(isTwoButtons) ...[
                    MyActionButton(
                      onPressed: (){ Navigator.of(context).pop(true); },
                      text: "OK",
                    ),
                    MyActionButton(
                      onPressed: (){ Navigator.of(context).pop(false); },
                      text: "Cancel",
                    )
                  ]
                  else ...[
                    MyActionButton(
                      onPressed: (){ Navigator.of(context).pop(); },
                      text: "OK",
                    )
                  ]
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
