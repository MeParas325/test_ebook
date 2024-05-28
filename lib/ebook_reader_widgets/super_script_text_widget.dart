import 'package:flutter/material.dart';

class SuperscriptTextWidget extends StatelessWidget {
  final String text;

  const SuperscriptTextWidget({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      child: RichText(
        text: TextSpan(
          text: text,
          style: const TextStyle(
            fontSize: 16.0,
            color: Colors.black,
          ),
          children: const [
            TextSpan(
              text: ' ',
              style:
                  TextStyle(fontSize: 8.0), // Adjust font size for superscript
            ),
            TextSpan(
              text: 'sup',
              style: TextStyle(
                  fontSize: 8.0, textBaseline: TextBaseline.alphabetic),
            ),
          ],
        ),
      ),
    );
  }
}
