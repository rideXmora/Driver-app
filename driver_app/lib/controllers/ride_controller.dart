import 'package:driver_app/api/driver_ride_api.dart';
import 'package:driver_app/controllers/user_controller.dart';
import 'package:driver_app/modals/location.dart';
import 'package:driver_app/modals/organization.dart';
import 'package:driver_app/modals/ride.dart';
import 'package:driver_app/modals/ride_request_driver.dart';
import 'package:driver_app/modals/ride_request_passenger.dart';
import 'package:driver_app/modals/ride_request_res.dart';
import 'package:driver_app/modals/ride_request_vehicle.dart';
import 'package:driver_app/utils/driver_status.dart';
import 'package:driver_app/utils/ride_state_enum.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RideController extends GetxController {
  UserController userController = Get.find<UserController>();
  var ride = Ride(
    rideRequest: RideRequestRes(
      passenger: RideRequestPassenger(),
      startLocation: Location(
        x: 0,
        y: 0,
      ),
      endLocation: Location(
        x: 0,
        y: 0,
      ),
      driver: RideRequestDriver(
        vehicle: RideRequestVehicle(),
      ),
      organization: Organization(),
      timestamp: DateTime.now(),
    ),
  ).obs;

  Future<bool> changeDriverRideStatus({
    required double x,
    required double y,
  }) async {
    DriverState state = userController.driver.value.status;
    dynamic response = await toggleStatus(
      x: x,
      y: y,
      token: Get.find<UserController>().driver.value.token,
    );

    if (!response["error"]) {
      if (state == DriverState.OFFLINE) {
        userController.driver.update((val) {
          val!.status = DriverState.ONLINE;
        });
      } else {
        userController.driver.update((val) {
          val!.status = DriverState.OFFLINE;
        });
      }
      return true;
    } else {
      Get.snackbar("Something is wrong!!!", "Please try again");
      return false;
    }
  }

  void updateRide(dynamic response) {
    RideRequestRes rideRequestRes =
        RideRequestRes.fromJson(response["rideRequest"]);
    ride.update((val) {
      val!.id = response["id"];
      val.rideRequest = rideRequestRes;
      val.payment = response["payment"] == null ? 0 : response["payment"];
      val.rideStatus = getRideState(response["rideStatus"]);
    });
  }

  Future<bool> rideRequestAccepting() async {
    try {
      //hardcoded id
      String id = "6172bd4d7ccb6600387733d8";
      dynamic response = await accept(
        id: id,
        token: Get.find<UserController>().driver.value.token,
      );

      if (!response["error"]) {
        updateRide(
          response["body"],
        );
        debugPrint("ride : " + ride.value.toJson().toString());

        debugPrint(
            "ride - request : " + ride.value.rideRequest.toJson().toString());
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
