import 'package:driver_app/pages/sign_in_up/pages/language_selection_screen.dart';
import 'package:get/get.dart';
import 'package:driver_app/api/auth_api.dart';

class AuthController extends GetxController {
  // SplashScreen data loading
  Future<void> loadData() async {
    await Future.delayed(Duration(seconds: 2)).then((value) {
      Get.offAll(LanguageSelectionScreen());
    });
  }

  // SignUp loading
  Future<void> signUp({required String phone}) async {
    await signUpRequest(phone: phone);
    // await Future.delayed(Duration(seconds: 2)).then((value) {
    //   Get.offAll(LanguageSelectionScreen());
    // });
  }
}
