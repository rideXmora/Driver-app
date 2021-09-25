import 'package:driver_app/pages/sign_in_up/pages/registration/documentation_screen.dart';
import 'package:driver_app/pages/sign_in_up/widgets/vechicle_selection_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:driver_app/pages/bottom_navigation_bar_handler.dart';
import 'package:driver_app/theme/colors.dart';
import 'package:driver_app/widgets/custom_back_button.dart';
import 'package:driver_app/widgets/custom_text_field.dart';
import 'package:driver_app/widgets/main_button.dart';

class SelectingVechicleTypeScreen extends StatefulWidget {
  SelectingVechicleTypeScreen({
    Key? key,
  }) : super(key: key);

  @override
  _SelectingVechicleTypeScreenState createState() =>
      _SelectingVechicleTypeScreenState();
}

class _SelectingVechicleTypeScreenState
    extends State<SelectingVechicleTypeScreen> {
  List<Map<String, dynamic>> vechicleList = [
    {
      "type": "Car",
      "image": "assets/images/images/car.png",
    },
    {
      "type": "Tuk",
      "image": "assets/images/images/tuk.png",
    },
    {
      "type": "Bike",
      "image": "assets/images/images/bike.png",
    },
  ];
  late int selectedVechicleIndex;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      selectedVechicleIndex = 0;
    });
  }

  void onTap() {}
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
                  CustomBackButton(),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Choose you vechicle type",
                    style: TextStyle(
                      color: primaryColorDark,
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 34,
                  ),
                  Column(
                    children: vechicleList.map((vechicle) {
                      return VechicleSelectionBox(
                        onTap: () {
                          setState(() {
                            selectedVechicleIndex =
                                vechicleList.indexOf(vechicle);
                          });
                        },
                        vechicle: vechicle,
                        selected: selectedVechicleIndex ==
                            vechicleList.indexOf(vechicle),
                      );
                    }).toList(),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: MainButton(
          loading: loading,
          width: width,
          height: height,
          onPressed: () async {
            if (!loading) {
              setState(() {
                loading = true;
              });

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => DocumentationScreen(),
                ),
              );
              setState(() {
                loading = false;
              });
            } else {
              setState(() {
                loading = false;
              });
            }
          },
          text: "CONTINUE",
          boxColor: primaryColorDark,
          shadowColor: primaryColorDark,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
