import 'package:driver_app/pages/sign_in_up/widgets/ducument_box.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:driver_app/theme/colors.dart';
import 'package:driver_app/widgets/custom_back_button.dart';
import 'package:driver_app/widgets/main_button.dart';
import 'package:flutter_svg/svg.dart';

class DocumentationScreen extends StatefulWidget {
  DocumentationScreen({Key? key}) : super(key: key);

  @override
  _DocumentationScreenState createState() => _DocumentationScreenState();
}

class _DocumentationScreenState extends State<DocumentationScreen> {
  List<Map<String, dynamic>> dataList = [
    {
      "page": DocumentationScreen(),
      "icon": "assets/svgs/Profile pic.svg",
      "topic": "Profile Picture",
    },
    {
      "page": DocumentationScreen(),
      "icon": "assets/svgs/Id card.svg",
      "topic": "Driving License",
    },
    {
      "page": DocumentationScreen(),
      "icon": "assets/svgs/Detail card.svg",
      "topic": "Vehicle insurance (Third party/Private/Hiring)",
    },
    {
      "page": DocumentationScreen(),
      "icon": "assets/svgs/Detail card.svg",
      "topic": "Revenue License",
    },
    {
      "page": DocumentationScreen(),
      "icon": "assets/svgs/Detail card.svg",
      "topic": "Vehicle Registration Document",
    },
  ];
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
                  "Welcome, Avishka",
                  style: TextStyle(
                    color: primaryColorDark,
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: 7,
                ),
                Text(
                  "Complete following steps to set up your accout.",
                  style: TextStyle(
                    color: primaryColorDark,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: 34,
                ),
                Column(
                  children: dataList.map((data) {
                    return DocumentBox(
                      data: data,
                    );
                  }).toList(),
                ),
                SizedBox(
                  height: 50,
                ),
                MainButton(
                  loading: loading,
                  width: width,
                  height: height,
                  onPressed: () async {
                    if (!loading) {
                      setState(() {
                        loading = true;
                      });
//submitOTP();
                      Future.delayed(Duration(seconds: 3)).then((value) {
                        setState(() {
                          loading = false;
                        });
                        // Navigator.pushReplacement(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (BuildContext context) =>
                        //             RegistrationScreen(
                        //               phoneNo: widget.phoneNo,
                        //             )));
                      });
                    }
                  },
                  text: "CONTINUE",
                  boxColor: primaryColorDark,
                  shadowColor: primaryColorDark,
                ),
                SizedBox(
                  height: 15,
                ),
                Align(
                  alignment: Alignment.center,
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Didn't get a code?",
                          style: TextStyle(
                            color: primaryColorBlack,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextSpan(
                          text: " Resend",
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                          recognizer: TapGestureRecognizer()..onTap = () {},
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
