import 'package:driver_app/modals/location.dart';
import 'package:driver_app/utils/payment_method.dart';

class PastTrip {
  PastTrip({
    required this.startLocation,
    required this.endLocation,
    this.startLocationText = "",
    this.endLocationText = "",
    this.distance = 0,
    this.payment = 0,
    this.paymentMethod = PaymentMethod.CASH,
    this.date = "",
  });

  Location startLocation;
  Location endLocation;
  String startLocationText;
  String endLocationText;
  int distance;
  double payment;
  PaymentMethod paymentMethod;
  String date;

  factory PastTrip.fromJson(Map<dynamic, dynamic> json) => PastTrip(
        startLocation: json["startLocation"],
        endLocation: json["endLocation"],
        startLocationText: json["startLocationText"],
        endLocationText: json["endLocationText"],
        distance: json["distance"],
        payment: json["payment"],
        paymentMethod: json["paymentMethod"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "startLocation": startLocation,
        "endLocation": endLocation,
        "startLocationText": startLocationText,
        "endLocationText": endLocationText,
        "distance": distance,
        "payment": payment,
        "paymentMethod": paymentMethod,
        "date": date,
      };
}
