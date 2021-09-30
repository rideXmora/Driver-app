import 'package:driver_app/api/utils.dart';

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
