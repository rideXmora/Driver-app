import 'package:driver_app/api/auth_api.dart';
import 'package:driver_app/api/driver_api.dart';
import 'package:driver_app/api/driver_ride_api.dart';
import 'package:driver_app/api/utils.dart';
import 'package:driver_app/controllers/organization_controller.dart';
import 'package:get/get.dart';
import 'package:driver_app/controllers/auth_controller.dart';
import 'package:driver_app/controllers/controller.dart';
import 'package:driver_app/controllers/map_controller.dart';
import 'package:driver_app/controllers/ride_controller.dart';
import 'package:driver_app/controllers/user_controller.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    print("app binding");
    Get.lazyPut<Controller>(() => Controller());
    Get.lazyPut<AuthController>(
        () => AuthController(AuthApi(ApiUtils()), DriverApi(ApiUtils())));
    Get.put(MapController(ApiUtils()));
    Get.lazyPut<UserController>(() => UserController(DriverApi(ApiUtils())));
    Get.put(RideController(DriverRideApi(ApiUtils())));
    Get.put(OrganizationController(ApiUtils()));
  }
}
