import 'package:driver_app/pages/sign_in_up/pages/registration/documentation_screen.dart';
import 'package:driver_app/pages/sign_in_up/widgets/ducument_box.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:driver_app/theme/colors.dart';
import 'package:driver_app/widgets/custom_back_button.dart';
import 'package:driver_app/widgets/main_button.dart';
import 'package:flutter_svg/svg.dart';

class DrivingLicenseUploadScreen extends StatefulWidget {
  DrivingLicenseUploadScreen({Key? key}) : super(key: key);

  @override
  _DrivingLicenseUploadScreenState createState() =>
      _DrivingLicenseUploadScreenState();
}

class _DrivingLicenseUploadScreenState
    extends State<DrivingLicenseUploadScreen> {
  bool loading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: primaryColorWhite,
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

              Navigator.pushReplacement(
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
              vertical: 45,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                CustomBackButton(),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "Take a photo of your Driving License",
                  style: TextStyle(
                    color: primaryColorDark,
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  "Please make sure we can read all of the details easily.",
                  style: TextStyle(
                    color: primaryColorBlack,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Container(
                    height: width * 0.7 * (3 / 4) + 50,
                    width: width * 0.7 + 50,
                    child: Stack(
                      children: [
                        Center(
                          child: Container(
                            height: width * 0.7 * (3 / 4),
                            width: width * 0.7,
                            decoration: BoxDecoration(
                              color: Color(0xFFC4C4C4),
                            ),
                          ),
                        ),
                        // * Image
                        Center(
                          child: Container(
                            height: width * 0.4 * (3 / 4),
                            width: width * 0.4,
                            decoration: BoxDecoration(
                              color: Color(0xFFC4C4C4),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(
                                  "assets/images/images/detail_card_2.png",
                                ),
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: primaryColor,
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              icon: Icon(Icons.camera_alt),
                              color: Colors.white,
                              iconSize: 25,
                              onPressed: () {
                                //_pickImageFromToProfile(context);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
