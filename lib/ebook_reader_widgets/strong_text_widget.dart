import 'package:flutter/material.dart';

class StrongTextWidget extends StatelessWidget {
  final String text;
  final Color textColor;
  final double fontSize;

  const StrongTextWidget({
    Key? key,
    required this.text,
    this.textColor = Colors.white,
    this.fontSize = 16, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: fontSize,
          color: textColor,
        ),
      ),
    );
  }
}
