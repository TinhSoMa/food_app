import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/utils/dimension.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String buttonText;
  final bool transparent;
  final EdgeInsets? margin;
  final double? height;
  final double? width;
  final double? fontSize;
  final double radius;
  final IconData? icon;
  CustomButton({this.onPressed, required this.buttonText, this.transparent = false,
    this.margin, this.width, this.height,
    this.fontSize, this.radius = 5, this.icon});

  @override
  Widget build(BuildContext context) {
    final ButtonStyle _flatButtonStyle = TextButton.styleFrom(
      backgroundColor: onPressed == null ? Theme.of(context).disabledColor : transparent
          ? Colors.transparent : Theme.of(context).primaryColor,
      minimumSize: Size(width != null ? width! : Dimension.screenWidth,
          height != null ? height! : 50),
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
    );

    return Center(child: SizedBox(width: width != null ? width : Dimension.screenWidth,
        child: Padding(
          padding: margin == null ? EdgeInsets.all(0) : margin!,
          child: TextButton(
            onPressed: onPressed,
            style: _flatButtonStyle,
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              icon != null ? Padding(
                padding: EdgeInsets.only(right: Dimension.width10),
                child: Icon(icon, color: transparent ? Theme.of(context).primaryColor : Theme.of(context).cardColor),
              ) : SizedBox(),
              Text(buttonText ??'', textAlign: TextAlign.center,
              //     style: robotoBold.copyWith(
              //   color: transparent ? Theme.of(context).primaryColor : Theme.of(context).cardColor,
              //   fontSize: fontSize != null ? fontSize : Dimension.font_size26,
              // )
              ),
            ]),
          ),
        )));
  }
}
