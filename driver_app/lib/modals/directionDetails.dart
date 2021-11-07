class DirectionDetails {
  DirectionDetails({
    required this.distanceText,
    required this.durationText,
    required this.encodedPoints,
    required this.distanceValue,
    required this.durationValue,
  });

  String distanceText;
  String durationText;
  String encodedPoints;
  int distanceValue;
  int durationValue;

  factory DirectionDetails.fromJson(Map<dynamic, dynamic> json) =>
      DirectionDetails(
        distanceText: json["distanceText"],
        durationText: json["durationText"],
        encodedPoints: json["encodedPoints"],
        distanceValue: json["distanceValue"],
        durationValue: json["durationValue"],
      );

  Map<String, dynamic> toJson() => {
        "distanceText": distanceText,
        "durationText": durationText,
        "encodedPoints": encodedPoints,
        "distanceValue": distanceValue,
        "durationValue": durationValue,
      };
}
