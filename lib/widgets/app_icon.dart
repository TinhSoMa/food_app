import 'package:flutter/cupertino.dart';

class AppIcon extends StatelessWidget {
  final IconData iconData;
  final Color colorBackGroundColor;
  final Color color;
  final double size;
  const AppIcon({super.key, required this.iconData, this.colorBackGroundColor = const Color(0xFFccc7c5), this.color = const Color(0xFF5c524f), this.size = 30});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
