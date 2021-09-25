import 'package:driver_app/pages/sign_in_up/pages/registration/documentation_screen.dart';
import 'package:driver_app/pages/sign_in_up/widgets/ducument_box.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:driver_app/theme/colors.dart';
import 'package:driver_app/widgets/custom_back_button.dart';
import 'package:driver_app/widgets/main_button.dart';
import 'package:flutter_svg/svg.dart';

class ProfilePicUploadScreen extends StatefulWidget {
  ProfilePicUploadScreen({Key? key}) : super(key: key);

  @override
  _ProfilePicUploadScreenState createState() => _ProfilePicUploadScreenState();
}

class _ProfilePicUploadScreenState extends State<ProfilePicUploadScreen> {
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
                  "Take your profile photo",
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
                  "Your profile photo helps people recognise you. Please note that once you have submitted your profile photo, it cannot be changed.",
                  style: TextStyle(
                    color: primaryColorBlack,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  "1. Face the camera and make sure your eyes and mouth are clearly visible.",
                  style: TextStyle(
                    color: primaryColorBlack,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "2. Make sure the photo is well lit, free of glare and in focus.",
                  style: TextStyle(
                    color: primaryColorBlack,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "3. No photos of a photo, filters or alterations.",
                  style: TextStyle(
                    color: primaryColorBlack,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Container(
                    height: 170,
                    width: 170,
                    child: Stack(
                      children: [
                        // * Image
                        Container(
                          width: 170,
                          height: 170,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                  "assets/images/images/user_icon.png"),
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
                              borderRadius: BorderRadius.circular(200),
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
