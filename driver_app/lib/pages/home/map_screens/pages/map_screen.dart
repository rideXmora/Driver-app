import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:driver_app/modals/driver.dart';
import 'package:driver_app/pages/home/map_screens/widgets/floating_panel/finding_ride_floating_panel.dart';
import 'package:driver_app/pages/home/map_screens/widgets/floating_panel/ride_floating_panel.dart';
import 'package:driver_app/pages/home/map_screens/widgets/floating_panel/select_vechicle_type_floating_panel.dart';
import 'package:driver_app/pages/home/map_screens/widgets/pop_up/Rate_and_comment.dart';
import 'package:driver_app/pages/home/map_screens/widgets/pop_up/trip_completed.dart';
import 'package:driver_app/utils/trip_state_enum.dart';
import 'package:driver_app/theme/colors.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class MapScreen extends StatefulWidget {
  MapScreen({
    Key? key,
    required this.onBack,
  }) : super(key: key);
  final onBack;
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
  TextEditingController paymentMethod = TextEditingController();
  int slectedMethod = 0;
  List<Map<String, dynamic>> methods = [
    {
      "Icon": Icons.money,
      "method": "Cash Payment",
      "index": 0,
    },
    {
      "Icon": Icons.credit_card,
      "method": "Card Payment",
      "index": 1,
    }
  ];

  Driver driver = Driver(
    image: "a",
    name: "Avishka Rathnavibushana",
    number: "+94711737706",
    vechicleType: "Toyota Corolla",
  );

  TripState tripState = TripState.SELECTVECHICLE;

  int rating = 1;
  TextEditingController comment = TextEditingController();

  @override
  void initState() {
    super.initState();
    setState(() {
      paymentMethod.text = methods[0]["method"];
      slectedMethod = 0;
    });
  }

  Widget _floatingCollapsed(TripState state) {
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
                    state == TripState.SELECTVECHICLE
                        ? "Confirm ride"
                        : state == TripState.FINDINGRIDE
                            ? "Finding ride"
                            : state == TripState.DRIVERCOMMING
                                ? "Driver is comming"
                                : state == TripState.GOINGTODESTINATION
                                    ? "Going to destination"
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

  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;
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
        centerTitle: true,
        leading: GestureDetector(
          onTap: widget.onBack,
          child: Icon(
            Icons.keyboard_arrow_left_sharp,
            size: 30,
          ),
        ),
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
            tripState == TripState.SELECTVECHICLE ||
                    tripState == TripState.FINDINGRIDE ||
                    tripState == TripState.DRIVERCOMMING ||
                    tripState == TripState.GOINGTODESTINATION
                ? SlidingUpPanel(
                    renderPanelSheet: false,
                    panel: tripState == TripState.SELECTVECHICLE
                        ? SelectVechicleTypeFloatingPanel(
                            paymentMethod: paymentMethod,
                            methods: methods,
                            slectedMethod: slectedMethod,
                            loading: loading,
                            onSelect: (String value) {
                              setState(() {
                                slectedMethod =
                                    methods[int.parse(value)]["index"];
                              });
                            },
                            onPressed: () {
                              setState(() {
                                tripState = TripState.FINDINGRIDE;
                              });
                            },
                          )
                        : tripState == TripState.FINDINGRIDE
                            ? FindingRideFloatingPanel(
                                loading: loading,
                                onPressed: () {
                                  setState(() {
                                    tripState = TripState.DRIVERCOMMING;
                                  });
                                },
                              )
                            : tripState == TripState.DRIVERCOMMING
                                ? RideFloatingPanel(
                                    driver: driver,
                                    time: "1 min",
                                    tripState: tripState,
                                    loading: loading,
                                    onPressed: () {
                                      setState(() {
                                        tripState =
                                            TripState.GOINGTODESTINATION;
                                      });
                                    },
                                  )
                                : tripState == TripState.GOINGTODESTINATION
                                    ? RideFloatingPanel(
                                        driver: driver,
                                        time: "1 min",
                                        tripState: tripState,
                                        loading: loading,
                                        onPressed: () {
                                          setState(() {
                                            tripState = TripState.TRIPCOMPLETED;
                                          });
                                        },
                                      )
                                    : Container(),
                    collapsed: _floatingCollapsed(tripState),
                    backdropColor: Colors.transparent,
                    defaultPanelState: PanelState.OPEN,
                    maxHeight: tripState == TripState.DRIVERCOMMING ||
                            tripState == TripState.GOINGTODESTINATION
                        ? 270
                        : 360,
                  )
                : Container(),
            tripState == TripState.TRIPCOMPLETED
                ? TripCompleted(
                    loading: loading,
                    onPressed: () {
                      setState(() {
                        tripState = TripState.RATEANDCOMMENT;
                      });
                    },
                  )
                : tripState == TripState.RATEANDCOMMENT
                    ? RateAndComment(
                        loading: loading,
                        onPressed: () {
                          setState(() {
                            tripState = TripState.NOTRIP;
                            rating = 0;
                            comment.text = "";
                          });
                        },
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
          ],
        ),
      ),
    );
  }
}
