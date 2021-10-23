// Driver OneServiceFromJson(String str) =>
//     Driver.fromJson(json.decode(str));

// String OneServiceToJson(OneService data) => json.encode(data.toJson());

import 'package:driver_app/modals/ride_request_vehicle.dart';

class RideRequestPassenger {
  RideRequestPassenger({
    this.id = "",
    this.phone = "",
    this.name = "",
    this.rating = 0,
  });

  String id;
  String phone;
  String name;
  double rating;

  factory RideRequestPassenger.fromJson(Map<dynamic, dynamic> json) =>
      RideRequestPassenger(
        id: json["id"],
        phone: json["phone"],
        name: json["name"],
        rating: json["rating"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "phone": phone,
        "name": name,
        "rating": rating,
      };
}
