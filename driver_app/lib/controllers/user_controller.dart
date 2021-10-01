import 'package:driver_app/modals/driver.dart';
import 'package:driver_app/modals/vehicle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  var passenger = Driver(vehicle: Vehicle()).obs;

  void saveDriverData(dynamic data) {
    passenger.update((val) {
      val!.id = data["id"];
      val.phone = data["phone"];
      val.email = data["email"] == null ? "" : data["email"];
      val.name = data["name"] == null ? "" : data["email"];
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
}
