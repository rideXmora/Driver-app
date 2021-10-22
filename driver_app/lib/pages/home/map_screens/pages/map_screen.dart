import 'dart:async';

import 'package:driver_app/controllers/ride_controller.dart';
import 'package:driver_app/controllers/user_controller.dart';
import 'package:driver_app/modals/passenger.dart';
import 'package:driver_app/modals/trip.dart';
import 'package:driver_app/utils/driver_status.dart';
import 'package:driver_app/utils/payment_method.dart';
import 'package:driver_app/utils/ride_request_state_enum.dart';
import 'package:get/get.dart';
import 'package:driver_app/widgets/secondary_button_with_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:driver_app/pages/home/map_screens/widgets/floating_panel/ride_floating_panel.dart';
import 'package:driver_app/pages/home/map_screens/widgets/floating_panel/ride_request_floating_panel.dart';
import 'package:driver_app/pages/home/map_screens/widgets/pop_up/Rate_and_comment.dart';
import 'package:driver_app/pages/home/map_screens/widgets/pop_up/trip_completed.dart';
import 'package:driver_app/utils/ride_state_enum.dart';
import 'package:driver_app/theme/colors.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class MapScreen extends StatefulWidget {
  MapScreen({
    Key? key,
  }) : super(key: key);
  @override
  _MapScreenState createState() => _MapScreenState();
}

Completer<GoogleMapController> _controller = Completer();

final CameraPosition _kGooglePlex = CameraPosition(
  target: LatLng(37.42796133580664, -122.085749655962),
  zoom: 14.4746,
);

class _MapScreenState extends State<MapScreen> {
  bool loading = false;

  Passenger passenger = Passenger(
    image: "assets/images/images/user_icon.png",
    name: "Avishka Rathnavibushana",
    number: "+94711737706",
    rating: 3.4,
  );

  Trip trip = Trip(
    pickUp: "Moratuwa, Sri Lanka",
    destination: "Panadura, Sri Lanka",
    distance: 0.1,
    time: 20,
    amount: 250,
    paymentMethod: PaymentMethod.CASH,
  );

  RideState rideState = RideState.NOTRIP;
  RideRequestState rideRequest = RideRequestState.NOTRIP;

  int rating = 1;
  TextEditingController comment = TextEditingController();

  bool goingOnline = false;

  Future<void> goOnlineButton() async {
    if (!goingOnline) {
      setState(() {
        goingOnline = true;
      });

      await Get.find<RideController>().changeDriverRideStatus(x: 0, y: 0);

      setState(() {
        goingOnline = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  Widget _floatingCollapsed(RideState state, RideRequestState rideRequest) {
    return Container(
      decoration: BoxDecoration(
        color: primaryColorDark,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(17),
          topRight: Radius.circular(17),
        ),
      ),
      margin: const EdgeInsets.only(
        left: 15,
        right: 15,
        bottom: 0,
        top: 24,
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Icon(
                Icons.keyboard_arrow_up,
                color: primaryColorWhite,
                size: 35,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    rideRequest == RideRequestState.PENDING
                        ? "New ride request"
                        : state == RideState.ACCEPTED
                            ? "Accepted"
                            : state == RideState.ARRIVED
                                ? "Arrived"
                                : state == RideState.PICKED
                                    ? "On Trip"
                                    : "",
                    style: TextStyle(
                      color: primaryColorWhite,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void pendingOnPressedAccept() {
    setState(() {
      rideRequest = RideRequestState.ACCEPTED;
      rideState = RideState.ACCEPTED;
    });
  }

  void pendingOnPressedReject() {
    setState(() {
      rideRequest = RideRequestState.NOTRIP;
      rideState = RideState.NOTRIP;
    });
  }

  void acceptedOnPressedAccept() {
    setState(() {
      rideState = RideState.ARRIVED;
    });
  }

  void acceptedOnPressedReject() {
    setState(() {
      rideRequest = RideRequestState.NOTRIP;
      rideState = RideState.NOTRIP;
    });
  }

  void arrivedOnPressedAccept() {
    setState(() {
      rideState = RideState.PICKED;
    });
  }

  void arrivedOnPressedReject() {
    setState(() {
      rideRequest = RideRequestState.NOTRIP;
      rideState = RideState.NOTRIP;
    });
  }

  void pickedOnPressedAccept() {
    setState(() {
      rideState = RideState.DROPPED;
    });
  }

  void pickedOnPressedReject() {
    setState(() {
      rideRequest = RideRequestState.NOTRIP;
      rideState = RideState.NOTRIP;
    });
  }

  void tripCompletedOnPressed() {
    setState(() {
      rideState = RideState.RATEANDCOMMENT;
    });
  }

  void rateAndCommentOnPressed() {
    setState(() {
      rideState = RideState.FINISHED;
      rideState = RideState.CONFIRMED;
      rideState = RideState.NOTRIP;
      rideRequest = RideRequestState.NOTRIP;
      rating = 0;
      comment.text = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: primaryColorWhite,
      appBar: AppBar(
        backgroundColor: primaryColorWhite,
        title: Text(
          "Map",
          style: TextStyle(
            color: primaryColorBlack,
            fontSize: 23,
            fontWeight: FontWeight.w700,
          ),
        ),
        leading: Container(),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: GoogleMap(
                    mapType: MapType.normal,
                    initialCameraPosition: _kGooglePlex,
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                  ),
                ),
              ],
            ),
            rideRequest == RideRequestState.PENDING ||
                    rideState == RideState.ACCEPTED ||
                    rideState == RideState.ARRIVED ||
                    rideState == RideState.PICKED
                ? SlidingUpPanel(
                    renderPanelSheet: false,
                    panel: rideRequest == RideRequestState.PENDING
                        ? RideRequestFloatingPanel(
                            loading: loading,
                            passenger: passenger,
                            trip: trip,
                            onPressedAccept: pendingOnPressedAccept,
                            onPressedReject: pendingOnPressedReject,
                          )
                        : rideState == RideState.ACCEPTED
                            ? RideFloatingPanel(
                                rideState: rideState,
                                loading: loading,
                                passenger: passenger,
                                trip: trip,
                                onPressedAccept: acceptedOnPressedAccept,
                                onPressedReject: acceptedOnPressedReject,
                              )
                            : rideState == RideState.ARRIVED
                                ? RideFloatingPanel(
                                    rideState: rideState,
                                    loading: loading,
                                    passenger: passenger,
                                    trip: trip,
                                    onPressedAccept: arrivedOnPressedAccept,
                                    onPressedReject: arrivedOnPressedReject,
                                  )
                                : rideState == RideState.PICKED
                                    ? RideFloatingPanel(
                                        rideState: rideState,
                                        loading: loading,
                                        passenger: passenger,
                                        trip: trip,
                                        onPressedAccept: pickedOnPressedAccept,
                                        onPressedReject: pickedOnPressedReject,
                                      )
                                    : Container(),
                    collapsed: _floatingCollapsed(rideState, rideRequest),
                    backdropColor: Colors.transparent,
                    defaultPanelState: PanelState.OPEN,
                    maxHeight: rideState == RideState.ACCEPTED ||
                            rideState == RideState.ARRIVED ||
                            rideState == RideState.PICKED
                        ? 320
                        : 360,
                  )
                : Container(),
            rideState == RideState.DROPPED
                ? TripCompleted(
                    loading: loading,
                    onPressed: tripCompletedOnPressed,
                  )
                : rideState == RideState.RATEANDCOMMENT
                    ? RateAndComment(
                        loading: loading,
                        onPressed: rateAndCommentOnPressed,
                        rating: rating,
                        onRatingChanged1: () {
                          setState(() {
                            rating = 1;
                          });
                        },
                        onRatingChanged2: () {
                          setState(() {
                            rating = 2;
                          });
                        },
                        onRatingChanged3: () {
                          setState(() {
                            rating = 3;
                          });
                        },
                        onRatingChanged4: () {
                          setState(() {
                            rating = 4;
                          });
                        },
                        onRatingChanged5: () {
                          setState(() {
                            rating = 5;
                          });
                        },
                        comment: comment,
                      )
                    : Container(),
            Align(
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: SecondaryButtonWithIcon(
                      loading: goingOnline,
                      icon: Get.find<UserController>().driver.value.status ==
                              DriverState.ONLINE
                          ? Icons.cloud_off_outlined
                          : Icons.online_prediction,
                      iconColor: primaryColorWhite,
                      onPressed: goOnlineButton,
                      text: Get.find<UserController>().driver.value.status ==
                              DriverState.ONLINE
                          ? "Go Offline"
                          : "Go Online",
                      boxColor: primaryColorDark,
                      shadowColor: primaryColorDark,
                      width: width,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: SecondaryButtonWithIcon(
                      icon: Icons.online_prediction,
                      iconColor: primaryColorWhite,
                      onPressed: () {
                        setState(() {
                          rideRequest = RideRequestState.PENDING;
                        });
                      },
                      text: "get ride",
                      boxColor: primaryColorDark,
                      shadowColor: primaryColorDark,
                      width: width,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
