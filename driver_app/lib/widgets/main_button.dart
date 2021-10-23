import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:driver_app/theme/colors.dart';

class MainButton extends StatelessWidget {
  MainButton({
    required this.width,
    required this.height,
    required this.onPressed,
    required this.text,
    this.loading = false,
    required this.boxColor,
    required this.shadowColor,
  });

  final double width;
  final double height;
  final onPressed;
  final String text;
  final bool loading;
  final Color boxColor;
  final Color shadowColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 50,
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
                children: [
                  Text(
                    text,
                    style: TextStyle(
                      color: primaryColorWhite,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                    overflow: TextOverflow.ellipsis,
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
