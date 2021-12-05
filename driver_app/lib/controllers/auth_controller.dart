import 'package:driver_app/api/driver_api.dart';
import 'package:driver_app/api/utils.dart';
import 'package:driver_app/controllers/user_controller.dart';
import 'package:driver_app/modals/organization.dart';
import 'package:driver_app/modals/vehicle.dart';
import 'package:driver_app/pages/bottom_navigation_bar_handler.dart';
import 'package:driver_app/pages/sign_in_up/pages/getting_started_screen.dart';
import 'package:driver_app/pages/sign_in_up/pages/language_selection_screen.dart';
import 'package:driver_app/pages/sign_in_up/pages/mobile_number_verification_screen.dart';
import 'package:driver_app/pages/sign_in_up/pages/registration/documentation_screen.dart';
import 'package:driver_app/pages/sign_in_up/pages/registration/registration_screen.dart';
import 'package:driver_app/pages/sign_in_up/pages/registration/selecting_vchicle_type.dart';
import 'package:driver_app/pages/sign_in_up/pages/registration/waiting_screen.dart';
import 'package:driver_app/pages/sign_in_up/pages/welcome_screen.dart';
import 'package:driver_app/utils/firebase_notification_handler.dart';
import 'package:driver_app/utils/validation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:driver_app/api/auth_api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class AuthController extends GetxController {
  // SplashScreen data loading
  late final AuthApi authApi;
  late final DriverApi driverApi;
  AuthController(this.authApi, this.driverApi);

  void initState() {
    this.authApi = AuthApi(ApiUtils());
    this.driverApi = DriverApi(ApiUtils());
  }

  @visibleForTesting
  AuthController.internal(this.authApi, this.driverApi);

  Future<void> loadData() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();

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

    try {
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
          Get.offAll(WelcomeScreen());
        } else {
          debugPrint("token not null");
          try {
            FirebaseNotifications firebaseNotifications =
                FirebaseNotifications();
            firebaseNotifications.setupFirebase();
            await firebaseNotifications.startListening();
          } catch (e) {
            debugPrint("firebase notification error");
            Get.offAll(WelcomeScreen());
          }
          bool isExpired = await isTokenExpired();
          if (isExpired) {
            debugPrint("token expired refresh need");
            //to do
            //regenerate token with refresh token
            Get.offAll(WelcomeScreen());
          } else {
            debugPrint("token valid");
            dynamic response = await driverApi.profile(token: token);
            debugPrint("profile grabbed");
            Get.find<UserController>().clearData();
            Get.find<UserController>().updateDriverData(
              response["body"],
              token,
              refreshToken,
            );

            if (response["body"]["email"] == null ||
                response["body"]["vehicle"] == null) {
              debugPrint("new user without registration completed: " +
                  Get.find<UserController>().driver.value.toJson().toString());
              Get.to(() => RegistrationScreen(
                  phoneNo: Get.find<UserController>().driver.value.phone));
            } else if (!response["body"]["enabled"]) {
              debugPrint("new user with registered not enabled: " +
                  Get.find<UserController>().driver.value.toJson().toString());
              Get.to(() => WaitingScreen());
            } else {
              debugPrint("user exist : " +
                  Get.find<UserController>().driver.value.toJson().toString());
              Get.offAll(() => BottomNavHandler());
            }
          }
        }
      }
    } catch (e) {
      debugPrint("getoffall");
      Get.offAll(GettingStartedScreen());
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
      dynamic response = await authApi.phoneAuth(phone: phone);
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

    if (otp.length < 6) {
      Get.snackbar("OTP is not valid!!!", "Otp must have 6 characters");
    } else {
      try {
        FirebaseNotifications firebaseNotifications = FirebaseNotifications();
        firebaseNotifications.setupFirebase();
        await firebaseNotifications.startListening();
      } catch (e) {
        Get.snackbar("Something is wrong!!!", "Please try again");
        return;
      }
      dynamic response = await authApi.phoneVerify(phone: phone, otp: otp);

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
        Get.find<UserController>().clearData();
        Get.find<UserController>().saveDriverData(response["body"]);
        if (response["body"]["email"] == null ||
            response["body"]["vehicle"] == null) {
          debugPrint("new user without registration completed: " +
              Get.find<UserController>().driver.value.toJson().toString());
          Get.to(() => RegistrationScreen(
              phoneNo: Get.find<UserController>().driver.value.phone));
        } else if (!response["body"]["enabled"]) {
          debugPrint("new user with registered not enabled: " +
              Get.find<UserController>().driver.value.toJson().toString());
          Get.to(() => WaitingScreen());
        } else {
          debugPrint("user exist : " +
              Get.find<UserController>().driver.value.toJson().toString());
          Get.offAll(() => BottomNavHandler());
        }
      }
      return;
    }
  }

  Future<void> register(
      {required String name,
      required String email,
      required String city,
      required Organization driverOrganization}) async {
    if (name.length == 0) {
      Get.snackbar("Name is not valid!!!", "Name field cannot be empty");
    } else if (!isEmailValid(email)) {
    } else if (city.length == 0) {
      Get.snackbar("City is not valid!!!", "City field cannot be empty");
    } else {
      String notificationToken = "";
      try {
        FirebaseNotifications firebaseNotifications = FirebaseNotifications();
        firebaseNotifications.setupFirebase();
        await firebaseNotifications.startListening();
        notificationToken = await firebaseNotifications.getToken();
      } catch (e) {
        Get.snackbar("Something is wrong!!!", "Please try again");
        return;
      }
      dynamic response = await authApi.profileComplete(
        name: name,
        email: email,
        city: city,
        driverOrganization: {
          "id": driverOrganization.id,
          "name": driverOrganization.name,
        },
        notificationToken: notificationToken,
        token: Get.find<UserController>().driver.value.token,
      );

      if (!response["error"]) {
        SharedPreferences store = await SharedPreferences.getInstance();
        String token = store.getString("token").toString();
        String refreshToken = store.getString("refreshToken").toString();
        Get.find<UserController>().updateDriverData(
          response["body"],
          token,
          refreshToken,
        );
        debugPrint("after registration : " +
            Get.find<UserController>().driver.value.toJson().toString());
        Get.to(() => SelectingVechicleTypeScreen());
      } else {
        Get.snackbar("Something is wrong!!!", "Please try again");
      }
      return;
    }
  }

  Future<void> registrationComplete({required Vehicle vehicle}) async {
    debugPrint(vehicle.toJson().toString());
    if (vehicle.number.isEmpty) {
      Get.snackbar("Vehicle number is not valid!!!",
          "Vehicle number field cannot be empty");
    } else if (vehicle.model.isEmpty) {
      Get.snackbar("Vehicle model is not valid!!!",
          "Vehicle model field cannot be empty");
    } else if (vehicle.vehicleType == null) {
      Get.snackbar(
          "Vehicle type is not valid!!!", "Vehicle type field cannot be empty");
    }
    // if (image.length == 0) {
    //   Get.snackbar("Profile image not uploaded!!!",
    //       "Please check you have uploaded Profile image properly");
    // }  else
    else if (vehicle.license.length == 0) {
      Get.snackbar("Driving license image not uploaded!!!",
          "Please check you have uploaded driving license image properly");
    } else if (vehicle.insurance.length == 0) {
      Get.snackbar("Vehicle insuarance image not uploaded!!!",
          "Please check you have uploaded Vehicle insuarance image properly");
    }
    // else if (vehicle.revenueLicense.length == 0) {
    //   Get.snackbar("Revenue licese image not uploaded!!!",
    //       "Please check you have uploaded Revenue licese image properly");
    // }
    else if (vehicle.vehicleRegNo.length == 0) {
      Get.snackbar("Vehicle registration document image not uploaded!!!",
          "Please check you have uploaded Vehicle registration document image properly");
    } else {
      try {
        Get.find<UserController>().addVehicleInfo(vehicle, "other");
        dynamic response = await authApi.addVehicle(
            vehicle: vehicle,
            token: Get.find<UserController>().driver.value.token);

        if (!response["error"]) {
          SharedPreferences store = await SharedPreferences.getInstance();
          String token = store.getString("token").toString();
          String refreshToken = store.getString("refreshToken").toString();
          Get.find<UserController>().updateDriverVehicleData(
            response["body"],
            token,
            refreshToken,
            vehicle,
          );
          debugPrint(
              Get.find<UserController>().driver.value.toJson().toString());
          Get.to(() => WaitingScreen());
        } else {
          Get.snackbar("Something is wrong!!!", "Please try again");
        }
      } catch (e) {
        Get.offAll(GettingStartedScreen());
      }
      return;
    }
  }

  // sign out user from the application
  Future<void> signOut() async {
    SharedPreferences store = await SharedPreferences.getInstance();
    store.remove("token");
    store.remove("refreshToken");
    Get.find<UserController>().signOutUser();
    Get.offAll(WelcomeScreen());
  }
}
