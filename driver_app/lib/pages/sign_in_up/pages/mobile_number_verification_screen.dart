import 'package:driver_app/controllers/auth_controller.dart';
import 'package:driver_app/pages/sign_in_up/pages/registration/registration_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:driver_app/theme/colors.dart';
import 'package:driver_app/widgets/custom_back_button.dart';
import 'package:driver_app/widgets/main_button.dart';
import 'package:get/get.dart';
import 'package:pinput/pin_put/pin_put.dart';

class MobileNumberVerificationScreen extends StatefulWidget {
  final String phoneNo;
  final String page;
  MobileNumberVerificationScreen(
      {Key? key, required this.phoneNo, required this.page})
      : super(key: key);

  @override
  _MobileNumberVerificationScreenState createState() =>
      _MobileNumberVerificationScreenState();
}

class _MobileNumberVerificationScreenState
    extends State<MobileNumberVerificationScreen> {
  String verificationId = "";

  bool codeSent = false;
  bool loading = false;

  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    //verifyPhone(widget.phoneNo);
  }

  void onSubmitButton() async {
    if (!loading) {
      setState(() {
        loading = true;
      });

      await Get.find<AuthController>().submitOTP(
          phone: widget.phoneNo, otp: _pinPutController.text.toString());
      setState(() {
        loading = false;
      });
    }
  }

  void onSubmitText(String value) async {
    if (!loading) {
      setState(() {
        loading = true;
      });

      await Get.find<AuthController>().submitOTP(
          phone: widget.phoneNo, otp: _pinPutController.text.toString());
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
                children: <Widget>[
                  CustomBackButton(),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "otpConfirm".tr,
                    style: TextStyle(
                      color: primaryColorDark,
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  RichText(
                    textAlign: TextAlign.left,
                    maxLines: 2,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "otpConfirmText".tr,
                          style: TextStyle(
                            color: primaryColorDark,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextSpan(
                          text: "${width > 310 ? '\n' : ' '}" +
                              widget.phoneNo.substring(0, 3) +
                              " " +
                              widget.phoneNo.substring(3, 5) +
                              " " +
                              widget.phoneNo.substring(5, 8) +
                              " " +
                              widget.phoneNo.substring(8, 12),
                          style: TextStyle(
                            color: primaryColorDark,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    width: width - 60,
                    child: PinPut(
                      fieldsCount: 6,
                      eachFieldHeight: ((width - 80) / 6) * 0.11,
                      eachFieldWidth: ((width - 80) / 6) * 0.11,
                      textStyle: TextStyle(
                        color: primaryColorBlack,
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                      ),
                      onSubmit: onSubmitText,
                      focusNode: _pinPutFocusNode,
                      controller: _pinPutController,
                      submittedFieldDecoration: BoxDecoration(
                        color: primaryColor,
                        border: Border.all(color: primaryColorLight),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      selectedFieldDecoration: BoxDecoration(
                        color: primaryColorLight.withOpacity(0.5),
                        border: Border.all(color: primaryColorBlack),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      followingFieldDecoration: BoxDecoration(
                        color: primaryColorLight,
                        border: Border.all(color: primaryColorLight),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
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
                  SizedBox(
                    height: 15,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: RichText(
                      textAlign: TextAlign.center,
                      key: GlobalKey(),
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Didn't get a code?",
                            style: TextStyle(
                              color: primaryColorBlack,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextSpan(
                            text: " Resend",
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async {
                                debugPrint("resend");
                                if (!loading) {
                                  setState(() {
                                    loading = true;
                                  });

                                  await Get.find<AuthController>().getOTP(
                                    phone: widget.phoneNo,
                                    from: "resend",
                                  );

                                  setState(() {
                                    loading = false;
                                  });
                                }
                              },
                          ),
                        ],
                      ),
                    ),
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
