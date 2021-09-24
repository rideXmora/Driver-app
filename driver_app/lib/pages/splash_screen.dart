import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:driver_app/controllers/auth_controller.dart';
import 'package:driver_app/theme/colors.dart';
import 'package:driver_app/widgets/circular_loading.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  AuthController authController = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();

    authController.loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColorWhite,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage(
                "assets/logo/logo.png",
              ),
            ),
            SizedBox(
              height: 20,
            ),
            CircularLoading(),
          ],
        ),
      ),
    );
  }
}
