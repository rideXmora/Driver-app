import 'package:driver_app/modals/passenger.dart';
import 'package:driver_app/modals/trip.dart';
import 'package:driver_app/widgets/secondary_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:driver_app/modals/driver.dart';
import 'package:driver_app/utils/trip_state_enum.dart';
import 'package:driver_app/theme/colors.dart';
import 'package:driver_app/widgets/secondary_button_with_icon.dart';
import 'package:driver_app/widgets/simple_icon_text_box.dart';

class RideFloatingPanel extends StatelessWidget {
  RideFloatingPanel({
    Key? key,
    required this.loading,
    required this.passenger,
    required this.trip,
    required this.tripState,
    this.onPressedAccept,
    this.onPressedReject,
  }) : super(key: key);

  final onPressedAccept;
  final onPressedReject;
  final Passenger passenger;
  final TripState tripState;
  final bool loading;
  final Trip trip;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
          color: primaryColorDark,
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
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              tripState == TripState.ACCEPTED
                  ? "Accepted"
                  : tripState == TripState.ONTRIP
                      ? "On trip"
                      : "",
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
            Spacer(
              flex: 1,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(passenger.image),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          passenger.name,
                          style: TextStyle(
                            color: primaryColorBlack,
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          passenger.number,
                          style: TextStyle(
                            color: primaryColorWhite,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: primaryColorLight,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.phone,
                            color: primaryColorDark,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Spacer(
              flex: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Ride details",
                  style: TextStyle(
                    color: primaryColorBlack,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            Divider(
              thickness: 1.5,
              color: primaryColorBlack,
              height: 15,
            ),
            Spacer(
              flex: 2,
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
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                              crossAxisAlignment: CrossAxisAlignment.start,
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
            Spacer(
              flex: 2,
            ),
            Row(
              children: [
                Expanded(
                  flex: 10,
                  child: SecondaryButton(
                    width: MediaQuery.of(context).size.width * 0.4,
                    onPressed: onPressedAccept,
                    loading: loading,
                    text: "Accept",
                    boxColor: primaryColorLight,
                    shadowColor: Colors.transparent,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(),
                ),
                Expanded(
                  flex: 10,
                  child: SecondaryButton(
                    width: MediaQuery.of(context).size.width * 0.4,
                    onPressed: onPressedReject,
                    loading: loading,
                    text: "Cancel Ride",
                    boxColor: Color(0xFFD7A7A7),
                    shadowColor: Colors.transparent,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
