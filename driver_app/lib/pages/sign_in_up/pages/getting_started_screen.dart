import 'package:driver_app/controllers/auth_controller.dart';
import 'package:driver_app/pages/sign_in_up/pages/mobile_number_verification_screen.dart';
import 'package:driver_app/pages/sign_in_up/pages/welcome_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:driver_app/theme/colors.dart';
import 'package:driver_app/widgets/custom_back_button.dart';
import 'package:driver_app/widgets/custom_text_field.dart';
import 'package:driver_app/widgets/main_button.dart';
import 'package:get/get.dart';

class GettingStartedScreen extends StatefulWidget {
  const GettingStartedScreen({Key? key}) : super(key: key);

  @override
  _GettingStartedScreenState createState() => _GettingStartedScreenState();
}

class _GettingStartedScreenState extends State<GettingStartedScreen> {
  bool edit = true;
  String dropdownValue = "+94";
  TextEditingController mobileNumberController = TextEditingController();
  bool loading = false;

  void onSubmitText(String value) async {
    if (!loading) {
      setState(() {
        loading = true;
      });

      String phoneNumber = dropdownValue.trim() +
          mobileNumberController.text.replaceAll(" ", "");
      debugPrint(phoneNumber.length.toString());

      await Get.find<AuthController>().getOTP(
        phone: phoneNumber,
        from: "main",
      );

      setState(() {
        loading = false;
      });
    }
  }

  void onSubmitButton() async {
    if (!loading) {
      setState(() {
        loading = true;
      });

      String phoneNumber = dropdownValue.trim() +
          mobileNumberController.text.replaceAll(" ", "");
      debugPrint(phoneNumber.length.toString());

      await Get.find<AuthController>().getOTP(
        phone: phoneNumber,
        from: "main",
      );
      // Get.to(() => MobileNumberVerificationScreen(phoneNo: phoneNumber));

      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: primaryColorWhite,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 45,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomBackButton(
                    onTap: () {
                      Get.offAll(WelcomeScreen());
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "gettingStart".tr,
                    style: TextStyle(
                      color: primaryColorDark,
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 90,
                  ),
                  // CustomTextField(
                  //   readOnly: edit ? false : true,
                  //   height: height,
                  //   width: width,
                  //   controller: mobileController,
                  //   hintText: "Mobile",
                  //   prefixBoxColor: primaryColorBlack,
                  //   prefixIcon: Icon(
                  //     Icons.admin_panel_settings,
                  //     color: primaryColorLight,
                  //   ),
                  //   dropDown: SizedBox(),
                  //   onChanged: () {},
                  //   phoneNumberPrefix: SizedBox(),
                  //   suffix: SizedBox(),
                  // ),
                  CustomTextField(
                    readOnly: edit ? false : true,
                    height: height,
                    width: width,
                    controller: mobileNumberController,
                    hintText: "Mobile Number",
                    prefixBoxColor: primaryColorBlack,
                    prefixIcon: Icon(
                      Icons.phone,
                      color: primaryColorLight,
                    ),
                    dropDown: SizedBox(),
                    keyboardType: TextInputType.number,
                    onChanged: () {},
                    phoneNumberPrefixWidth: 110,
                    inputFormatters: [
                      MaskedInputFormatter("## ### ####",
                          allowedCharMatcher: RegExp(r'\d')),
                    ],
                    phoneNumberPrefix: Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        IgnorePointer(
                          ignoring: edit ? false : true,
                          child: DropdownButton<String>(
                            underline: SizedBox(),
                            value: dropdownValue,
                            icon: Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: primaryColorWhite,
                            ),
                            style: TextStyle(
                              color: primaryColorWhite,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownValue = newValue.toString();
                              });
                            },
                            dropdownColor: primaryColorLight,
                            items: <String>['+94']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(
                                    color: primaryColorWhite,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        Container(
                          margin:
                              const EdgeInsets.only(top: 13.0, bottom: 13.0),
                          child: VerticalDivider(
                            color: primaryColorWhite,
                            width: 1,
                          ),
                        ),
                      ],
                    ),
                    suffix: SizedBox(),
                    onSubmit: onSubmitText,
                  ),
                  SizedBox(
                    height: 90,
                  ),
                  MainButton(
                    loading: loading,
                    width: width,
                    height: height,
                    onPressed: onSubmitButton,
                    text: "CONTINUE",
                    boxColor: primaryColorDark,
                    shadowColor: primaryColorDark,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
