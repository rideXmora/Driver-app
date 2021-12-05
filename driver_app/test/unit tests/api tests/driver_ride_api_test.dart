import 'package:driver_app/api/driver_api.dart';
import 'package:driver_app/api/driver_ride_api.dart';
import 'package:driver_app/api/utils.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockClient extends Mock implements ApiUtils {
  Future<Map<dynamic, dynamic>> putRequest(
      {required String url,
      required Map<String, dynamic> data,
      required String token}) async {
    var dataString = data.toString();

    if (url == '/api/driver/toggleStatus') {
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
          "message": "User not found",
        };
        return {
          "code": 400,
          "body": body,
          "error": true,
        };
      }
    } else if (url == '/api/driver/ride/accept') {
      if (token == driverToken) {
        var body = {
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
          "rideStatus": "ACCEPTED"
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

  Future<Map<dynamic, dynamic>> postRequest(
      {required String url,
      required Map<String, dynamic> data,
      required String token}) async {
    var dataString = data.toString();

    if (url == '/api/driver/ride/status/arrived') {
      if (token == driverToken) {
        var body = {
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
          "rideStatus": "ARRIVED"
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
    } else if (url == '/api/driver/ride/status/picked') {
      if (token == driverToken) {
        var body = {
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
          "rideStatus": "PICKED"
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
    } else if (url == '/api/driver/ride/status/dropped') {
      if (token == driverToken) {
        var body = {
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
          "rideStatus": "DROPPED"
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
    } else if (url == '/api/driver/ride/status/finished') {
      if (token == driverToken) {
        var body = {
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
            "status": "FINISHED",
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

const String driverToken =
    "eyJhbGciOiJSUzI1NiJ9.eyJzdWIiOiIrOTQ3NjMwNjc3MDYiLCJyb2xlcyI6WyJEUklWRVIiXSwidHlwZSI6ImF1dGgiLCJpYXQiOjE2MzU5MTMxOTAsImV4cCI6MTY3MTkxMzE5MH0.lWqkjQ_78RDv2DrIIHIazgou_4fx8ugqKxchTr-3f2Cno7W9SkS5oZbsRIMDq8pmKvOIo70NU77gbrV-WvvTR_W6aNLZON6axjAV6si3KeZYpB6d-FWkfQh-yGcUiWTM0dzsqHCFmHI8gNz7V-KlNyXv5CUfYRRRoTfDK-5tRLTM0ahuO31H9TSp4x7CGCszHCo2LDNzqRDCmB4zn42nqBIdtoUjMMOWjha9oPhlEvGiz80YRyNn5yMixcdLL8xy_Npl2vYv6EyW-AoSg4qCRJAIgHpOFkhsIy5qav5zqpfddkxEkCSJhMguRj5AimKQwkOqTRhiPdDKeDCQFXXhxA";

void main() {
  group(
    "Driver Ride API test: ",
    () {
      group("Toggle riders online status: ", () {
        test("Success", () async {
          MockClient mockService = MockClient();
          DriverRideApi api = DriverRideApi.internal(mockService);
          var out = await api.toggleStatus(
              x: 23.256321, y: 12.253654, token: driverToken);
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
          DriverRideApi api = DriverRideApi.internal(mockService);
          var out =
              await api.toggleStatus(x: 23.256321, y: 12.253654, token: '');

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
      group("Accept ride request: ", () {
        test("Success", () async {
          MockClient mockService = MockClient();
          DriverRideApi api = DriverRideApi.internal(mockService);
          var out = await api.accept(
              id: "61820de6fd64760c45382739", token: driverToken);
          var expectedBody = {
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
            "rideStatus": "ACCEPTED"
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
          DriverRideApi api = DriverRideApi.internal(mockService);
          var out = await api.accept(id: "61820de6fd64760c45382739", token: '');

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

      group("Arrived to passenger location: ", () {
        test("Success", () async {
          MockClient mockService = MockClient();
          DriverRideApi api = DriverRideApi.internal(mockService);
          var out = await api.arrived(
              id: "61820de6fd64760c31213444", token: driverToken);
          var expectedBody = {
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
            "rideStatus": "ARRIVED"
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
          DriverRideApi api = DriverRideApi.internal(mockService);
          var out =
              await api.arrived(id: "61820de6fd64760c31213444", token: '');

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

      group("Picked up passenger: ", () {
        test("Success", () async {
          MockClient mockService = MockClient();
          DriverRideApi api = DriverRideApi.internal(mockService);
          var out = await api.picked(
              id: "61820de6fd64760c31213444", token: driverToken);
          var expectedBody = {
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
            "rideStatus": "PICKED"
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
          DriverRideApi api = DriverRideApi.internal(mockService);
          var out = await api.picked(id: "61820de6fd64760c31213444", token: '');

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

      group("Drop the passenger: ", () {
        test("Success", () async {
          MockClient mockService = MockClient();
          DriverRideApi api = DriverRideApi.internal(mockService);
          var out = await api.dropped(
              id: "61820de6fd64760c31213444", token: driverToken);
          var expectedBody = {
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
            "rideStatus": "DROPPED"
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
          DriverRideApi api = DriverRideApi.internal(mockService);
          var out =
              await api.dropped(id: "61820de6fd64760c31213444", token: '');

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

      group("Finish the ride: ", () {
        test("Success", () async {
          MockClient mockService = MockClient();
          DriverRideApi api = DriverRideApi.internal(mockService);
          var out = await api.finished(
              id: "61820de6fd64760c31213444",
              driverFeedback: "avarage passenger",
              passengerRating: 3,
              waitingTime: 5,
              token: driverToken);
          var expectedBody = {
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
              "status": "FINISHED",
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
          DriverRideApi api = DriverRideApi.internal(mockService);
          var out = await api.accept(id: "61820de6fd64760c45382739", token: '');

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
