import 'package:flutter/material.dart';
import 'package:driver_app/theme/colors.dart';

class SimpleIconTextBox extends StatelessWidget {
  SimpleIconTextBox({
    Key? key,
    required this.icon,
    required this.iconColor,
    required this.text,
    required this.textColor,
  }) : super(key: key);
  final IconData icon;
  final String text;
  final Color iconColor;
  final Color textColor;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: iconColor),
        SizedBox(
          width: 5,
        ),
        Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
