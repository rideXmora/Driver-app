import 'package:driver_app/pages/sign_in_up/pages/registration/uploading_screens/driving_license_upload_screen.dart';
import 'package:driver_app/pages/sign_in_up/pages/registration/uploading_screens/profile_pic_upload_screen.dart';
import 'package:driver_app/pages/sign_in_up/pages/registration/uploading_screens/revenue_license_upload_screen.dart';
import 'package:driver_app/pages/sign_in_up/pages/registration/uploading_screens/vechicle_insuarance_upload_screen.dart';
import 'package:driver_app/pages/sign_in_up/pages/registration/uploading_screens/vechicle_registraton_doc_upload_screen.dart';
import 'package:driver_app/pages/sign_in_up/widgets/ducument_box.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:driver_app/theme/colors.dart';
import 'package:driver_app/widgets/custom_back_button.dart';
import 'package:driver_app/widgets/main_button.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';

class WaitingScreen extends StatefulWidget {
  WaitingScreen({Key? key}) : super(key: key);

  @override
  _WaitingScreenState createState() => _WaitingScreenState();
}

class _WaitingScreenState extends State<WaitingScreen> {
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
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset(
                      'assets/lotties/waiting_for_registration.json',
                      height: height * 0.5,
                      width: width * 0.6,
                      repeat: true,
                      animate: true,
                      reverse: false,
                    ),
                    // SvgPicture.asset(
                    //   "assets/images/success.svg",
                    //   height: height * 0.5,
                    //   width: width * 0.6,
                    // ),
                    Text(
                      "Wait utill Reviewing completes !!",
                      style: TextStyle(
                        color: primaryColorBlack,
                        fontSize: 19,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Your document is being reviewed by the organization. This will usually take less than one day.",
                      style: TextStyle(
                        color: primaryColorBlack,
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
