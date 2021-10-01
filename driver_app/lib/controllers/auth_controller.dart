import 'package:driver_app/api/driver_api.dart';
import 'package:driver_app/controllers/user_controller.dart';
import 'package:driver_app/pages/bottom_navigation_bar_handler.dart';
import 'package:driver_app/pages/sign_in_up/pages/getting_started_screen.dart';
import 'package:driver_app/pages/sign_in_up/pages/language_selection_screen.dart';
import 'package:driver_app/pages/sign_in_up/pages/mobile_number_verification_screen.dart';
import 'package:driver_app/pages/sign_in_up/pages/registration/selecting_vchicle_type.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:driver_app/api/auth_api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class AuthController extends GetxController {
  // SplashScreen data loading
  Future<void> loadData() async {
    SharedPreferences store = await SharedPreferences.getInstance();
    String token = store.getString("token") == null
        ? ''
        : store.getString("token").toString();
    String refreshToken = store.getString("refreshToken") == null
        ? ''
        : store.getString("refreshToken").toString();
    String lan =
        store.getString("lan") == null ? '' : store.getString("lan").toString();
    debugPrint("token : \n" +
        token +
        "\n refreshToken : \n" +
        refreshToken +
        "\n lan : \n" +
        lan);
    if (lan == '') {
      debugPrint("Language null");
      store.remove("token");
      store.remove("refreshToken");
      Get.offAll(LanguageSelectionScreen());
    } else {
      debugPrint("Language not null");
      var locale = Locale(lan.split("_")[0], lan.split("_")[1]);
      Get.updateLocale(locale);
      if (token == '') {
        debugPrint("token null");
        Get.offAll(GettingStartedScreen());
      } else {
        debugPrint("token not null");
        bool isExpired = await isTokenExpired();
        if (isExpired) {
          debugPrint("token expired refresh need");
          //to do
          //regenerate token with refresh token
          Get.offAll(GettingStartedScreen());
        } else {
          debugPrint("token valid");
          dynamic response = await profile(token: token);
          Get.find<UserController>().updateDriverData(
            response["body"],
            token,
            refreshToken,
          );
          debugPrint(Get.find<UserController>().passenger.value.toString());
          Get.offAll(() => BottomNavHandler());
        }
      }
    }
  }

  Future<bool> isTokenExpired() async {
    SharedPreferences store = await SharedPreferences.getInstance();
    bool hasExpired = JwtDecoder.isExpired(store.getString("token").toString());

    return hasExpired;
  }

  // requesting otp from GettingStartedScreen
  Future<void> getOTP({required String phone, required String from}) async {
    if (phone.length == 12) {
      dynamic response = await phoneAuth(phone: phone);
      debugPrint(response.toString());
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

  // submit otp from MobileNumberVerification
  Future<void> submitOTP({required String phone, required String otp}) async {
    SharedPreferences store = await SharedPreferences.getInstance();
    debugPrint(otp.toString());

    if (phone.length < 12) {
      Get.snackbar("Phone number is not valid!!!",
          "Phone number must have 9 characters");
    } else if (otp.length < 6) {
      Get.snackbar("OTP is not valid!!!", "Otp must have 6 characters");
    } else {
      dynamic response = await phoneVerify(phone: phone, otp: otp);

      debugPrint(response["enabled"].toString());

      if (!response["error"]) {
        String token = response["body"]["token"];
        String refreshToken = response["body"]["refreshToken"];
        store.setString(
          "token",
          token,
        );
        store.setString(
          "refreshToken",
          refreshToken,
        );
        if (response["body"]["enabled"]) {
          Get.find<UserController>().saveDriverData(response["body"]);
          debugPrint("user exist : " +
              Get.find<UserController>().passenger.value.toString());
          Get.offAll(() => BottomNavHandler());
        } else {
          Get.find<UserController>().saveDriverData(response["body"]);
          debugPrint("new user : " +
              Get.find<UserController>().passenger.value.toString());
          Get.to(() => SelectingVechicleTypeScreen());
        }
      }
      return;
    }
  }
}
