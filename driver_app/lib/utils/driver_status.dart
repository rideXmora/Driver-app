enum DriverState {
  ONLINE,
  OFFLINE,
}

DriverState getDriverState(String topic) {
  if (topic == "ONLINE") {
    return DriverState.ONLINE;
  } else {
    return DriverState.OFFLINE;
  }
}

String getDriverStateString(DriverState topic) {
  if (topic == DriverState.ONLINE) {
    return "ONLINE";
  } else {
    return "OFFLINE";
  }
}
