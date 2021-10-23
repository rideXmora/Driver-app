import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:driver_app/theme/colors.dart';

class SecondaryButton extends StatelessWidget {
  SecondaryButton({
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

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      //width: width,
      decoration: BoxDecoration(
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
            ? Center(
                child: CircularProgressIndicator(
                  valueColor:
                      new AlwaysStoppedAnimation<Color>(primaryColorWhite),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    text,
                    style: TextStyle(
                      color: primaryColorWhite,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ],
              ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: boxColor,
        textColor: primaryColorWhite,
        onPressed: loading ? () {} : onPressed,
      ),
    );
  }
}
