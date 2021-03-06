import 'package:driver_app/controllers/user_controller.dart';
import 'package:driver_app/modals/vehicle.dart';
import 'package:driver_app/pages/sign_in_up/pages/registration/documentation_screen.dart';
import 'package:driver_app/pages/sign_in_up/widgets/ducument_box.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:driver_app/theme/colors.dart';
import 'package:driver_app/widgets/custom_back_button.dart';
import 'package:driver_app/widgets/main_button.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class RevenueLicenseUploadScreen extends StatefulWidget {
  RevenueLicenseUploadScreen({Key? key}) : super(key: key);

  @override
  _RevenueLicenseUploadScreenState createState() =>
      _RevenueLicenseUploadScreenState();
}

class _RevenueLicenseUploadScreenState
    extends State<RevenueLicenseUploadScreen> {
  bool loading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: primaryColorWhite,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: MainButton(
          loading: loading,
          width: width,
          height: height,
          onPressed: () async {
            Vehicle vehicle = Get.find<UserController>().driver.value.vehicle;
            Get.find<UserController>().driver.update((val) {
              val!.vehicle = Vehicle(
                number: vehicle.number,
                vehicleType: vehicle.vehicleType,
                model: vehicle.model,
                license: vehicle.license,
                insurance: vehicle.insurance,
                vehicleRegNo: vehicle.vehicleRegNo,
              );
            });
            Get.back();
          },
          text: "CONTINUE",
          boxColor: primaryColorDark,
          shadowColor: primaryColorDark,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
              vertical: 45,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                CustomBackButton(),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "Take a photo of your Revenue License",
                  style: TextStyle(
                    color: primaryColorDark,
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  "If the vehicle owner name on the vehicle documents is different from mine, then I hereby confirm that I have the vehicle owner's consent to drive this vehicle on the RideX Platform. This declaration can be treated as a No-Objection Certificate and releases RideX from any legal obligations and consequences.",
                  style: TextStyle(
                    color: primaryColorBlack,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Container(
                    height: width * 0.7 * (3 / 4) + 50,
                    width: width * 0.7 + 50,
                    child: Stack(
                      children: [
                        Center(
                          child: Container(
                            height: width * 0.7 * (3 / 4),
                            width: width * 0.7,
                            decoration: BoxDecoration(
                              color: Color(0xFFC4C4C4),
                            ),
                          ),
                        ),
                        // * Image
                        Center(
                          child: Container(
                            height: width * 0.4 * (3 / 4),
                            width: width * 0.4,
                            decoration: BoxDecoration(
                              color: Color(0xFFC4C4C4),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(
                                  "assets/images/images/detail_card_3.png",
                                ),
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: primaryColor,
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              icon: Icon(Icons.camera_alt),
                              color: Colors.white,
                              iconSize: 25,
                              onPressed: () {
                                //_pickImageFromToProfile(context);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
