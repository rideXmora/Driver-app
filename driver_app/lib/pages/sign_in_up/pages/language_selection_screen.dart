import 'package:driver_app/pages/sign_in_up/pages/welcome_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:driver_app/pages/sign_in_up/widgets/language_selection_radio_button.dart';
import 'package:driver_app/theme/colors.dart';
import 'package:driver_app/widgets/secondary_button_with_icon.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageSelectionScreen extends StatefulWidget {
  LanguageSelectionScreen({Key? key}) : super(key: key);

  @override
  _LanguageSelectionScreenState createState() =>
      _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  int selected = 1;
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
                  "Select your prefered language".tr,
                  style: TextStyle(
                    color: primaryColorDark,
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            SizedBox(
              height: 70,
            ),
            Center(
              child: LanguageSelectionRadioButton(
                selected: selected,
                onTap_1: () {
                  setState(() {
                    selected = 1;
                  });
                  var locale = Locale('en', 'UK');
                  Get.updateLocale(locale);
                },
                onTap_2: () {
                  setState(() {
                    selected = 2;
                  });
                  var locale = Locale('si', 'LK');
                  Get.updateLocale(locale);
                },
                onTap_3: () {
                  setState(() {
                    selected = 3;
                  });
                  var locale = Locale('ta', 'LK');
                  Get.updateLocale(locale);
                },
              ),
            ),
            SizedBox(
              height: 90,
            ),
            SecondaryButtonWithIcon(
              icon: Icons.arrow_forward_rounded,
              iconColor: primaryColorWhite,
              onPressed: () async {
                SharedPreferences store = await SharedPreferences.getInstance();
                switch (selected) {
                  case 1:
                    store.setString(
                      "lan",
                      'en_UK',
                    );
                    break;
                  case 2:
                    store.setString(
                      "lan",
                      'si_LK',
                    );

                    break;
                  case 3:
                    store.setString(
                      "lan",
                      'ta_LK',
                    );
                    break;
                  default:
                    store.setString(
                      "lan",
                      'en_UK',
                    );
                }
                Get.to(WelcomeScreen());
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
