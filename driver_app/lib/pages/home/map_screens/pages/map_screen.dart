import 'dart:async';
import 'dart:convert';

import 'package:driver_app/controllers/map_controller.dart';
import 'package:driver_app/controllers/ride_controller.dart';
import 'package:driver_app/controllers/user_controller.dart';
import 'package:driver_app/modals/passenger.dart';
import 'package:driver_app/modals/trip.dart';
import 'package:driver_app/utils/driver_status.dart';
import 'package:driver_app/utils/firebase_notification_handler.dart';
import 'package:driver_app/utils/payment_method.dart';
import 'package:driver_app/utils/ride_request_state_enum.dart';
import 'package:driver_app/widgets/circular_loading.dart';
import 'package:geolocator/geolocator.dart';
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

import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';
import 'package:url_launcher/url_launcher.dart';

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
  bool loadingGreen = false;
  bool loadingRed = false;

  // Trip trip = Trip(
  //   pickUp: "Moratuwa, Sri Lanka",
  //   destination: "Panadura, Sri Lanka",
  //   distance: "0.1",
  //   time: "20",
  //   amount: 250,
  //   paymentMethod: PaymentMethod.CASH,
  // );

  //RideState rideState = RideState.NOTRIP;
  //RideRequestState rideRequest = RideRequestState.NOTRIP;

  var stompClient;

  int rating = 1;
  TextEditingController comment = TextEditingController();

  bool goingOnline = false;

  MapController mapController = Get.find<MapController>();
  final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  void initState() {
    super.initState();
  }

  // void onConnect(StompFrame frame) {
  //   var sname =
  //       Get.find<RideController>().ride.value.rideRequest.passenger.phone;
  //   stompClient.subscribe(
  //     destination: "/user/" + sname + "/queue/messages",
  //     callback: (frame) {
  //       var result = json.decode(frame.body!);
  //       print("driver: " + result.toString());
  //     },
  //   );

  // Timer.periodic(Duration(seconds: 10), (_) {
  //   const message = {
  //     "senderPhone": "sname",
  //     "receiverPhone": "rname",
  //     "location": {"x": 1.2222, "y": 2.444},
  //   };
  //   stompClient.send(
  //     destination: '/app/chat',
  //     body: json.encode(message),
  //   );
  // });
  // }
  // }

  Widget _floatingCollapsed() {
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
                  child: Obx(() => Text(
                        Get.find<RideController>()
                                    .ride
                                    .value
                                    .rideRequest
                                    .status ==
                                RideRequestState.PENDING
                            ? "New ride request"
                            : Get.find<RideController>()
                                        .ride
                                        .value
                                        .rideStatus ==
                                    RideState.ACCEPTED
                                ? "Accepted"
                                : Get.find<RideController>()
                                            .ride
                                            .value
                                            .rideStatus ==
                                        RideState.ARRIVED
                                    ? "Arrived"
                                    : Get.find<RideController>()
                                                .ride
                                                .value
                                                .rideStatus ==
                                            RideState.PICKED
                                        ? "On Trip"
                                        : "",
                        style: TextStyle(
                          color: primaryColorWhite,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

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

  void pendingOnPressedToAccept() async {
    if (!loadingGreen) {
      setState(() {
        loadingGreen = true;
      });

      bool result = await Get.find<RideController>().rideRequestAccepting();
      // try {
      //   stompClient = StompClient(
      //       config: StompConfig.SockJS(
      //     url: 'http://ridex.ml/ws',
      //     onConnect: onConnect,
      //     beforeConnect: () async {
      //       print('waiting to connect...');
      //       await Future.delayed(Duration(milliseconds: 200));
      //       print('connecting...');
      //     },
      //     onWebSocketError: (dynamic error) => print(error.toString()),
      //     // stompConnectHeaders: {'Authorization': 'Bearer yourToken'},
      //     // webSocketConnectHeaders: {'Authorization': 'Bearer yourToken'},
      //   ));
      //   stompClient.activate();

      //   Timer.periodic(Duration(seconds: 2), (Timer timer) async {
      //     if (Get.find<RideController>().ride.value.rideStatus ==
      //             RideState.DROPPED ||
      //         Get.find<RideController>().ride.value.rideStatus ==
      //             RideState.FINISHED ||
      //         Get.find<RideController>().ride.value.rideStatus ==
      //             RideState.NOTRIP) {
      //       timer.cancel();
      //     } else {
      //       debugPrint("safa");
      //       Position position = await Geolocator.getCurrentPosition(
      //           desiredAccuracy: LocationAccuracy.high);

      //       var message = {
      //         "senderPhone": Get.find<UserController>().driver.value.phone,
      //         "receiverPhone": Get.find<RideController>()
      //             .ride
      //             .value
      //             .rideRequest
      //             .passenger
      //             .phone,
      //         "location": {"x": position.latitude, "y": position.longitude},
      //       };
      //       stompClient.send(
      //         destination: '/app/chat',
      //         body: json.encode(message),
      //       );
      //     }
      //   });
      // } catch (e) {
      //   debugPrint(e.toString());
      // }
      // stompClient.activate();

      setState(() {
        loadingGreen = false;
      });
    }
  }

  void pendingOnPressedToReject() {
    if (!loadingRed) {
      setState(() {
        loadingRed = true;
      });

      Get.find<RideController>().cancelRide();

      setState(() {
        loadingRed = false;
      });
    }
  }

  void acceptedOnPressedToArrive() async {
    if (!loadingGreen) {
      setState(() {
        loadingGreen = true;
      });
      bool result = await Get.find<RideController>().rideArriving();

      setState(() {
        loadingGreen = false;
      });
    }
  }

  void acceptedOnPressedToCancel() {
    if (!loadingRed) {
      setState(() {
        loadingRed = true;
      });
      //TODO
      Get.find<RideController>().cancelRide();

      setState(() {
        loadingRed = false;
      });
    }
  }

  void arrivedOnPressedToPicked() async {
    if (!loadingGreen) {
      setState(() {
        loadingGreen = true;
      });
      bool result = await Get.find<RideController>().ridePicked();

      setState(() {
        loadingGreen = false;
      });
    }
  }

  void arrivedOnPressedToCancel() {
    if (!loadingRed) {
      setState(() {
        loadingRed = true;
      });
      //TODO
      Get.find<RideController>().cancelRide();

      setState(() {
        loadingRed = false;
      });
    }
  }

  void pickedOnPressedToDropped() async {
    if (!loadingGreen) {
      setState(() {
        loadingGreen = true;
      });
      bool result = await Get.find<RideController>().rideDropped();

      setState(() {
        loadingGreen = false;
      });
    }
  }

  void pickedOnPressedToCancel() {
    if (!loadingRed) {
      setState(() {
        loadingRed = true;
      });
      //TODO
      Get.find<RideController>().cancelRide();

      setState(() {
        loadingRed = false;
      });
    }
  }

  void tripCompletedOnPressed() async {
    if (!loadingGreen) {
      setState(() {
        loadingGreen = true;
      });
      bool result = await Get.find<RideController>().doPayment();

      setState(() {
        loadingGreen = false;
      });
    }
  }

  void rateAndCommentOnPressed() async {
    if (!loadingGreen) {
      setState(() {
        loadingGreen = true;
      });
      bool result = await Get.find<RideController>().rideFinished(
        driverFeedback: comment.text,
        passengerRating: rating,
        waitingTime: 5,
      );

      setState(() {
        loadingGreen = false;
        comment.text = "";
        rating = 1;
      });
    }
  }

  void rateAndCommentOnCancel() async {
    if (!loadingRed) {
      setState(() {
        loadingRed = true;
      });
      bool result = await Get.find<RideController>().rideFinished(
        driverFeedback: "",
        passengerRating: 0,
        waitingTime: 5,
      );

      setState(() {
        loadingRed = false;
      });
    }
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
                  child: Obx(() => GoogleMap(
                        mapType: MapType.normal,
                        initialCameraPosition: _kGooglePlex,
                        myLocationButtonEnabled: true,
                        myLocationEnabled: true,
                        zoomGesturesEnabled: true,
                        zoomControlsEnabled: true,
                        onMapCreated: (GoogleMapController controller) {
                          Completer<GoogleMapController> _controllerGoogleMap =
                              Completer();
                          _controllerGoogleMap.complete(controller);
                          mapController.newGoogleMapController = controller;
                          mapController.locatePosition();
                        },
                        polylines: mapController.polyLineSet.value,
                        markers: mapController.markersSet.value,
                        circles: mapController.circlesSet.value,
                      )),
                ),
              ],
            ),
            Obx(() => Get.find<RideController>()
                            .ride
                            .value
                            .rideRequest
                            .status ==
                        RideRequestState.PENDING ||
                    Get.find<RideController>().ride.value.rideStatus ==
                        RideState.ACCEPTED ||
                    Get.find<RideController>().ride.value.rideStatus ==
                        RideState.ARRIVED ||
                    Get.find<RideController>().ride.value.rideStatus ==
                        RideState.PICKED
                ? SlidingUpPanel(
                    renderPanelSheet: false,
                    panel: Get.find<RideController>()
                                .ride
                                .value
                                .rideRequest
                                .status ==
                            RideRequestState.PENDING
                        ? RideRequestFloatingPanel(
                            greenTopic: "Accept",
                            loadingGreen: loadingGreen,
                            redTopic: "Reject",
                            loadingRed: loadingRed,
                            passenger: Get.find<RideController>()
                                .ride
                                .value
                                .rideRequest
                                .passenger,
                            trip: Get.find<RideController>().trip.value,
                            onPressedAccept: pendingOnPressedToAccept,
                            onPressedReject: pendingOnPressedToReject,
                          )
                        : Get.find<RideController>().ride.value.rideStatus ==
                                RideState.ACCEPTED
                            ? RideFloatingPanel(
                                heading: "Accepted",
                                rideState: Get.find<RideController>()
                                    .ride
                                    .value
                                    .rideStatus,
                                greenTopic: "Arrived",
                                loadingGreen: loadingGreen,
                                redTopic: "Cancel",
                                loadingRed: loadingRed,
                                passenger: Get.find<RideController>()
                                    .ride
                                    .value
                                    .rideRequest
                                    .passenger,
                                trip: Get.find<RideController>().trip.value,
                                onPressedAccept: acceptedOnPressedToArrive,
                                onPressedReject: acceptedOnPressedToCancel,
                              )
                            : Get.find<RideController>()
                                        .ride
                                        .value
                                        .rideStatus ==
                                    RideState.ARRIVED
                                ? RideFloatingPanel(
                                    heading: "Arrived",
                                    rideState: Get.find<RideController>()
                                        .ride
                                        .value
                                        .rideStatus,
                                    greenTopic: "Picked",
                                    loadingGreen: loadingGreen,
                                    redTopic: "Cancel",
                                    loadingRed: loadingRed,
                                    passenger: Get.find<RideController>()
                                        .ride
                                        .value
                                        .rideRequest
                                        .passenger,
                                    trip: Get.find<RideController>().trip.value,
                                    onPressedAccept: arrivedOnPressedToPicked,
                                    onPressedReject: arrivedOnPressedToCancel,
                                  )
                                : Get.find<RideController>()
                                            .ride
                                            .value
                                            .rideStatus ==
                                        RideState.PICKED
                                    ? RideFloatingPanel(
                                        heading: "Picked",
                                        rideState: Get.find<RideController>()
                                            .ride
                                            .value
                                            .rideStatus,
                                        greenTopic: "Dropped",
                                        loadingGreen: loadingGreen,
                                        redTopic: "Cancel",
                                        loadingRed: loadingRed,
                                        passenger: Get.find<RideController>()
                                            .ride
                                            .value
                                            .rideRequest
                                            .passenger,
                                        trip: Get.find<RideController>()
                                            .trip
                                            .value,
                                        onPressedAccept:
                                            pickedOnPressedToDropped,
                                        onPressedReject:
                                            pickedOnPressedToCancel,
                                      )
                                    : Container(),
                    collapsed: _floatingCollapsed(),
                    backdropColor: Colors.transparent,
                    defaultPanelState: PanelState.OPEN,
                    maxHeight: Get.find<RideController>()
                                    .ride
                                    .value
                                    .rideStatus ==
                                RideState.ACCEPTED ||
                            Get.find<RideController>().ride.value.rideStatus ==
                                RideState.ARRIVED ||
                            Get.find<RideController>().ride.value.rideStatus ==
                                RideState.PICKED
                        ? 320
                        : 360,
                  )
                : Container()),
            Obx(() => Get.find<RideController>().ride.value.rideStatus ==
                    RideState.DROPPED
                ? TripCompleted(
                    loading: loadingGreen,
                    onPressed: tripCompletedOnPressed,
                    trip: Get.find<RideController>().trip.value,
                    payment: Get.find<RideController>().ride.value.payment,
                  )
                : Get.find<RideController>().ride.value.rideStatus ==
                        RideState.RATEANDCOMMENT
                    ? RateAndComment(
                        greenTopic: "Submit",
                        loadingGreen: loadingGreen,
                        redTopic: "Cancel",
                        loadingRed: loadingRed,
                        onPressed: rateAndCommentOnPressed,
                        onCancel: rateAndCommentOnCancel,
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
                    : Container()),
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
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 10),
                  //   child: SecondaryButtonWithIcon(
                  //     icon: Icons.online_prediction,
                  //     iconColor: primaryColorWhite,
                  //     onPressed: () async {
                  //       debugPrint("ASfsa");

                  //       debugPrint(mapController.directionDetails.value
                  //           .toJson()
                  //           .toString());

                  //       Timer.periodic(Duration(seconds: 5),
                  //           (Timer timer) async {
                  //         debugPrint("asd");
                  //         timer.cancel();
                  //         await mapController.getLiveLocation();
                  //         const timeout = Duration(seconds: 60);
                  //         if (timeout == Duration(seconds: 11)) {
                  //           mapController.markersSet.value.removeWhere(
                  //               (maker) => maker.markerId.value == "animating");

                  //           mapController.markersSet.refresh();
                  //           setState(() {});
                  //           timer.cancel();
                  //         }
                  //       });
                  //       // mapController.markersSet.value.removeWhere(
                  //       //     (maker) => maker.markerId.value == "animating");

                  //       // mapController.markersSet.refresh();
                  //     },
                  //     text: "get ride",
                  //     boxColor: primaryColorDark,
                  //     shadowColor: primaryColorDark,
                  //     width: width,
                  //   ),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 10),
                  //   child: SecondaryButtonWithIcon(
                  //     icon: Icons.online_prediction,
                  //     iconColor: primaryColorWhite,
                  //     onPressed: () {
                  //       debugPrint("safa");
                  //       Timer.periodic(Duration(seconds: 2), (Timer timer) {
                  //         debugPrint("safa");
                  //         const message = {
                  //           "senderPhone": "+94763067706",
                  //           "receiverPhone": "+94714862398",
                  //           "location": {"x": 1.2222, "y": 2.444},
                  //         };
                  //         stompClient.send(
                  //           destination: '/app/chat',
                  //           body: json.encode(message),
                  //         );
                  //         if (timer == Duration(seconds: 10)) {
                  //           timer.cancel();
                  //         }
                  //       });
                  //     },
                  //     text: "send message",
                  //     boxColor: primaryColorDark,
                  //     shadowColor: primaryColorDark,
                  //     width: width,
                  //   ),
                  // ),
                ],
              ),
            ),
            Obx(
              () => mapController.polyLineLoading.value
                  ? Container(
                      color: primaryColorBlack.withOpacity(0.5),
                      child: Center(child: CircularLoading()),
                    )
                  : Container(),
            ),
          ],
        ),
      ),
    );
  }
}
