import 'dart:convert';

import 'package:driver_app/api/auth_api.dart';
import 'package:driver_app/api/utils.dart';
import 'package:driver_app/modals/vehicle.dart';
import 'package:driver_app/utils/vehicle_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';

import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

class MockClient extends Mock implements ApiUtils {
  Future<Map<dynamic, dynamic>> postRequest(
      {required String url,
      required Map<String, dynamic> data,
      required String token}) async {
    var dataString = data.toString();
    if (url == '/api/auth/driver/phoneAuth') {
      if (dataString == {"phone": "+94711737706"}.toString()) {
        var body = {
          "message": "Otp sent",
        };
        return {
          "code": 200,
          "body": body,
          "error": false,
        };
      } else {
        var body = {
          "message": "Unable to generate OTP",
        };
        return {
          "code": 500,
          "body": body,
          "error": true,
        };
      }
    } else if (url == '/api/auth/driver/phoneVerify') {
      if (dataString == {"phone": "+94763067706", "otp": "123456"}.toString()) {
        var body = {
          "id": "61820de6fd64760c31213444",
          "phone": "+94763067706",
          "token":
              "eyJhbGciOiJSUzI1NiJ9.eyJzdWIiOiIrOTQ3NjMwNjc3MDYiLCJyb2xlcyI6WyJEUklWRVIiXSwidHlwZSI6ImF1dGgiLCJpYXQiOjE2MzU5MTMxOTAsImV4cCI6MTY3MTkxMzE5MH0.lWqkjQ_78RDv2DrIIHIazgou_4fx8ugqKxchTr-3f2Cno7W9SkS5oZbsRIMDq8pmKvOIo70NU77gbrV-WvvTR_W6aNLZON6axjAV6si3KeZYpB6d-FWkfQh-yGcUiWTM0dzsqHCFmHI8gNz7V-KlNyXv5CUfYRRRoTfDK-5tRLTM0ahuO31H9TSp4x7CGCszHCo2LDNzqRDCmB4zn42nqBIdtoUjMMOWjha9oPhlEvGiz80YRyNn5yMixcdLL8xy_Npl2vYv6EyW-AoSg4qCRJAIgHpOFkhsIy5qav5zqpfddkxEkCSJhMguRj5AimKQwkOqTRhiPdDKeDCQFXXhxA",
          "refreshToken": "b345a8de-7d99-41cd-a994-29cc404ee0bd",
          "email": null,
          "name": null,
          "totalRating": 0,
          "totalRides": 0,
          "pastRides": null,
          "vehicle": null,
          "driverOrganization": null,
          "status": "OFFLINE",
          "enabled": false
        };
        return {
          "code": 200,
          "body": body,
          "error": false,
        };
      } else if (dataString ==
          {"phone": "+94763067706", "otp": "123457"}.toString()) {
        var body = {
          "message": "Invalid OTP/phone",
        };
        return {
          "code": 401,
          "body": body,
          "error": true,
        };
      } else {
        var body = {
          "message": "User is suspended",
        };
        return {
          "code": 403,
          "body": body,
          "error": true,
        };
      }
    } else if (url == '/api/driver/profileComplete') {
      if (dataString ==
          {
            "email": "avishkar.18@cse.mrt.ac.lk",
            "name": "Avishka Driver",
            "city": "Panadura",
            "driverOrganization": {
              "id": "61820ca4fd64760c31213442",
              "name": "PickMe"
            },
            "notificationToken":
                "cVsfNcSvSyS-4cBQ6264-W:APA91bHSnQUe_zeU1RHUicyaP20OrhT_dwObeifUS4WgFSRNLRV2T_D5zkewio6oJXRdy4P-F8xb4hKOugH7NRqjjW2VSmmdt-HPg99KJNuor65XXkHJq8MkJIxZv6g8m6S4bg-9Uzvk",
          }.toString()) {
        var body = {
          "id": "61820de6fd64760c31213444",
          "phone": "+94763067706",
          "email": "avishkar.18@cse.mrt.ac.lk",
          "name": "Avishka Driver",
          "city": "Panadura",
          "drivingLicense": null,
          "totalIncome": 0,
          "sessionIncome": 0,
          "totalRating": 0,
          "totalRides": 0,
          "vehicle": null,
          "driverOrganization": {
            "id": "61820ca4fd64760c31213442",
            "name": "PickMe"
          },
          "notificationToken":
              "cVsfNcSvSyS-4cBQ6264-W:APA91bHSnQUe_zeU1RHUicyaP20OrhT_dwObeifUS4WgFSRNLRV2T_D5zkewio6oJXRdy4P-F8xb4hKOugH7NRqjjW2VSmmdt-HPg99KJNuor65XXkHJq8MkJIxZv6g8m6S4bg-9Uzvk",
          "status": "OFFLINE",
          "enabled": false,
          "suspend": null
        };
        return {
          "code": 200,
          "body": body,
          "error": false,
        };
      } else {
        var body = {
          "message": "User not found",
        };
        return {
          "code": 400,
          "body": body,
          "error": true,
        };
      }
    } else if (url == '/api/driver/addVehicle') {
      if (dataString ==
          {
            "number": "NW-2021",
            "vehicleType": "CAR",
            "model": "Nissan",
            "license": "SLRG 202134",
            "insurance": "insurance aaa",
            "vehicleRegNo": "12334654421"
          }.toString()) {
        var body = {
          "id": "61820de6fd64760c31213444",
          "phone": "+94763067706",
          "email": "avishkar.18@cse.mrt.ac.lk",
          "name": "Avishka Driver",
          "city": "Panadura",
          "drivingLicense": null,
          "totalIncome": 0,
          "sessionIncome": 0,
          "totalRating": 0,
          "totalRides": 0,
          "vehicle": {
            "number": "NW-2021",
            "vehicleType": "CAR",
            "model": "Nissan",
            "license": "SLRG 202134",
            "insurance": "insurance aaa",
            "vehicleRegNo": "12334654421"
          },
          "driverOrganization": {
            "id": "61820ca4fd64760c31213442",
            "name": "PickMe"
          },
          "notificationToken":
              "cVsfNcSvSyS-4cBQ6264-W:APA91bHSnQUe_zeU1RHUicyaP20OrhT_dwObeifUS4WgFSRNLRV2T_D5zkewio6oJXRdy4P-F8xb4hKOugH7NRqjjW2VSmmdt-HPg99KJNuor65XXkHJq8MkJIxZv6g8m6S4bg-9Uzvk",
          "status": "OFFLINE",
          "enabled": false,
          "suspend": null
        };
        return {
          "code": 200,
          "body": body,
          "error": false,
        };
      } else {
        var body = {
          "message": "User not found",
        };
        return {
          "code": 400,
          "body": body,
          "error": true,
        };
      }
    } else {
      return {};
    }
  }
}

const String token =
    "eyJhbGciOiJSUzI1NiJ9.eyJzdWIiOiIrOTQ3NjMwNjc3MDYiLCJyb2xlcyI6WyJEUklWRVIiXSwidHlwZSI6ImF1dGgiLCJpYXQiOjE2MzU5MTMxOTAsImV4cCI6MTY3MTkxMzE5MH0.lWqkjQ_78RDv2DrIIHIazgou_4fx8ugqKxchTr-3f2Cno7W9SkS5oZbsRIMDq8pmKvOIo70NU77gbrV-WvvTR_W6aNLZON6axjAV6si3KeZYpB6d-FWkfQh-yGcUiWTM0dzsqHCFmHI8gNz7V-KlNyXv5CUfYRRRoTfDK-5tRLTM0ahuO31H9TSp4x7CGCszHCo2LDNzqRDCmB4zn42nqBIdtoUjMMOWjha9oPhlEvGiz80YRyNn5yMixcdLL8xy_Npl2vYv6EyW-AoSg4qCRJAIgHpOFkhsIy5qav5zqpfddkxEkCSJhMguRj5AimKQwkOqTRhiPdDKeDCQFXXhxA";

void main() {
  group(
    "Auth API test: ",
    () {
      group("Phone auth: ", () {
        test("Success", () async {
          MockClient mockService = MockClient();
          AuthApi api = AuthApi.internal(mockService);

          var out = await api.phoneAuth(phone: '+94711737706');
          var expectedBody = {
            "message": "Otp sent",
          };
          expect(
            out,
            {
              "code": 200,
              "body": expectedBody,
              "error": false,
            },
          );
        });

        test("Fail", () async {
          MockClient mockService = MockClient();
          AuthApi api = AuthApi.internal(mockService);
          var out = await api.phoneAuth(phone: '+94763067706');

          var expectedBody = {
            "message": "Unable to generate OTP",
          };
          expect(
            out,
            {
              "code": 500,
              "body": expectedBody,
              "error": true,
            },
          );
        });
      });
      group("Phone otp verify: ", () {
        test("Success", () async {
          MockClient mockService = MockClient();
          AuthApi api = AuthApi.internal(mockService);

          var out = await api.phoneVerify(phone: "+94763067706", otp: "123456");
          var expectedBody = {
            "id": "61820de6fd64760c31213444",
            "phone": "+94763067706",
            "token":
                "eyJhbGciOiJSUzI1NiJ9.eyJzdWIiOiIrOTQ3NjMwNjc3MDYiLCJyb2xlcyI6WyJEUklWRVIiXSwidHlwZSI6ImF1dGgiLCJpYXQiOjE2MzU5MTMxOTAsImV4cCI6MTY3MTkxMzE5MH0.lWqkjQ_78RDv2DrIIHIazgou_4fx8ugqKxchTr-3f2Cno7W9SkS5oZbsRIMDq8pmKvOIo70NU77gbrV-WvvTR_W6aNLZON6axjAV6si3KeZYpB6d-FWkfQh-yGcUiWTM0dzsqHCFmHI8gNz7V-KlNyXv5CUfYRRRoTfDK-5tRLTM0ahuO31H9TSp4x7CGCszHCo2LDNzqRDCmB4zn42nqBIdtoUjMMOWjha9oPhlEvGiz80YRyNn5yMixcdLL8xy_Npl2vYv6EyW-AoSg4qCRJAIgHpOFkhsIy5qav5zqpfddkxEkCSJhMguRj5AimKQwkOqTRhiPdDKeDCQFXXhxA",
            "refreshToken": "b345a8de-7d99-41cd-a994-29cc404ee0bd",
            "email": null,
            "name": null,
            "totalRating": 0,
            "totalRides": 0,
            "pastRides": null,
            "vehicle": null,
            "driverOrganization": null,
            "status": "OFFLINE",
            "enabled": false
          };
          expect(
            out,
            {
              "code": 200,
              "body": expectedBody,
              "error": false,
            },
          );
        });

        test("Fail - Invalid otp", () async {
          MockClient mockService = MockClient();
          AuthApi api = AuthApi.internal(mockService);
          var out = await api.phoneVerify(phone: "+94763067706", otp: "123457");

          var expectedBody = {
            "message": "Invalid OTP/phone",
          };
          expect(
            out,
            {
              "code": 401,
              "body": expectedBody,
              "error": true,
            },
          );
        });

        test("Fail - User suspended", () async {
          MockClient mockService = MockClient();
          AuthApi api = AuthApi.internal(mockService);
          var out =
              await api.phoneVerify(phone: "+94763067706", otp: "1234568");

          var expectedBody = {
            "message": "User is suspended",
          };
          expect(
            out,
            {
              "code": 403,
              "body": expectedBody,
              "error": true,
            },
          );
        });
      });
      group("Driver profile complete: ", () {
        test("Success", () async {
          MockClient mockService = MockClient();
          AuthApi api = AuthApi.internal(mockService);
          var out = await api.profileComplete(
            name: "Avishka Driver",
            email: "avishkar.18@cse.mrt.ac.lk",
            city: "Panadura",
            driverOrganization: {
              "id": "61820ca4fd64760c31213442",
              "name": "PickMe"
            },
            notificationToken:
                "cVsfNcSvSyS-4cBQ6264-W:APA91bHSnQUe_zeU1RHUicyaP20OrhT_dwObeifUS4WgFSRNLRV2T_D5zkewio6oJXRdy4P-F8xb4hKOugH7NRqjjW2VSmmdt-HPg99KJNuor65XXkHJq8MkJIxZv6g8m6S4bg-9Uzvk",
            token: token,
          );
          var expectedBody = {
            "id": "61820de6fd64760c31213444",
            "phone": "+94763067706",
            "email": "avishkar.18@cse.mrt.ac.lk",
            "name": "Avishka Driver",
            "city": "Panadura",
            "drivingLicense": null,
            "totalIncome": 0,
            "sessionIncome": 0,
            "totalRating": 0,
            "totalRides": 0,
            "vehicle": null,
            "driverOrganization": {
              "id": "61820ca4fd64760c31213442",
              "name": "PickMe"
            },
            "notificationToken":
                "cVsfNcSvSyS-4cBQ6264-W:APA91bHSnQUe_zeU1RHUicyaP20OrhT_dwObeifUS4WgFSRNLRV2T_D5zkewio6oJXRdy4P-F8xb4hKOugH7NRqjjW2VSmmdt-HPg99KJNuor65XXkHJq8MkJIxZv6g8m6S4bg-9Uzvk",
            "status": "OFFLINE",
            "enabled": false,
            "suspend": null
          };
          expect(
            out,
            {
              "code": 200,
              "body": expectedBody,
              "error": false,
            },
          );
        });

        test("Fail", () async {
          MockClient mockService = MockClient();
          AuthApi api = AuthApi.internal(mockService);
          var out = await api.profileComplete(
            name: "Avishka",
            email: "avishkar.18@cse.mrt.ac.lk",
            city: "Panadura",
            driverOrganization: {
              "id": "61820ca4fd64760c31213442",
              "name": "PickMe"
            },
            notificationToken:
                "cVsfNcSvSyS-4cBQ6264-W:APA91bHSnQUe_zeU1RHUicyaP20OrhT_dwObeifUS4WgFSRNLRV2T_D5zkewio6oJXRdy4P-F8xb4hKOugH7NRqjjW2VSmmdt-HPg99KJNuor65XXkHJq8MkJIxZv6g8m6S4bg-9Uzvk",
            token: '',
          );

          var expectedBody = {
            "message": "User not found",
          };
          expect(
            out,
            {
              "code": 400,
              "body": expectedBody,
              "error": true,
            },
          );
        });
      });
      group("Driver add vehicle: ", () {
        test("Success", () async {
          MockClient mockService = MockClient();
          AuthApi api = AuthApi.internal(mockService);
          var out = await api.addVehicle(
              vehicle: Vehicle(
                  number: "NW-2021",
                  vehicleType: VehicleType.CAR,
                  model: "Nissan",
                  license: "SLRG 202134",
                  insurance: "insurance aaa",
                  vehicleRegNo: "12334654421"),
              token: token);
          var expectedBody = {
            "id": "61820de6fd64760c31213444",
            "phone": "+94763067706",
            "email": "avishkar.18@cse.mrt.ac.lk",
            "name": "Avishka Driver",
            "city": "Panadura",
            "drivingLicense": null,
            "totalIncome": 0,
            "sessionIncome": 0,
            "totalRating": 0,
            "totalRides": 0,
            "vehicle": {
              "number": "NW-2021",
              "vehicleType": "CAR",
              "model": "Nissan",
              "license": "SLRG 202134",
              "insurance": "insurance aaa",
              "vehicleRegNo": "12334654421"
            },
            "driverOrganization": {
              "id": "61820ca4fd64760c31213442",
              "name": "PickMe"
            },
            "notificationToken":
                "cVsfNcSvSyS-4cBQ6264-W:APA91bHSnQUe_zeU1RHUicyaP20OrhT_dwObeifUS4WgFSRNLRV2T_D5zkewio6oJXRdy4P-F8xb4hKOugH7NRqjjW2VSmmdt-HPg99KJNuor65XXkHJq8MkJIxZv6g8m6S4bg-9Uzvk",
            "status": "OFFLINE",
            "enabled": false,
            "suspend": null
          };
          expect(
            out,
            {
              "code": 200,
              "body": expectedBody,
              "error": false,
            },
          );
        });

        test("Fail", () async {
          MockClient mockService = MockClient();
          AuthApi api = AuthApi.internal(mockService);
          var out = await api.addVehicle(vehicle: Vehicle(), token: '');

          var expectedBody = {
            "message": "User not found",
          };
          expect(
            out,
            {
              "code": 400,
              "body": expectedBody,
              "error": true,
            },
          );
        });
      });
    },
  );
}
