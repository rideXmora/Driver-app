import 'package:driver_app/api/utils.dart';
import 'package:flutter/material.dart';

class DriverApi {
  late final ApiUtils apiUtils;
  DriverApi(this.apiUtils);

  void initState() {
    this.apiUtils = ApiUtils();
  }

  @visibleForTesting
  DriverApi.internal(this.apiUtils);

  Future<dynamic> profile({required String token}) async {
    String url = '/api/driver/profile';
    dynamic response = await apiUtils.getRequest(
      url: url,
      token: token,
    );
    return response;
  }

  Future<dynamic> past({required String token}) async {
    String url = '/api/driver/ride/past';
    dynamic response = await apiUtils.getRequest(
      url: url,
      token: token,
    );
    return response;
  }
}
