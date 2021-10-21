import 'package:driver_app/api/utils.dart';

Future<dynamic> toggleStatus(
    {required double x, required double y, required String token}) async {
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
