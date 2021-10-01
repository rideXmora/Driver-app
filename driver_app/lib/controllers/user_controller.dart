import 'package:driver_app/modals/driver.dart';
import 'package:driver_app/modals/organization.dart';
import 'package:driver_app/modals/vehicle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  var driver =
      Driver(vehicle: Vehicle(), driverOrganization: Organization()).obs;

  void saveDriverData(dynamic data) {
    driver.update((val) {
      val!.id = data["id"];
      val.phone = data["phone"];
      val.email = data["email"] == null ? "" : data["email"];
      val.name = data["name"] == null ? "" : data["name"];
      val.totalRating = data["totalRating"];
      val.totalRides = data["totalRides"];
      val.pastRides = List<String>.from(data["pastRides"]);
      val.token = data["token"];
      val.refreshToken = data["refreshToken"];
      val.enabled = data["enabled"];
      val.suspend = data["suspend"] == null ? false : data["suspend"];
      val.vehicle = data["vehicle"] == null
          ? Vehicle()
          : Vehicle.fromJson(data["vehicle"]);
    });
  }

  void updateDriverData(
    dynamic data,
    String token,
    String refreshToken,
  ) {
    driver.update((val) {
      val!.id = data["id"];
      val.phone = data["phone"];
      val.email = data["email"] == null ? "" : data["email"];
      val.name = data["name"] == null ? "" : data["name"];

      val.totalRating = data["totalRating"];
      val.totalRides = data["totalRides"];
      val.pastRides = List<String>.from(data["pastRides"]);
      val.token = token;
      val.refreshToken = refreshToken;
      val.enabled = data["enabled"];
      val.suspend = data["suspend"] == null ? false : data["suspend"];
      val.vehicle = data["vehicle"] == null
          ? Vehicle()
          : Vehicle.fromJson(data["vehicle"]);
      val.city = data["city"] == null ? "" : data["city"];
      val.drivingLicense =
          data["drivingLicense"] == null ? "" : data["drivingLicense"];
      val.totalIncome = data["totalIncome"];
      val.sessionIncome = data["sessionIncome"];
      val.driverOrganization = data["driverOrganization"] == null
          ? Organization()
          : Organization.fromJson(data["driverOrganization"]);
    });
  }
}
