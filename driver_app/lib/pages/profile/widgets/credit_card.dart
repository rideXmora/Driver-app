import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:driver_app/utils/card_type_enum.dart';
import 'package:driver_app/theme/colors.dart';
import 'package:driver_app/utils/card_icon.dart';

class CreditCardWidget extends StatelessWidget {
  CreditCardWidget({
    required this.width,
    required this.height,
    required this.backgroundColor,
    required this.cardTypeString,
    required this.cardNumber,
    required this.expireDate,
    required this.cardType,
    required this.topSVGAlignment,
    required this.selected,
  });

  final double width;
  final double height;
  final Color backgroundColor;
  final String cardTypeString;
  final String cardNumber;
  final String expireDate;
  final CardType cardType;
  final AlignmentGeometry topSVGAlignment;
  final bool selected;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: selected
            ? Border.all(
                color: primaryColorDark,
                width: 3,
              )
            : Border.all(
                color: Colors.transparent,
                width: 0,
              ),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 20,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cardTypeString,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Spacer(flex: 2),
                Container(
                  width: width - 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "••••",
                        style: TextStyle(
                          color: Color(0xFFD4D9FF),
                          letterSpacing: 3,
                          fontSize: 25,
                        ),
                      ),
                      Text(
                        "••••",
                        style: TextStyle(
                          color: Color(0xFFD4D9FF),
                          letterSpacing: 3,
                          fontSize: 25,
                        ),
                      ),
                      Text(
                        "••••",
                        style: TextStyle(
                          color: Color(0xFFD4D9FF),
                          letterSpacing: 3,
                          fontSize: 25,
                        ),
                      ),
                      Text(
                        cardNumber.substring(12, 16),
                        style: TextStyle(
                          color: Color(0xFFD4D9FF),
                          letterSpacing: 3,
                          fontSize: 25,
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(flex: 1),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Expired",
                          style: TextStyle(
                            color: Color(0xFF8E9BFF),
                            fontSize: 10,
                          ),
                        ),
                        Text(
                          expireDate,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    getCardTypeIcon(
                      cardType: cardType,
                      cardNumber: cardNumber,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Align(
            alignment: topSVGAlignment,
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 50, left: 5),
                  child: SvgPicture.asset(
                    "assets/svgs/wallet-circle2.svg",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: SvgPicture.asset(
                    "assets/svgs/wallet-circle1.svg",
                  ),
                ),
              ],
            ),
          ),
          selected
              ? Container(
                  width: width,
                  height: height,
                  decoration: BoxDecoration(
                    color: backgroundColor.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(12),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
