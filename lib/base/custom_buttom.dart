import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/utils/dimension.dart';

class CustomButtom extends StatelessWidget {
  final VoidCallback? onPressed;
  final String buttonText;
  final bool transparent;
  final EdgeInsets? margin;
  final double? width;
  final double? height;
  final double? fontSize;
  final double radius;
  final IconData? icon;
  const CustomButtom({super.key,
    required this.buttonText,
    this.transparent = false,
    this.margin, this.width = 280, this.height = 50,
    this.fontSize,
    this.radius= 5,
    this.icon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    final ButtonStyle _flatButton = TextButton.styleFrom(
      backgroundColor: onPressed==null?Theme.of(context).disabledColor:transparent?Colors.transparent:Theme.of(context).primaryColor,
      minimumSize: Size(width==null?Dimension.screenWidth:width!,
          height==null?height!:50),
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
    );
    return Center(
      child: SizedBox(
        width: width??Dimension.screenWidth,
        height: height??50,
        child: TextButton(
          onPressed: onPressed,
            style: _flatButton,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon!=null?Padding(
                  padding: EdgeInsets.only(right: Dimension.width10/2),
                  child: Icon(icon, color: transparent?Theme.of(context).primaryColor:Theme.of(context).cardColor)
              ):SizedBox(),
              Text(buttonText, style: TextStyle(
                color: transparent?Theme.of(context).primaryColor:Theme.of(context).cardColor,
                fontSize: fontSize!=null?fontSize! : Dimension.font_size16,
              ),)
            ],
          ),
        ),
      ),
    );
  }
}
