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
      //hardcoded ride requsest id
      String id = "6174cf2b3311565ebc8b37f2";
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
        if (getRideState(response["body"]["rideStatus"]) ==
            RideState.ACCEPTED) {
          return true;
        } else {
          Get.snackbar("Something is wrong!!!", "Please try again.");
          return false;
        }
      } else {
        Get.snackbar("Something is wrong!!!", "Please try again.");
        return false;
      }
    } catch (e) {
      Get.snackbar("Something is wrong!!!", "Please try again.");
      return false;
    }
  }

  Future<bool> rideArriving() async {
    try {
      //hardcoded id
      String id = "61738b977ccb6600387733dc";
      dynamic response = await arrived(
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
        if (getRideState(response["body"]["rideStatus"]) == RideState.ARRIVED) {
          return true;
        } else {
          Get.snackbar("Something is wrong!!!", "Please try again.");
          return false;
        }
      } else {
        Get.snackbar("Something is wrong!!!", "Please try again.");
        return false;
      }
    } catch (e) {
      Get.snackbar("Something is wrong!!!", "Please try again.");
      return false;
    }
  }

  Future<bool> ridePicked() async {
    try {
      //hardcoded id
      String id = "61738b977ccb6600387733dc";
      dynamic response = await picked(
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
        if (getRideState(response["body"]["rideStatus"]) == RideState.PICKED) {
          return true;
        } else {
          Get.snackbar("Something is wrong!!!", "Please try again.");
          return false;
        }
      } else {
        Get.snackbar("Something is wrong!!!", "Please try again.");
        return false;
      }
    } catch (e) {
      Get.snackbar("Something is wrong!!!", "Please try again.");
      return false;
    }
  }

  Future<bool> rideDropped() async {
    try {
      //hardcoded id
      String id = "61738b977ccb6600387733dc";
      dynamic response = await dropped(
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
        if (getRideState(response["body"]["rideStatus"]) == RideState.DROPPED) {
          return true;
        } else {
          Get.snackbar("Something is wrong!!!", "Please try again.");
          return false;
        }
      } else {
        Get.snackbar("Something is wrong!!!", "Please try again.");
        return false;
      }
    } catch (e) {
      Get.snackbar("Something is wrong!!!", "Please try again.");
      return false;
    }
  }

  Future<bool> doPayment() async {
    try {
      return true;
    } catch (e) {
      return true;
    }
  }

  Future<bool> rideFinished({
    required passengerRating,
    required driverFeedback,
    required waitingTime,
  }) async {
    try {
      //hardcoded id
      String id = "61738b977ccb6600387733dc";
      dynamic response = await finished(
        id: id,
        passengerRating: passengerRating,
        driverFeedback: driverFeedback,
        waitingTime: waitingTime,
        token: Get.find<UserController>().driver.value.token,
      );

      if (!response["error"]) {
        updateRide(
          response["body"],
        );
        debugPrint("ride : " + ride.value.toJson().toString());

        debugPrint(
            "ride - request : " + ride.value.rideRequest.toJson().toString());
        if (getRideState(response["body"]["rideStatus"]) ==
            RideState.FINISHED) {
          return true;
        } else {
          Get.snackbar("Something is wrong!!!", "Please try again.");
          return false;
        }
      } else {
        Get.snackbar("Something is wrong!!!", "Please try again.");
        return false;
      }
    } catch (e) {
      Get.snackbar("Something is wrong!!!", "Please try again.");
      return false;
    }
  }
}
