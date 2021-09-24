import 'package:flutter/material.dart';
import 'package:driver_app/theme/colors.dart';

class SimpleIconTextBox extends StatelessWidget {
  const SimpleIconTextBox({
    Key? key,
    required this.icon,
    required this.text,
  }) : super(key: key);
  final IconData icon;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: primaryColorLight),
        SizedBox(
          width: 5,
        ),
        Text(
          text,
          style: TextStyle(
            color: primaryColorWhite,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
