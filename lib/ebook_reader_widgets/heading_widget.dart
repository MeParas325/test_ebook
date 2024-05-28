import 'package:flutter/material.dart';
import 'package:test/enums/heading_enums.dart';

class HeadingWidget extends StatelessWidget {
  final String headingText;
  final HeadingType headingType;
  final FontWeight fontWeight;

  final Color headingColor;
  const HeadingWidget({
    Key? key,
    required this.headingText,
    required this.headingType,
    required this.fontWeight,
    this.headingColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double fontsize = 12;

    if (headingType == HeadingType.h1) {
      fontsize = 32;
    } else if (headingType == HeadingType.h2) {
      fontsize = 24;
    } else if (headingType == HeadingType.h3) {
      fontsize = 20;
    } else if (headingType == HeadingType.h4) {
      fontsize = 18;
    } else if (headingType == HeadingType.h5) {
      fontsize = 16;
    } else if (headingType == HeadingType.h6) {
      fontsize = 14;
    }

    return Container(
      margin: const EdgeInsets.all(10),
      child: Text(
        headingText,
        style: TextStyle(
          color: headingColor,
          fontWeight: fontWeight,
          fontSize: fontsize,
        ),
      ),
    );
  }
}
