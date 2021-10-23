import 'package:driver_app/modals/location.dart';
import 'package:driver_app/modals/organization.dart';
import 'package:driver_app/modals/ride_request_driver.dart';
import 'package:driver_app/modals/ride_request_passenger.dart';
import 'package:driver_app/modals/ride_request_vehicle.dart';
import 'package:driver_app/utils/ride_request_state_enum.dart';
import 'package:driver_app/utils/vehicle_type.dart';

class RideRequestRes {
  RideRequestRes({
    this.id = "",
    required this.passenger,
    required this.startLocation,
    required this.endLocation,
    this.distance = 0,
    this.status = RideRequestState.NOTRIP,
    required this.driver,
    required this.organization,
    required this.timestamp,
  });

  String id;
  RideRequestPassenger passenger;
  Location startLocation;
  Location endLocation;
  int distance;
  RideRequestState status;
  RideRequestDriver driver;
  Organization organization;
  DateTime timestamp;

  factory RideRequestRes.fromJson(Map<dynamic, dynamic> json) => RideRequestRes(
        id: json["id"],
        passenger: json["passenger"] == null
            ? RideRequestPassenger()
            : RideRequestPassenger.fromJson(json["passenger"]),
        startLocation: Location.fromJson(json["startLocation"]),
        endLocation: Location.fromJson(json["endLocation"]),
        distance: json["distance"],
        status: getRideRequestState(json["status"]),
        driver: json["driver"] == null
            ? RideRequestDriver(vehicle: RideRequestVehicle())
            : RideRequestDriver.fromJson(json["driver"]),
        organization: json["organization"] == null
            ? Organization()
            : Organization.fromJson(json["organization"]),
        timestamp:
            DateTime.fromMillisecondsSinceEpoch(json["timestamp"] * 1000),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "passenger": passenger.toJson(),
        "startLocation": startLocation.toJson(),
        "endLocation": endLocation.toJson(),
        "distance": distance,
        "status": status,
        "driver": driver.toJson(),
        "organization": organization.toJson(),
        "timestamp": timestamp,
      };
}
