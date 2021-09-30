class Vehicle {
  Vehicle({
    this.number = "",
    this.vehicleType = "",
    this.model = "",
    this.license = "",
    this.insurance = "",
    this.vehicleRegNo = "",
  });

  String number;
  String vehicleType;
  String model;
  String license;
  String insurance;
  String vehicleRegNo;

  factory Vehicle.fromJson(Map<dynamic, dynamic> json) => Vehicle(
        number: json["number"],
        vehicleType: json["vehicleType"],
        model: json["model"],
        license: json["license"],
        insurance: json["insurance"],
        vehicleRegNo: json["vehicleRegNo"],
      );

  Map<String, dynamic> toJson() => {
        "number": number,
        "vehicleType": vehicleType,
        "model": model,
        "license": license,
        "insurance": insurance,
        "vehicleRegNo": vehicleRegNo,
      };
}
