import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:driver_app/theme/colors.dart';

class VehicleBox extends StatelessWidget {
  final String title;
  final String subTitle;
  final IconData icon;
  final int value;
  final int groupValue;
  final onChanged;
  VehicleBox({
    Key? key,
    required this.title,
    required this.subTitle,
    required this.icon,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: primaryColorWhite,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2.5),
            child: Row(
              children: [
                Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: primaryColorBlack,
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                    icon,
                    color: primaryColor,
                    size: 35,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Container(
                      height: 35,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                              color: primaryColorBlack,
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            subTitle,
                            style: TextStyle(
                              color: primaryColorBlack,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: primaryColorDark,
                    shape: BoxShape.circle,
                  ),
                  child: Radio(
                    value: value,
                    groupValue: groupValue,
                    onChanged: onChanged,
                    activeColor: primaryColorWhite,
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
          child: Divider(
            thickness: 1,
            color: primaryColorBlack,
            height: 0,
          ),
        ),
      ],
    );
  }
}
