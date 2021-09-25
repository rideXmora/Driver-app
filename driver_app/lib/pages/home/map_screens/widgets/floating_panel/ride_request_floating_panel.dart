import 'package:driver_app/modals/passenger.dart';
import 'package:driver_app/modals/trip.dart';
import 'package:driver_app/pages/home/map_screens/widgets/smooth_star_rating.dart';
import 'package:driver_app/widgets/simple_icon_text_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:driver_app/pages/home/map_screens/widgets/vehicle_Selection_RadioButton.dart';
import 'package:driver_app/theme/colors.dart';
import 'package:driver_app/widgets/secondary_button.dart';

class RideRequestFloatingPanel extends StatelessWidget {
  RideRequestFloatingPanel({
    Key? key,
    required this.trip,
    required this.passenger,
    required this.loading,
    this.onPressedAccept,
    this.onPressedReject,
  }) : super(key: key);

  final onPressedAccept;
  final onPressedReject;
  final Passenger passenger;
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
          children: [
            Text(
              "New Ride Request",
              style: TextStyle(
                color: primaryColorBlack,
                fontSize: 23,
                fontWeight: FontWeight.w700,
              ),
            ),
            Spacer(
              flex: 2,
            ),
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(passenger.image),
                ),
              ),
            ),
            Spacer(
              flex: 1,
            ),
            Text(
              passenger.name,
              style: TextStyle(
                color: primaryColorBlack,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            Spacer(
              flex: 1,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: SmoothStarRating(
                rating: passenger.rating.floor(),
                size: 30,
              ),
            ),
            Spacer(
              flex: 2,
            ),
            Text(
              "Destination",
              style: TextStyle(
                color: primaryColorWhite,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            SimpleIconTextBox(
              icon: Icons.location_on_sharp,
              iconColor: primaryColorBlack,
              text: trip.destination,
              textColor: primaryColorBlack,
            ),
            Spacer(
              flex: 2,
            ),
            Center(
              child: Wrap(
                runAlignment: WrapAlignment.center,
                alignment: WrapAlignment.center,
                spacing: 5,
                children: [
                  SimpleIconTextBox(
                    icon: Icons.location_on_sharp,
                    iconColor: primaryColorLight,
                    text: "${trip.distance} miles",
                    textColor: primaryColorWhite,
                  ),
                  SimpleIconTextBox(
                    icon: Icons.timer,
                    iconColor: primaryColorLight,
                    text: "${trip.time} min",
                    textColor: primaryColorWhite,
                  ),
                  SimpleIconTextBox(
                    icon: Icons.attach_money_sharp,
                    iconColor: primaryColorLight,
                    text: "${trip.amount} LKR",
                    textColor: primaryColorWhite,
                  ),
                ],
              ),
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
                    text: "Reject",
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
