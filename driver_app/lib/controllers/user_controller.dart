import 'package:driver_app/modals/driver.dart';
import 'package:driver_app/modals/organization.dart';
import 'package:driver_app/modals/vehicle.dart';
import 'package:driver_app/pages/sign_in_up/pages/registration/documentation_screen.dart';
import 'package:driver_app/pages/sign_in_up/pages/registration/waiting_screen.dart';
import 'package:driver_app/utils/driver_status.dart';
import 'package:driver_app/utils/vehicle_type.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  var driver =
      Driver(vehicle: Vehicle(), driverOrganization: Organization()).obs;

  void clearData() {
    driver.update((val) {
      val!.id = "";
      val.phone = "";
      val.email = "";
      val.name = "";
      val.totalRating = 0;
      val.totalRides = 0;
      val.pastRides = [];
      val.token = "";
      val.refreshToken = "";
      val.enabled = false;
      val.suspend = false;
      val.vehicle = Vehicle();
      val.city = "";
      val.drivingLicense = "";
      val.totalIncome = 0;
      val.sessionIncome = 0;
      val.driverOrganization = Organization();
      val.status = DriverState.OFFLINE;
      val.notificationToken = "";
    });
  }

  void signOutUser() {
    clearData();
  }

  void saveDriverData(dynamic data) {
    DriverState driverState = getDriverState(
        data["status"] == null ? DriverState.OFFLINE : data["status"]);
    driver.update((val) {
      val!.id = data["id"];
      val.phone = data["phone"];
      val.email = data["email"] == null ? "" : data["email"];
      val.name = data["name"] == null ? "" : data["name"];
      val.totalRating = data["totalRating"];
      val.totalRides = data["totalRides"];
      val.pastRides =
          data["pastRides"] == null ? [] : List<String>.from(data["pastRides"]);
      val.token = data["token"];
      val.refreshToken = data["refreshToken"];
      val.enabled = data["enabled"] == null ? false : data["enabled"];
      val.suspend = data["suspend"] == null ? false : data["suspend"];
      val.vehicle = data["vehicle"] == null
          ? Vehicle()
          : Vehicle.fromJson(data["vehicle"]);
      val.driverOrganization = data["driverOrganization"] == null
          ? Organization()
          : Organization.fromJson(data["driverOrganization"]);
      val.status = driverState;
      val.notificationToken =
          data["notificationToken"] == null ? "" : data["notificationToken"];
    });
  }

//change
  void updateDriverData(
    dynamic data,
    String token,
    String refreshToken,
  ) {
    DriverState driverState = getDriverState(
        data["status"] == null ? DriverState.OFFLINE : data["status"]);
    driver.update((val) {
      val!.id = data["id"];
      val.phone = data["phone"];
      val.email = data["email"] == null ? "" : data["email"];
      val.name = data["name"] == null ? "" : data["name"];

      val.totalRating = data["totalRating"];
      val.totalRides = data["totalRides"];
      val.pastRides =
          data["pastRides"] == null ? [] : List<String>.from(data["pastRides"]);
      val.token = token;
      val.refreshToken = refreshToken;
      val.enabled = data["enabled"] == null ? false : data["enabled"];
      val.suspend = data["suspend"] == null ? false : data["suspend"];
      val.vehicle = data["vehicle"] == null
          ? Vehicle()
          : Vehicle.fromJson(data["vehicle"]);
      val.city = data["city"] == null ? "" : data["city"];
      val.drivingLicense =
          data["drivingLicense"] == null ? "" : data["drivingLicense"];
      val.totalIncome = data["totalIncome"] == null ? 0 : data["totalIncome"];
      val.sessionIncome =
          data["sessionIncome"] == null ? 0 : data["sessionIncome"];
      val.driverOrganization = data["driverOrganization"] == null
          ? Organization()
          : Organization.fromJson(data["driverOrganization"]);

      val.status = driverState;
      val.notificationToken =
          data["notificationToken"] == null ? "" : data["notificationToken"];
    });
  }

  void updateDriverVehicleData(
    dynamic data,
    String token,
    String refreshToken,
    Vehicle vehicle,
  ) {
    driver.update((val) {
      val!.vehicle = vehicle;
    });
  }

  void addVehicleInfo(Vehicle vehicle, String from) {
    if (vehicle.number.isEmpty) {
      Get.snackbar("Vehicle number is not valid!!!",
          "Vehicle number field cannot be empty");
    } else if (vehicle.model.isEmpty) {
      Get.snackbar("Vehicle model is not valid!!!",
          "Vehicle model field cannot be empty");
    } else {
      driver.update((val) {
        val!.vehicle = vehicle;
      });
      if (from == "type screen") {
        Get.to(() => DocumentationScreen());
      }
    }
  }

  void updateNotificationToken(String token) {
    driver.value.notificationToken = token;
  }
}
