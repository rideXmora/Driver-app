import 'package:driver_app/modals/location.dart';
import 'package:driver_app/modals/organization.dart';
import 'package:driver_app/modals/ride_request_driver.dart';
import 'package:driver_app/modals/ride_request_passenger.dart';
import 'package:driver_app/modals/ride_request_res.dart';
import 'package:driver_app/modals/ride_request_vehicle.dart';
import 'package:driver_app/utils/ride_request_state_enum.dart';
import 'package:driver_app/utils/ride_state_enum.dart';
import 'package:driver_app/utils/vehicle_type.dart';

class Ride {
  Ride({
    this.id = "",
    required this.rideRequest,
    this.driverFeedBack = "",
    this.passengerFeedback = "",
    this.driverRating = 0,
    this.passengerRating = 0,
    this.payment = 0,
    this.rideStatus = RideState.NOTRIP,
  });

  String id;
  RideRequestRes rideRequest;
  String driverFeedBack;
  String passengerFeedback;
  int driverRating;
  int passengerRating;
  double payment;
  RideState rideStatus;

  factory Ride.fromJson(Map<dynamic, dynamic> json) => Ride(
        id: json["id"],
        rideRequest: RideRequestRes.fromJson(json["rideRequest"]),
        driverFeedBack: json["driverFeedBack"],
        passengerFeedback: json["passengerFeedback"],
        driverRating: json["driverRating"],
        passengerRating: json["passengerRating"],
        payment: json["payment"],
        rideStatus: getRideState(json["rideStatus"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "rideRequest": rideRequest.toJson(),
        "driverFeedBack": driverFeedBack,
        "passengerFeedback": passengerFeedback,
        "driverRating": driverRating,
        "passengerRating": passengerRating,
        "payment": payment,
        "rideStatus": rideStatus,
      };
}
