// Driver OneServiceFromJson(String str) =>
//     Driver.fromJson(json.decode(str));

// String OneServiceToJson(OneService data) => json.encode(data.toJson());

class Driver {
  Driver({
    required this.image,
    required this.name,
    required this.number,
    required this.vechicleType,
  });

  String image;
  String name;
  String vechicleType;
  String number;

  factory Driver.fromJson(Map<dynamic, dynamic> json) => Driver(
        image: json["image"],
        name: json["name"],
        number: json["number"],
        vechicleType: json["vechicleType"],
      );

  Map<String, dynamic> toJson() => {
        "image": image,
        "name": name,
        "number": number,
        "vechicleType": vechicleType,
      };
}
