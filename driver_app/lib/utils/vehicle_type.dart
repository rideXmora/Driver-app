enum VehicleType {
  THREE_WHEELER,
  CAR,
  VAN,
  BIKE,
}

String getDriverVehicleTypeString(VehicleType topic) {
  if (topic == VehicleType.THREE_WHEELER) {
    return "THREE_WHEELER";
  } else if (topic == VehicleType.CAR) {
    return "CAR";
  } else if (topic == VehicleType.VAN) {
    return "VAN";
  } else if (topic == VehicleType.BIKE) {
    return "BIKE";
  } else {
    return "CAR";
  }
}

VehicleType getDriverVehicleType(String topic) {
  if (topic == "THREE_WHEELER") {
    return VehicleType.THREE_WHEELER;
  } else if (topic == "CAR") {
    return VehicleType.CAR;
  } else if (topic == "VAN") {
    return VehicleType.VAN;
  } else if (topic == "BIKE") {
    return VehicleType.BIKE;
  } else {
    return VehicleType.CAR;
  }
}
