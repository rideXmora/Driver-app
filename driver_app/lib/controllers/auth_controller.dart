import 'package:driver_app/pages/sign_in_up/pages/language_selection_screen.dart';
import 'package:driver_app/pages/sign_in_up/pages/mobile_number_verification_screen.dart';
import 'package:get/get.dart';
import 'package:driver_app/api/auth_api.dart';

class AuthController extends GetxController {
  // SplashScreen data loading
  Future<void> loadData() async {
    await Future.delayed(Duration(seconds: 2)).then((value) {
      Get.offAll(LanguageSelectionScreen());
    });
  }

  // requesting otp from GettingStartedScreen
  Future<void> getOTP({required String phone, required String from}) async {
    if (phone.length == 12) {
      dynamic response = await phoneAuth(phone: phone);
      if (response["error"] != true) {
        if (from == "main") {
          Get.to(() => MobileNumberVerificationScreen(
                phoneNo: phone,
                page: '',
              ));
        } else {
          Get.snackbar(
              "OTP re-sent to ($phone) number!!!", "Please check your inbox");
        }
      }
    } else {
      Get.snackbar("Phone number is not valid!!!",
          "Phone number must have 9 characters");
    }
  }
}
