// Driver OneServiceFromJson(String str) =>
//     Driver.fromJson(json.decode(str));

// String OneServiceToJson(OneService data) => json.encode(data.toJson());

import 'package:driver_app/utils/payment_method.dart';

class Trip {
  Trip({
    required this.pickUp,
    required this.destination,
    required this.distance,
    required this.time,
    required this.amount,
    required this.paymentMethod,
  });

  String pickUp;
  String destination;
  String distance;
  String time;
  double amount;
  PaymentMethod paymentMethod;

  factory Trip.fromJson(Map<dynamic, dynamic> json) => Trip(
        pickUp: json["pickUp"],
        destination: json["destination"],
        distance: json["distance"],
        time: json["time"],
        amount: json["amount"],
        paymentMethod: json["paymentMethod"],
      );

  Map<String, dynamic> toJson() => {
        "pickUp": pickUp,
        "destination": destination,
        "distance": distance,
        "time": time,
        "amount": amount,
        "paymentMethod": paymentMethod,
      };
}
