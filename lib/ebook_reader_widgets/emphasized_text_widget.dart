import 'package:flutter/material.dart';

class EmphasizedTextWidget extends StatelessWidget {
  final String text;
  final Color textColor;
  final double fontSize;

  const EmphasizedTextWidget({
    Key? key,
    required this.text,
    this.textColor = Colors.white,
    this.fontSize = 14,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      child: Text(
        text,
        style: TextStyle(
          fontStyle: FontStyle.italic,
          fontSize: fontSize,
          color: textColor,
        ),
      ),
    );
  }
}
