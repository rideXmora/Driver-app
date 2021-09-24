import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:driver_app/theme/colors.dart';
import 'package:driver_app/widgets/secondary_button.dart';

class FindingRideFloatingPanel extends StatelessWidget {
  FindingRideFloatingPanel({
    Key? key,
    required this.loading,
    this.onPressed,
  }) : super(key: key);

  final onPressed;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: primaryColorLight,
          borderRadius: BorderRadius.all(Radius.circular(17)),
          boxShadow: [
            BoxShadow(
              blurRadius: 5,
              color: primaryColorDark,
            ),
          ]),
      margin: const EdgeInsets.only(
        left: 15,
        right: 15,
        bottom: 10,
        top: 24,
      ),
      child: Column(
        children: [
          Container(
            height: 326,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(17),
                topRight: Radius.circular(17),
                bottomLeft: Radius.circular(17),
                bottomRight: Radius.circular(17),
              ),
              color: primaryColorWhite,
            ),
            child: Stack(
              children: [
                Container(
                  height: 326,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(17),
                      topRight: Radius.circular(17),
                      bottomLeft: Radius.circular(17),
                      bottomRight: Radius.circular(17),
                    ),
                    color: primaryColorWhite,
                  ),
                  child: LottieBuilder.asset(
                    "assets/lotties/passenger_wait_for_driver.json",
                    height: 360,
                    fit: BoxFit.fill,
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 25,
                    ),
                    child: Text(
                      "Finding a ride.....",
                      style: TextStyle(
                        color: primaryColorDark,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width - 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(17),
                        bottomRight: Radius.circular(17),
                      ),
                      color: primaryColorLight,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: SecondaryButton(
                      height: 40,
                      width: MediaQuery.of(context).size.width * 0.5,
                      onPressed: onPressed,
                      loading: loading,
                      text: "Cancel ride",
                      boxColor: primaryColorDark,
                      shadowColor: Colors.transparent,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Divider(
          //   height: 3,
          //   color: primaryColorDark,
          //   thickness: 3,
          // ),
        ],
      ),
    );
  }
}
