import 'package:driver_app/utils/vehicle_type.dart';

class RideRequestVehicle {
  RideRequestVehicle({
    this.number = "",
    this.vehicleType = VehicleType.THREE_WHEELER,
    this.model = "",
  });

  String number;
  VehicleType vehicleType;
  String model;

  factory RideRequestVehicle.fromJson(Map<dynamic, dynamic> json) =>
      RideRequestVehicle(
        number: json["number"],
        vehicleType: getDriverVehicleType(json["vehicleType"]),
        model: json["model"],
      );

  Map<String, dynamic> toJson() => {
        "number": number,
        "vehicleType": vehicleType,
        "model": model,
      };
}
