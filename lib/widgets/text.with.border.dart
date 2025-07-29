import 'package:flutter/material.dart';

class TextWithBorder extends StatelessWidget {
  final String text;
  final double fontSize;
  final String? fontFamily;
  final Color borderColor;
  final double strokeWidth;
  final Color fillColor;

  const TextWithBorder({
    super.key,
    required this.text,
    this.fontSize = 84,
    this.fontFamily,
    this.borderColor = Colors.black,
    this.strokeWidth = 6,
    this.fillColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Stroke
        Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            fontFamily: fontFamily,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = strokeWidth
              ..color = borderColor,
          ),
        ),
        // Fill
        Text(
          text,
          style: TextStyle(
            color: fillColor,
            fontSize: fontSize,
            fontFamily: fontFamily,
          ),
        ),
      ],
    );
  }
}
