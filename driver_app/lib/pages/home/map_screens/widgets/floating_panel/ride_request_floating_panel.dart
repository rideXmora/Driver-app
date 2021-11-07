import 'package:driver_app/modals/passenger.dart';
import 'package:driver_app/modals/ride_request_passenger.dart';
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
    required this.loadingGreen,
    required this.loadingRed,
    this.onPressedAccept,
    this.onPressedReject,
    required this.greenTopic,
    required this.redTopic,
  }) : super(key: key);

  final onPressedAccept;
  final onPressedReject;
  final RideRequestPassenger passenger;
  final bool loadingGreen;
  final bool loadingRed;
  final Trip trip;
  final String greenTopic;
  final String redTopic;

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
                  //TODO
                  image: AssetImage("assets/images/images/user_icon.png"),
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
                    text: trip.distance,
                    textColor: primaryColorWhite,
                  ),
                  SimpleIconTextBox(
                    icon: Icons.timer,
                    iconColor: primaryColorLight,
                    text: trip.time,
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
                    loading: loadingGreen,
                    text: greenTopic,
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
                    loading: loadingRed,
                    text: redTopic,
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
