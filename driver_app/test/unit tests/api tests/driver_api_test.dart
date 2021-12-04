import 'package:driver_app/api/driver_api.dart';
import 'package:driver_app/api/utils.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockClient extends Mock implements ApiUtils {
  Future<Map<dynamic, dynamic>> getRequest(
      {required String url, required String token}) async {
    if (url == '/api/driver/profile') {
      if (token == driverToken) {
        var body = {
          "id": "61820de6fd64760c31213444",
          "phone": "+94763067706",
          "email": "avishkar.18@cse.mrt.ac.lk",
          "name": "Avishka Driver",
          "city": "Panadura",
          "drivingLicense": "https://storage/drivingLicense",
          "totalIncome": 256324,
          "sessionIncome": 2253,
          "totalRating": 4,
          "totalRides": 29,
          "vehicle": {
            "number": "NW-2021",
            "vehicleType": "CAR",
            "model": "Nissan",
            "license": "https://storage/SLRG 202134",
            "insurance": "https://storage/insurance aaa",
            "vehicleRegNo": "https://storage/12334654421"
          },
          "driverOrganization": {
            "id": "61820ca4fd64760c31213442",
            "name": "PickMe"
          },
          "notificationToken":
              "cVsfNcSvSyS-4cBQ6264-W:APA91bHSnQUe_zeU1RHUicyaP20OrhT_dwObeifUS4WgFSRNLRV2T_D5zkewio6oJXRdy4P-F8xb4hKOugH7NRqjjW2VSmmdt-HPg99KJNuor65XXkHJq8MkJIxZv6g8m6S4bg-9Uzvk",
          "status": "ONLINE",
          "enabled": true,
          "suspend": false
        };
        return {
          "code": 200,
          "body": body,
          "error": false,
        };
      } else {
        var body = {
          "message": "Forbidden",
        };
        return {
          "code": 403,
          "body": body,
          "error": true,
        };
      }
    } else if (url == '/api/driver/ride/past') {
      if (token == driverToken) {
        var body = [
          {
            "id": "61820de6fd64760c31213444",
            "rideRequest": {
              "id": "61820de6fd64760c14264860",
              "passenger": {
                "id": "61820de6fd64760c45382739",
                "phone": "+94763067706",
                "name": "Avishka Passenger",
                "rating": 3
              },
              "startLocation": {"x": 23.256321, "y": 12.253654},
              "endLocation": {"x": 28.235689, "y": 13.235452},
              "distance": 23562,
              "vehicleType": "THREE_WHEELER",
              "status": "ACCEPTED",
              "driver": {
                "id": "61820de6fd64760c56483903",
                "phone": "+94711737706",
                "name": "Avishka Driver",
                "vehicle": {
                  "number": "CAB 1235",
                  "vehicleType": "THREE_WHEELER",
                  "model": "Toyota"
                },
                "rating": 4
              },
              "organization": {
                "id": "61820de6fd64760c31213638",
                "name": "Avishka Org",
              },
              "timestamp": 1636377686
            },
            "payment": 523.4,
            "rideStatus": "FINISHED"
          },
        ];
        return {
          "code": 200,
          "body": body,
          "error": false,
        };
      } else {
        var body = {
          "message": "Forbidden",
        };
        return {
          "code": 403,
          "body": body,
          "error": true,
        };
      }
    } else {
      return {};
    }
  }
}

const String driverToken =
    "eyJhbGciOiJSUzI1NiJ9.eyJzdWIiOiIrOTQ3NjMwNjc3MDYiLCJyb2xlcyI6WyJEUklWRVIiXSwidHlwZSI6ImF1dGgiLCJpYXQiOjE2MzU5MTMxOTAsImV4cCI6MTY3MTkxMzE5MH0.lWqkjQ_78RDv2DrIIHIazgou_4fx8ugqKxchTr-3f2Cno7W9SkS5oZbsRIMDq8pmKvOIo70NU77gbrV-WvvTR_W6aNLZON6axjAV6si3KeZYpB6d-FWkfQh-yGcUiWTM0dzsqHCFmHI8gNz7V-KlNyXv5CUfYRRRoTfDK-5tRLTM0ahuO31H9TSp4x7CGCszHCo2LDNzqRDCmB4zn42nqBIdtoUjMMOWjha9oPhlEvGiz80YRyNn5yMixcdLL8xy_Npl2vYv6EyW-AoSg4qCRJAIgHpOFkhsIy5qav5zqpfddkxEkCSJhMguRj5AimKQwkOqTRhiPdDKeDCQFXXhxA";

void main() {
  group(
    "Driver API test: ",
    () {
      group("Get driver details: ", () {
        test("Success", () async {
          MockClient mockService = MockClient();
          DriverApi api = DriverApi.internal(mockService);
          var out = await api.profile(token: driverToken);
          var expectedBody = {
            "id": "61820de6fd64760c31213444",
            "phone": "+94763067706",
            "email": "avishkar.18@cse.mrt.ac.lk",
            "name": "Avishka Driver",
            "city": "Panadura",
            "drivingLicense": "https://storage/drivingLicense",
            "totalIncome": 256324,
            "sessionIncome": 2253,
            "totalRating": 4,
            "totalRides": 29,
            "vehicle": {
              "number": "NW-2021",
              "vehicleType": "CAR",
              "model": "Nissan",
              "license": "https://storage/SLRG 202134",
              "insurance": "https://storage/insurance aaa",
              "vehicleRegNo": "https://storage/12334654421"
            },
            "driverOrganization": {
              "id": "61820ca4fd64760c31213442",
              "name": "PickMe"
            },
            "notificationToken":
                "cVsfNcSvSyS-4cBQ6264-W:APA91bHSnQUe_zeU1RHUicyaP20OrhT_dwObeifUS4WgFSRNLRV2T_D5zkewio6oJXRdy4P-F8xb4hKOugH7NRqjjW2VSmmdt-HPg99KJNuor65XXkHJq8MkJIxZv6g8m6S4bg-9Uzvk",
            "status": "ONLINE",
            "enabled": true,
            "suspend": false
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
          DriverApi api = DriverApi.internal(mockService);
          var out = await api.profile(token: '');

          var expectedBody = {
            "message": "Forbidden",
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
      group("Get past rides list: ", () {
        test("Success", () async {
          MockClient mockService = MockClient();
          DriverApi api = DriverApi.internal(mockService);
          var out = await api.past(token: driverToken);
          var expectedBody = [
            {
              "id": "61820de6fd64760c31213444",
              "rideRequest": {
                "id": "61820de6fd64760c14264860",
                "passenger": {
                  "id": "61820de6fd64760c45382739",
                  "phone": "+94763067706",
                  "name": "Avishka Passenger",
                  "rating": 3
                },
                "startLocation": {"x": 23.256321, "y": 12.253654},
                "endLocation": {"x": 28.235689, "y": 13.235452},
                "distance": 23562,
                "vehicleType": "THREE_WHEELER",
                "status": "ACCEPTED",
                "driver": {
                  "id": "61820de6fd64760c56483903",
                  "phone": "+94711737706",
                  "name": "Avishka Driver",
                  "vehicle": {
                    "number": "CAB 1235",
                    "vehicleType": "THREE_WHEELER",
                    "model": "Toyota"
                  },
                  "rating": 4
                },
                "organization": {
                  "id": "61820de6fd64760c31213638",
                  "name": "Avishka Org",
                },
                "timestamp": 1636377686
              },
              "payment": 523.4,
              "rideStatus": "FINISHED"
            },
          ];
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
          DriverApi api = DriverApi.internal(mockService);
          var out = await api.past(token: '');

          var expectedBody = {
            "message": "Forbidden",
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
    },
  );
}
