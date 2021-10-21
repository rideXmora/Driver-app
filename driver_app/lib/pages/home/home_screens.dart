import 'package:driver_app/widgets/dialog_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:driver_app/controllers/controller.dart';
import 'package:driver_app/pages/home/map_screens/pages/map_screen.dart';
import 'package:driver_app/pages/home/home_screens/pages/home_screen.dart';
import 'package:driver_app/pages/home/home_screens/pages/search_location_screen.dart';

class HomeScreens extends StatefulWidget {
  HomeScreens({Key? key}) : super(key: key);

  @override
  _HomeScreensState createState() => _HomeScreensState();
}

TextEditingController whereController = TextEditingController();

class _HomeScreensState extends State<HomeScreens> {
  bool dialogBox = false;
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        debugPrint("as");
        setState(() {
          dialogBox = !dialogBox;
        });

        return false;
      },
      child: Stack(
        children: [
          MapScreen(),
          dialogBox
              ? DialogBox(
                  topic: "Do you really want quit?",
                  loading: loading,
                  onTap: () {
                    if (!loading) {
                      setState(() {
                        dialogBox = false;
                      });
                    }
                  },
                  onNo: () {
                    if (!loading) {
                      setState(() {
                        dialogBox = false;
                      });
                    }
                  },
                  onYes: () async {
                    if (!loading) {
                      setState(() {
                        loading = true;
                      });
                      await Future.delayed(Duration(seconds: 2));
                      SystemNavigator.pop();
                      setState(() {
                        loading = false;
                      });
                    }
                  },
                )
              : Container(),
        ],
      ),
    );
  }
}
