import 'package:flutter/material.dart';

class ParagraphWidget extends StatelessWidget {
  final String title;
  final double fontSize;
  final Color textColor;
  const ParagraphWidget({
    Key? key,
    required this.title,
    this.fontSize = 14,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Text(
        title,
        style: TextStyle(
          fontSize: fontSize,
          color: textColor,
        ),
      ),
    );
  }
}
