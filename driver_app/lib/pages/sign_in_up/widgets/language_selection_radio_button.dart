import 'package:flutter/material.dart';
import 'package:driver_app/pages/sign_in_up/widgets/language_box.dart';
import 'package:driver_app/theme/colors.dart';

class LanguageSelectionRadioButton extends StatelessWidget {
  const LanguageSelectionRadioButton(
      {Key? key,
      required this.selected,
      this.onTap_1,
      this.onTap_2,
      this.onTap_3})
      : super(key: key);
  final int selected;
  final onTap_1;
  final onTap_2;
  final onTap_3;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap_1,
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
          onTap: onTap_2,
          child: LanguageBox(
            backgroundColor: selected == 2 ? primaryColor : primaryColorWhite,
            borderColor: primaryColorBlack,
            fontColor: selected == 2 ? primaryColorWhite : primaryColorBlack,
            text: "සිංහල",
          ),
        ),
        SizedBox(
          height: 25,
        ),
        GestureDetector(
          onTap: onTap_3,
          child: LanguageBox(
            backgroundColor: selected == 3 ? primaryColor : primaryColorWhite,
            borderColor: primaryColorBlack,
            fontColor: selected == 3 ? primaryColorWhite : primaryColorBlack,
            text: "தமிழ்",
          ),
        ),
      ],
    );
  }
}
