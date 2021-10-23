class Location {
  Location({
    required this.x,
    required this.y,
  });

  double x;
  double y;

  factory Location.fromJson(Map<dynamic, dynamic> json) => Location(
        x: json["x"],
        y: json["y"],
      );

  Map<String, dynamic> toJson() => {
        "x": x,
        "y": y,
      };
}
