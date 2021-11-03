import 'package:driver_app/api/utils.dart';
import 'package:driver_app/modals/vehicle.dart';
import 'package:driver_app/utils/vehicle_type.dart';
import 'package:flutter/material.dart';

Future<dynamic> phoneAuth({required String phone}) async {
  String url = '/api/auth/driver/phoneAuth';
  dynamic response = await postRequest(
    url: url,
    data: {
      "phone": phone,
    },
    token: '',
  );
  return response;
}

Future<dynamic> phoneVerify(
    {required String phone, required String otp}) async {
  String url = '/api/auth/driver/phoneVerify';
  dynamic response = await postRequest(
    url: url,
    data: {
      "phone": phone,
      "otp": otp,
    },
    token: '',
  );
  return response;
}

Future<dynamic> profileComplete({
  required String name,
  required String email,
  required String token,
  required String city,
  required Map<String, String> driverOrganization,
  required String notificationToken,
}) async {
  String url = '/api/driver/profileComplete';
  dynamic response = await postRequest(
    url: url,
    data: {
      "email": email,
      "name": name,
      "city": city,
      "driverOrganization": driverOrganization,
      "notificationToken": notificationToken,
    },
    token: token,
  );
  return response;
}

Future<dynamic> addVehicle({
  required Vehicle vehicle,
  required String token,
}) async {
  String url = '/api/driver/addVehicle';
  dynamic response = await postRequest(
    url: url,
    data: {
      "number": vehicle.number,
      "vehicleType": getDriverVehicleTypeString(vehicle.vehicleType),
      "model": vehicle.model,
      "license": vehicle.license,
      "insurance": vehicle.insurance,
      "vehicleRegNo": vehicle.vehicleRegNo,
    },
    token: token,
  );
  return response;
}
