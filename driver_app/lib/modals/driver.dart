// Driver OneServiceFromJson(String str) =>
//     Driver.fromJson(json.decode(str));

// String OneServiceToJson(OneService data) => json.encode(data.toJson());

//chnaged
// image: json["image"],
//       name: json["name"],
//       number: json["number"],
//       rating: json["rating"],
import 'package:driver_app/modals/organization.dart';
import 'package:driver_app/modals/vehicle.dart';
import 'package:driver_app/utils/driver_status.dart';

class Driver {
  Driver({
    this.id = "",
    this.phone = "",
    this.token = "",
    this.refreshToken = "",
    this.email = "",
    this.name = "",
    this.totalRating = 0,
    this.totalRides = 0,
    this.pastRides = const [],
    required this.vehicle,
    this.enabled = false,
    this.suspend = false,
    this.city = "",
    this.drivingLicense = "",
    this.totalIncome = 0,
    this.sessionIncome = 0,
    required this.driverOrganization,
    this.status = DriverState.OFFLINE,
    this.notificationToken = "",
  });

  String id;
  String phone;
  String email;
  String name;
  String city;
  String drivingLicense;
  int totalIncome;
  int sessionIncome;
  int totalRating;
  int totalRides;
  List<String> pastRides;
  String token;
  String refreshToken;
  bool enabled;
  bool suspend;
  Vehicle vehicle;
  Organization driverOrganization;
  DriverState status;
  String notificationToken;

  factory Driver.fromJson(Map<dynamic, dynamic> json) => Driver(
        id: json["id"],
        phone: json["phone"],
        email: json["email"],
        name: json["name"],
        totalRating: json["totalRating"],
        totalRides: json["totalRides"],
        pastRides: json["pastRides"],
        token: json["token"],
        refreshToken: json["refreshToken"],
        enabled: json["enabled"],
        suspend: json["suspend"],
        vehicle: json["vehicle"],
        city: json["city"],
        drivingLicense: json["drivingLicense"],
        totalIncome: json["totalIncome"],
        sessionIncome: json["sessionIncome"],
        driverOrganization: json["driverOrganization"],
        status: json["status"],
        notificationToken: json["notificationToken"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "phone": phone,
        "email": email,
        "name": name,
        "totalRating": totalRating,
        "totalRides": totalRides,
        "pastRides": pastRides,
        "token": token,
        "refreshToken": refreshToken,
        "enabled": enabled,
        "suspend": suspend,
        "vehicle": vehicle,
        "city": city,
        "drivingLicense": drivingLicense,
        "totalIncome": totalIncome,
        "sessionIncome": sessionIncome,
        "driverOrganization": driverOrganization,
        "status": status,
        "notificationToken": notificationToken,
      };
}
