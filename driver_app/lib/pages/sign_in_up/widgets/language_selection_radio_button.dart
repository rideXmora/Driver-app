import 'package:flutter/material.dart';
import 'package:driver_app/pages/sign_in_up/widgets/language_box.dart';
import 'package:driver_app/theme/colors.dart';

class LanguageSelectionRadioButton extends StatefulWidget {
  LanguageSelectionRadioButton({Key? key}) : super(key: key);

  @override
  _LanguageSelectionRadioButtonState createState() =>
      _LanguageSelectionRadioButtonState();
}

class _LanguageSelectionRadioButtonState
    extends State<LanguageSelectionRadioButton> {
  int selected = 1;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              selected = 1;
            });
          },
          child: LanguageBox(
            backgroundColor: selected == 1 ? primaryColor : primaryColorWhite,
            borderColor: primaryColorBlack,
            fontColor: selected == 1 ? primaryColorWhite : primaryColorBlack,
            text: "English",
          ),
        ),
        SizedBox(
          height: 25,
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              selected = 2;
            });
          },
          child: LanguageBox(
            backgroundColor: selected == 2 ? primaryColor : primaryColorWhite,
            borderColor: primaryColorBlack,
            fontColor: selected == 2 ? primaryColorWhite : primaryColorBlack,
            text: "Sinhala",
          ),
        ),
        SizedBox(
          height: 25,
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              selected = 3;
            });
          },
          child: LanguageBox(
            backgroundColor: selected == 3 ? primaryColor : primaryColorWhite,
            borderColor: primaryColorBlack,
            fontColor: selected == 3 ? primaryColorWhite : primaryColorBlack,
            text: "Tamil",
          ),
        ),
      ],
    );
  }
}
