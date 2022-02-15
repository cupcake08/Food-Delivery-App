import 'package:flutter/material.dart';
import 'package:food_delivery/widgets/small_text.dart';

class IconText extends StatelessWidget {
  const IconText({
    Key? key,
    required this.icon,
    required this.text,
    required this.iconColor,
  }) : super(key: key);
  final IconData icon;
  final String text;
  final Color iconColor;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: iconColor),
        const SizedBox(width: 5),
        SmallText(text: text),
      ],
    );
  }
}
