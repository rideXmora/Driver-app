import 'package:driver_app/modals/location.dart';
import 'package:driver_app/utils/card_type_enum.dart';

class PlaceDetails {
  String home;
  String street;
  String city;
  String district;
  String province;
  String country;
  Location location;
  String placeId;
  String completeAddress;

  PlaceDetails({
    required this.home,
    required this.street,
    required this.city,
    required this.district,
    required this.province,
    required this.country,
    required this.placeId,
    required this.location,
    required this.completeAddress,
  });

  factory PlaceDetails.fromJson(Map<dynamic, dynamic> json) => PlaceDetails(
        home: json["home"],
        street: json["street"],
        city: json["city"],
        district: json["district"],
        province: json["province"],
        country: json["country"],
        placeId: json[""],
        location: Location(
          x: 0,
          y: 0,
        ),
        completeAddress: json["completeAddress"],
      );

  Map<String, dynamic> toJson() => {
        "home": home,
        "street": street,
        "city": city,
        "district": district,
        "province": province,
        "country": country,
        "placeId": placeId,
        "location": location.toJson(),
        "completeAddress": completeAddress,
      };

  String getLocationText() {
    return street + ", " + city;
  }
}
