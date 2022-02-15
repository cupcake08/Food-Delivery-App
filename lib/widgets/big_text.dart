import 'package:flutter/material.dart';

class BigText extends StatelessWidget {
  const BigText({
    Key? key,
    this.color = const Color(0xFF332d2b),
    required this.text,
    this.overflow = TextOverflow.ellipsis,
    this.size = 20,
  }) : super(key: key);
  final Color color;
  final String text;
  final double size;
  final TextOverflow overflow;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: overflow,
      style: TextStyle(
        color: color,
        fontWeight: FontWeight.w400,
        fontFamily: 'Roboto',
        fontSize: size,
      ),
    );
  }
}
