import 'package:driver_app/api/driver_ride_api.dart';
import 'package:driver_app/controllers/user_controller.dart';
import 'package:driver_app/modals/location.dart';
import 'package:driver_app/modals/organization.dart';
import 'package:driver_app/modals/ride.dart';
import 'package:driver_app/modals/ride_request_driver.dart';
import 'package:driver_app/modals/ride_request_passenger.dart';
import 'package:driver_app/modals/ride_request_res.dart';
import 'package:driver_app/modals/ride_request_vehicle.dart';
import 'package:driver_app/modals/vehicle.dart';
import 'package:driver_app/utils/driver_status.dart';
import 'package:driver_app/utils/ride_request_state_enum.dart';
import 'package:driver_app/utils/ride_state_enum.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RideController extends GetxController {
  UserController userController = Get.find<UserController>();
  var ride = Ride(
    rideStatus: RideState.NOTRIP,
    rideRequest: RideRequestRes(
      status: RideRequestState.NOTRIP,
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

  void cancelRide() {
    ride.value = Ride(
      id: "",
      rideStatus: RideState.NOTRIP,
      rideRequest: RideRequestRes(
        status: RideRequestState.NOTRIP,
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
    );
  }

  Future<void> getRideRequest(
    String id,
    String passengerName,
    String passengerPhone,
    String startLocationX,
    String startLocationY,
    String passengerRating,
  ) async {
    try {
      //hardcoded ride requsest id
      debugPrint("ride request id: " + id);
      ride.update((val) {
        val!.id = "";
        val.rideStatus = RideState.NOTRIP;
        val.rideRequest = RideRequestRes(
          id: id,
          status: RideRequestState.PENDING,
          passenger: RideRequestPassenger(
            id: "",
            name: passengerName,
            phone: passengerPhone,
            rating: double.parse(passengerRating),
          ),
          startLocation: Location(
            x: double.parse(startLocationX),
            y: double.parse(startLocationY),
          ),
          endLocation: Location(
            x: 20,
            y: 20,
          ),
          driver: RideRequestDriver(
            id: Get.find<UserController>().driver.value.id,
            name: Get.find<UserController>().driver.value.name,
            phone: Get.find<UserController>().driver.value.phone,
            rating:
                Get.find<UserController>().driver.value.totalRating.toDouble(),
            vehicle: RideRequestVehicle(),
          ),
          organization: Organization(),
          timestamp: DateTime.now(),
          distance: 100,
        );
      });
      debugPrint("ride : " + ride.value.toJson().toString());
    } catch (e) {
      Get.snackbar("Something is wrong!!!", "Please try again.");
    }
  }

  Future<bool> rideRequestAccepting() async {
    try {
      //hardcoded ride requsest id
      dynamic response = await accept(
        id: ride.value.rideRequest.id,
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

      dynamic response = await arrived(
        id: ride.value.id,
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

      dynamic response = await picked(
        id: ride.value.id,
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

      dynamic response = await dropped(
        id: ride.value.id,
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
      Get.find<RideController>().ride.value.rideStatus =
          RideState.RATEANDCOMMENT;
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

      dynamic response = await finished(
        id: ride.value.id,
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
          Get.find<RideController>().cancelRide();
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
