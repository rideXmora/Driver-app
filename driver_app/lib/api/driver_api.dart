import 'package:driver_app/api/utils.dart';

Future<dynamic> profile({required String token}) async {
  String url = '/api/driver/profile';
  dynamic response = await getRequest(
    url: url,
    token: token,
  );
  return response;
}
