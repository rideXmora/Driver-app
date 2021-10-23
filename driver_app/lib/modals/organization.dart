// Driver OneServiceFromJson(String str) =>
//     Driver.fromJson(json.decode(str));

// String OneServiceToJson(OneService data) => json.encode(data.toJson());

//chnaged
// image: json["image"],
//       name: json["name"],
//       number: json["number"],
//       rating: json["rating"],

class Organization {
  Organization({
    this.id = "",
    this.name = "",
  });

  String id;

  String name;

  factory Organization.fromJson(Map<dynamic, dynamic> json) => Organization(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
