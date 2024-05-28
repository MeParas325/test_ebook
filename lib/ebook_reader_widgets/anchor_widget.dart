import 'package:flutter/material.dart';

class AnchorWidget extends StatelessWidget {
  final String text;
  final Function()? onTap;
  final double fontSize;
  final Color color;

  const AnchorWidget({
    Key? key,
    required this.text,
    this.fontSize = 14,
    this.onTap,
    this.color = Colors.blue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: onTap,
        child: Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            color: color,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    );
  }
}
