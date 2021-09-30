import 'package:driver_app/pages/sign_in_up/pages/getting_started_screen.dart';
import 'package:driver_app/widgets/secondary_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:driver_app/theme/colors.dart';
import 'package:driver_app/widgets/main_button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: primaryColorWhite,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            child: Stack(
              children: [
                Container(
                  height: height * 0.5,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        primaryColorLight,
                        primaryColorLight.withOpacity(0),
                      ],
                    ),
                    image: DecorationImage(
                      fit: BoxFit.fitHeight,
                      image: AssetImage(
                        "assets/images/images/driver_app_welcome_page_image.jpg",
                      ),
                    ),
                  ),
                ),
                Container(
                  height: height * 0.5,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        primaryColor,
                        primaryColorLight.withOpacity(0),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 35, right: 5),
                    child: Image(
                      image: AssetImage(
                        "assets/logo/white_logo.png",
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    "Welcome to the",
                    style: TextStyle(
                      color: primaryColorDark,
                      fontSize: 36,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    "Driver app",
                    style: TextStyle(
                      color: primaryColorDark,
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Spacer(
                  flex: 2,
                ),
                Center(
                  child: MainButton(
                    width: width * 0.7,
                    height: height,
                    onPressed: () async {
                      Get.to(GettingStartedScreen());
                    },
                    text: "Sign in / Sign up",
                    boxColor: primaryColorDark,
                    shadowColor: primaryColorDark,
                  ),
                ),
                Spacer(
                  flex: 3,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
