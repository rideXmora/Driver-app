import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:driver_app/controllers/controller.dart';
import 'package:driver_app/theme/colors.dart';
import 'package:driver_app/widgets/custom_text_field.dart';
import 'package:driver_app/widgets/previous_location.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({
    Key? key,
    required this.onTap,
  }) : super(key: key);
  final onTap;
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: primaryColorWhite,
      appBar: AppBar(
        backgroundColor: primaryColorWhite,
        title: Text(
          "Home",
          style: TextStyle(
            color: primaryColorBlack,
            fontSize: 23,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        leading: Container(),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: height * 0.35,
              color: primaryColorDark,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 0,
                        bottom: 0,
                      ),
                      child: Container(
                        height: height * 0.3,
                        width: width * 0.75,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              "assets/svgs/passenger_home_image.png",
                            ),
                            fit: BoxFit.contain,
                            alignment: Alignment.centerRight,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 21,
                        bottom: 34,
                      ),
                      child: Container(
                        child: Text(
                          "Stay Safe &\nWear a Mask",
                          style: TextStyle(
                            color: primaryColorWhite,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  SizedBox(
                    height: 18,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Obx(
                      () => GestureDetector(
                        onTap: widget.onTap,
                        child: Stack(
                          children: [
                            CustomTextField(
                              readOnly: true,
                              height: height,
                              width: width,
                              // controller: whereController,
                              controller: TextEditingController(
                                  text: Get.find<Controller>()
                                      .counter
                                      .value
                                      .toString()),
                              hintText: "Where to ...",
                              prefixBoxColor: primaryColorBlack,
                              prefixIcon: Icon(
                                Icons.location_on_rounded,
                                color: primaryColorLight,
                              ),
                              dropDown: SizedBox(),
                              onChanged: () {},
                              phoneNumberPrefix: SizedBox(),
                              suffix: SizedBox(),
                              inputFormatters: [],
                            ),
                            Container(
                              width: width,
                              height: 54,
                              color: Colors.transparent,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 27),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: primaryColorDark,
                              ),
                            ),
                            child: Column(
                              children: [
                                PreviousLocation(
                                  icon: Icons.home_rounded,
                                  divider: true,
                                  title: "Home",
                                  subTitle: "Anandarama Rd, Moratuwa.",
                                ),
                                PreviousLocation(
                                  icon: Icons.history,
                                  divider: true,
                                  title: "Katubedda Bus Stop",
                                  subTitle: "Anandarama Rd, Moratuwa.",
                                ),
                                PreviousLocation(
                                  icon: Icons.history,
                                  divider: true,
                                  title: "Katubedda Bus Stop",
                                  subTitle: "Anandarama Rd, Moratuwa.",
                                ),
                                PreviousLocation(
                                  icon: Icons.history,
                                  divider: false,
                                  title: "Katubedda Bus Stop",
                                  subTitle: "Anandarama Rd, Moratuwa.",
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
