import 'package:driver_app/controllers/auth_controller.dart';
import 'package:driver_app/controllers/user_controller.dart';
import 'package:driver_app/modals/driver.dart';
import 'package:driver_app/modals/vehicle.dart';
import 'package:driver_app/pages/sign_in_up/pages/registration/documentation_screen.dart';
import 'package:driver_app/pages/sign_in_up/widgets/vechicle_selection_box.dart';
import 'package:driver_app/utils/vehicle_type.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:driver_app/pages/bottom_navigation_bar_handler.dart';
import 'package:driver_app/theme/colors.dart';
import 'package:driver_app/widgets/custom_back_button.dart';
import 'package:driver_app/widgets/custom_text_field.dart';
import 'package:driver_app/widgets/main_button.dart';
import 'package:get/get.dart';

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
      "vehicle type": VehicleType.CAR,
    },
    {
      "type": "Tuk",
      "image": "assets/images/images/tuk.png",
      "vehicle type": VehicleType.THREE_WHEELER,
    },
    {
      "type": "Bike",
      "image": "assets/images/images/bike.png",
      "vehicle type": VehicleType.BIKE,
    },
  ];
  late int selectedVechicleIndex;
  bool loading = false;
  bool edit = true;
  TextEditingController numberController = TextEditingController();
  TextEditingController modelController = TextEditingController();

  @override
  void initState() {
    super.initState();
    setState(() {
      selectedVechicleIndex = 0;
    });
    fillFields();
  }

  Future<void> fillFields() async {
    Driver driver = Get.find<UserController>().driver.value;

    setState(() {
      numberController.text = driver.vehicle.number;
      modelController.text = driver.vehicle.model;
      selectedVechicleIndex = vechicleList.indexWhere(
          (element) => element['vehicle type'] == driver.vehicle.vehicleType);
    });
  }

  void onSubmitButton() async {
    if (!loading) {
      setState(() {
        loading = true;
      });

      Vehicle vehicle = Get.find<UserController>().driver.value.vehicle;

      Get.find<UserController>().addVehicleInfo(
        Vehicle(
          number: numberController.text.trim(),
          vehicleType: vechicleList[selectedVechicleIndex]["vehicle type"],
          model: modelController.text.trim(),
          license: vehicle.license,
          insurance: vehicle.insurance,
          vehicleRegNo: vehicle.vehicleRegNo,
        ),
        "type screen",
      );

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
      Vehicle vehicle = Get.find<UserController>().driver.value.vehicle;

      Get.find<UserController>().addVehicleInfo(
        Vehicle(
          number: numberController.text.trim(),
          vehicleType: vechicleList[selectedVechicleIndex]["vehicle type"],
          model: modelController.text.trim(),
          license: vehicle.license,
          insurance: vehicle.license,
          vehicleRegNo: vehicle.vehicleRegNo,
        ),
        "type screen",
      );

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
                    height: 16,
                  ),
                  CustomTextField(
                    readOnly: edit ? false : true,
                    height: height,
                    width: width,
                    controller: numberController,
                    hintText: "Vehicle number (ex: CAB 1665)",
                    prefixBoxColor: primaryColorBlack,
                    prefixIcon: Icon(
                      Icons.stay_current_landscape,
                      color: primaryColorLight,
                    ),
                    dropDown: SizedBox(),
                    onChanged: () {},
                    phoneNumberPrefix: SizedBox(),
                    suffix: SizedBox(),
                    inputFormatters: [],
                    textInputAction: TextInputAction.next,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  CustomTextField(
                    readOnly: edit ? false : true,
                    height: height,
                    width: width,
                    controller: modelController,
                    hintText: "Vehicle modal (ex: Toyota Vitz)",
                    prefixBoxColor: primaryColorBlack,
                    prefixIcon: Icon(
                      Icons.taxi_alert,
                      color: primaryColorLight,
                    ),
                    dropDown: SizedBox(),
                    onChanged: () {},
                    phoneNumberPrefix: SizedBox(),
                    suffix: SizedBox(),
                    inputFormatters: [],
                    onSubmit: onSubmitText,
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
          onPressed: onSubmitButton,
          text: "CONTINUE",
          boxColor: primaryColorDark,
          shadowColor: primaryColorDark,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
