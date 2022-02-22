import 'package:flutter/material.dart';

class SmallText extends StatelessWidget {
  const SmallText({
    Key? key,
    this.color = const Color(0xFFccc7c5),
    required this.text,
    this.size = 12,
    this.height = 1.2,
    this.overflow,
    this.maxLines,
  }) : super(key: key);
  final Color color;
  final String text;
  final double size;
  final double height;
  final TextOverflow? overflow;
  final int? maxLines;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      overflow: overflow,
      style: TextStyle(
        color: color,
        fontWeight: FontWeight.w400,
        fontFamily: 'Roboto',
        fontSize: size,
        height: height,
      ),
    );
  }
}
