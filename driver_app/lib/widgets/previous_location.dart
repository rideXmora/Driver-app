import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:driver_app/theme/colors.dart';

class PreviousLocation extends StatelessWidget {
  final String title;
  final String subTitle;
  final IconData icon;
  final bool divider;
  PreviousLocation({
    Key? key,
    required this.title,
    required this.subTitle,
    required this.icon,
    required this.divider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            height: 50,
            child: Row(
              children: [
                Container(
                  width: 35,
                  height: 35,
                  alignment: Alignment.center,
                  child: Icon(
                    icon,
                    color: primaryColorBlack,
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
              ],
            ),
          ),
        ),
        divider
            ? Divider(
                thickness: 1,
                color: primaryColorDark,
                height: 0,
              )
            : Container(),
      ],
    );
  }
}
