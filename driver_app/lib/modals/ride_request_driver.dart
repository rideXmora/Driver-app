// Driver OneServiceFromJson(String str) =>
//     Driver.fromJson(json.decode(str));

// String OneServiceToJson(OneService data) => json.encode(data.toJson());

import 'package:driver_app/modals/ride_request_vehicle.dart';

class RideRequestDriver {
  RideRequestDriver({
    this.id = "",
    this.phone = "",
    this.name = "",
    required this.vehicle,
    this.rating = 0,
  });

  String id;
  String phone;

  String name;

  RideRequestVehicle vehicle;
  double rating;

  factory RideRequestDriver.fromJson(Map<dynamic, dynamic> json) =>
      RideRequestDriver(
        id: json["id"],
        phone: json["phone"],
        name: json["name"],
        vehicle: json["vehicle"] == null
            ? RideRequestVehicle()
            : RideRequestVehicle.fromJson(json["vehicle"]),
        rating: json["rating"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "phone": phone,
        "name": name,
        "vehicle": vehicle.toJson(),
        "rating": rating,
      };
}
