import 'package:driver_app/api/utils.dart';

Future<dynamic> toggleStatus({
  required double x,
  required double y,
  required String token,
}) async {
  String url = '/api/driver/toggleStatus';
  dynamic response = await putRequest(
    url: url,
    data: {
      "location": {
        "x": x,
        "y": y,
      }
    },
    token: token,
  );
  return response;
}

Future<dynamic> accept({
  required String id,
  required String token,
}) async {
  String url = '/api/driver/ride/accept';
  dynamic response = await putRequest(
    url: url,
    data: {
      "id": id,
    },
    token: token,
  );
  return response;
}

Future<dynamic> arrived({
  required String id,
  required String token,
}) async {
  String url = '/api/driver/ride/status/arrived';
  dynamic response = await postRequest(
    url: url,
    data: {
      "id": id,
    },
    token: token,
  );
  return response;
}

Future<dynamic> picked({
  required String id,
  required String token,
}) async {
  String url = '/api/driver/ride/status/picked';
  dynamic response = await postRequest(
    url: url,
    data: {
      "id": id,
    },
    token: token,
  );
  return response;
}

Future<dynamic> dropped({
  required String id,
  required String token,
}) async {
  String url = '/api/driver/ride/status/dropped';
  dynamic response = await postRequest(
    url: url,
    data: {
      "id": id,
    },
    token: token,
  );
  return response;
}

Future<dynamic> finished({
  required String id,
  required String driverFeedback,
  required int passengerRating,
  required int waitingTime,
  required String token,
}) async {
  String url = '/api/driver/ride/status/finished';
  dynamic response = await postRequest(
    url: url,
    data: {
      "id": id,
      "driverFeedback": driverFeedback,
      "passengerRating": passengerRating,
      "waitingTime": waitingTime,
    },
    token: token,
  );
  return response;
}
