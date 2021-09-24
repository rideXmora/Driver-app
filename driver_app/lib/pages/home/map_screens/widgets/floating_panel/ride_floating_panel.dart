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
    required this.driver,
    required this.tripState,
    required this.time,
    this.onPressed,
  }) : super(key: key);

  final onPressed;
  final String time;
  final Driver driver;
  final TripState tripState;
  final bool loading;

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
              tripState == TripState.DRIVERCOMMING
                  ? "Driver is comming"
                  : tripState == TripState.GOINGTODESTINATION
                      ? "Going to Destination"
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
              flex: 4,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
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
                          image:
                              AssetImage("assets/images/images/user_icon.png"),
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
                          driver.name,
                          style: TextStyle(
                            color: primaryColorBlack,
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          driver.vechicleType,
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
                  Divider(
                    thickness: 1.5,
                    color: primaryColorBlack,
                    height: 15,
                  ),
                ],
              ),
            ),
            Spacer(
              flex: 4,
            ),
            Divider(
              thickness: 1.5,
              color: primaryColorBlack,
              height: 15,
            ),
            Spacer(
              flex: 3,
            ),
            SimpleIconTextBox(
              icon: Icons.timer,
              text: "$time remaining",
            ),
            Spacer(
              flex: 3,
            ),
            SecondaryButtonWithIcon(
              icon: Icons.phone,
              iconColor: primaryColorWhite,
              width: MediaQuery.of(context).size.width * 0.5,
              onPressed: onPressed,
              loading: loading,
              text: "Call Driver",
              boxColor: primaryColorLight,
              shadowColor: Colors.transparent,
            )
          ],
        ),
      ),
    );
  }
}
