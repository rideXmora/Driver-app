import 'package:driver_app/api/driver_ride_api.dart';
import 'package:driver_app/controllers/user_controller.dart';
import 'package:driver_app/utils/driver_status.dart';
import 'package:get/get.dart';

class RideController extends GetxController {
  UserController userController = Get.find<UserController>();

  Future<bool> changeDriverRideStatus({
    required double x,
    required double y,
  }) async {
    DriverState state = userController.driver.value.status;
    dynamic response = await toggleStatus(
      x: x,
      y: y,
      token: Get.find<UserController>().driver.value.token,
    );

    if (!response["error"]) {
      if (state == DriverState.OFFLINE) {
        userController.driver.update((val) {
          val!.status = DriverState.ONLINE;
        });
      } else {
        userController.driver.update((val) {
          val!.status = DriverState.OFFLINE;
        });
      }
      return true;
    } else {
      Get.snackbar("Something is wrong!!!", "Please try again");
      return false;
    }
  }
}
