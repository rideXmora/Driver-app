import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:driver_app/theme/colors.dart';

class CustomBackButton extends StatelessWidget {
  final onTap;
  const CustomBackButton({
    Key? key,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap == null
          ? () {
              Navigator.of(context).pop();
            }
          : onTap,
      child: Container(
        width: 45,
        height: 45,
        decoration: BoxDecoration(
          color: primaryColorDark,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
            child: Icon(
          Icons.keyboard_arrow_left_rounded,
          color: primaryColorWhite,
          size: 40,
        )),
      ),
    );
  }
}
