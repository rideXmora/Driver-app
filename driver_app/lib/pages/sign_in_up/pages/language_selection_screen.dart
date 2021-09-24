import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:driver_app/pages/sign_in_up/pages/getting_started_screen.dart';
import 'package:driver_app/pages/sign_in_up/widgets/language_selection_radio_button.dart';
import 'package:driver_app/theme/colors.dart';
import 'package:driver_app/widgets/secondary_button_with_icon.dart';

class LanguageSelectionScreen extends StatelessWidget {
  const LanguageSelectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: primaryColorWhite,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                // SvgPicture.asset("assets/logo/logo.svg"),
                Image(
                  image: AssetImage(
                    "assets/logo/logo.png",
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "Select your prefered language",
                  style: TextStyle(
                    color: primaryColorDark,
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 70,
            ),
            Center(
              child: LanguageSelectionRadioButton(),
            ),
            SizedBox(
              height: 90,
            ),
            SecondaryButtonWithIcon(
              icon: Icons.arrow_forward_rounded,
              iconColor: primaryColorWhite,
              onPressed: () {
                Get.to(GettingStartedScreen());
              },
              text: "",
              boxColor: primaryColorDark,
              shadowColor: primaryColorDark,
              width: 40,
            )
          ],
        ),
      ),
    );
  }
}
