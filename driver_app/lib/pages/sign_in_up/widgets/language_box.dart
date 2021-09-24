import 'package:flutter/material.dart';

class LanguageBox extends StatelessWidget {
  LanguageBox({
    Key? key,
    required this.backgroundColor,
    required this.borderColor,
    required this.text,
    required this.fontColor,
  }) : super(key: key);

  final Color backgroundColor;
  final Color borderColor;
  final String text;
  final Color fontColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: borderColor,
          width: 1,
        ),
        color: backgroundColor,
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 30,
            vertical: 11,
          ),
          child: Text(
            text,
            style: TextStyle(
              color: fontColor,
              fontSize: 20,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
