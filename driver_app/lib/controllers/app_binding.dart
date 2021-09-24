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
    Get.lazyPut<AuthController>(() => AuthController());
    Get.lazyPut<MapController>(() => MapController());
    Get.lazyPut<RideController>(() => RideController());
    Get.lazyPut<UserController>(() => UserController());
  }
}
