import 'package:flutter/material.dart';
import 'package:food_delivery/utils/dimensions.dart';

var color1 = const Color(0xfffcf4e4);
var color2 = const Color(0xff756d54);

class AppIcon extends StatelessWidget {
  const AppIcon({
    Key? key,
    required this.icon,
    this.backgroundColor = const Color(0xfffcf4e4),
    this.iconColor = const Color(0xff756d54),
    this.size = 40,
  }) : super(key: key);
  final IconData icon;
  final Color backgroundColor, iconColor;
  final double size;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size / 2),
        color: backgroundColor,
      ),
      child: Icon(
        icon,
        color: iconColor,
        size: Dimensions.iconSize16,
      ),
    );
  }
}
