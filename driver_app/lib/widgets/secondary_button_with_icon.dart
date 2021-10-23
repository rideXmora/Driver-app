import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:driver_app/theme/colors.dart';

class SecondaryButtonWithIcon extends StatelessWidget {
  SecondaryButtonWithIcon({
    required this.icon,
    required this.iconColor,
    required this.onPressed,
    required this.text,
    this.loading = false,
    required this.boxColor,
    required this.shadowColor,
    required this.width,
    this.height = 40,
  });

  final onPressed;
  final String text;
  final bool loading;
  final Color boxColor;
  final Color shadowColor;
  final double width;
  final double height;
  final IconData icon;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      //width: width,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: shadowColor.withOpacity(0.06),
            blurRadius: 10,
            spreadRadius: 5,
          ),
        ],
      ),
      // ignore: deprecated_member_use
      child: RaisedButton(
        child: loading
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: CircularProgressIndicator(
                      valueColor:
                          new AlwaysStoppedAnimation<Color>(primaryColorWhite),
                    ),
                  ),
                ],
              )
            : Row(
                mainAxisAlignment: text != ""
                    ? MainAxisAlignment.spaceEvenly
                    : MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  text != ""
                      ? Text(
                          text,
                          style: TextStyle(
                            color: primaryColorWhite,
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                          overflow: TextOverflow.ellipsis,
                        )
                      : Container(),
                  text != ""
                      ? SizedBox(
                          width: 5,
                        )
                      : Container(),
                  Icon(
                    icon,
                    color: iconColor,
                  )
                ],
              ),
        shape: text != ""
            ? RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
            : RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        color: boxColor,
        textColor: primaryColorWhite,
        onPressed: loading ? () {} : onPressed,
      ),
    );
  }
}
