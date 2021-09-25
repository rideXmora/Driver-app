// Driver OneServiceFromJson(String str) =>
//     Driver.fromJson(json.decode(str));

// String OneServiceToJson(OneService data) => json.encode(data.toJson());

class Passenger {
  Passenger({
    required this.image,
    required this.name,
    required this.number,
    required this.rating,
  });

  String image;
  String name;
  String number;
  double rating;

  factory Passenger.fromJson(Map<dynamic, dynamic> json) => Passenger(
        image: json["image"],
        name: json["name"],
        number: json["number"],
        rating: json["rating"],
      );

  Map<String, dynamic> toJson() => {
        "image": image,
        "name": name,
        "number": number,
        "rating": rating,
      };
}
