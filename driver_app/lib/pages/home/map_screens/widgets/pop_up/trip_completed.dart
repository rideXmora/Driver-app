import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:driver_app/theme/colors.dart';
import 'package:driver_app/widgets/secondary_button.dart';
import 'package:driver_app/widgets/simple_icon_text_box.dart';

class TripCompleted extends StatelessWidget {
  TripCompleted({
    Key? key,
    required this.loading,
    this.onPressed,
  }) : super(key: key);

  final onPressed;

  final bool loading;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: primaryColorDark,
                  borderRadius: BorderRadius.all(Radius.circular(17)),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 5,
                      color: primaryColorDark,
                    ),
                  ]),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 28,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        "Trip Completed",
                        style: TextStyle(
                          color: primaryColorBlack,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Ride details",
                      style: TextStyle(
                        color: primaryColorBlack,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Divider(
                      thickness: 1.5,
                      color: primaryColorBlack,
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                width: 20,
                                height: 20,
                                child: Icon(
                                  Icons.location_pin,
                                  color: primaryColorLight,
                                  size: 20,
                                ),
                              ),
                              Container(
                                width: 2,
                                height: 20,
                                color: primaryColorLight,
                              ),
                              Container(
                                width: 20,
                                height: 20,
                                child: Icon(
                                  Icons.flag,
                                  color: primaryColorLight,
                                  size: 20,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 30,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Pick up location",
                                          style: TextStyle(
                                            color: primaryColorBlack,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          "Moratuwa, Sri Lanka",
                                          style: TextStyle(
                                            color: primaryColorWhite,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    height: 30,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Destination",
                                          style: TextStyle(
                                            color: primaryColorBlack,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          "Panadura, Sri Lanka",
                                          style: TextStyle(
                                            color: primaryColorWhite,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 16,
                        bottom: 16,
                      ),
                      child: Center(
                        child: Wrap(
                          runAlignment: WrapAlignment.center,
                          alignment: WrapAlignment.center,
                          spacing: 5,
                          children: [
                            SimpleIconTextBox(
                              icon: Icons.location_on_sharp,
                              text: "0.1 miles",
                            ),
                            SimpleIconTextBox(
                              icon: Icons.timer,
                              text: "1 min",
                            ),
                            SimpleIconTextBox(
                              icon: Icons.attach_money_sharp,
                              text: "250 LKR",
                            ),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.credit_card, color: primaryColorLight),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Card Payment",
                          style: TextStyle(
                            color: primaryColorWhite,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: SecondaryButton(
                        width: MediaQuery.of(context).size.width * 0.4,
                        onPressed: onPressed,
                        loading: loading,
                        text: "Confirm",
                        boxColor: primaryColorLight,
                        shadowColor: Colors.transparent,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
