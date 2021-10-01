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

Future<dynamic> profileComplete(
    {required String name,
    required String email,
    required String token,
    required String city,
    required Map<String, String> driverOrganization}) async {
  String url = '/api/driver/profileComplete';
  dynamic response = await postRequest(
    url: url,
    data: {
      "email": email,
      "name": name,
      "city": city,
      "driverOrganization": driverOrganization,
    },
    token: token,
  );
  return response;
}
