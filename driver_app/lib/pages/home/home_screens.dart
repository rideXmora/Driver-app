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
bool search = false;
bool map = false;

class _HomeScreensState extends State<HomeScreens> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // if (map && tripState == TripState.TRIPCOMPLETED) {
        if (map) {
          setState(() {
            map = false;
          });
        } else if (search) {
          setState(() {
            search = false;
          });
        } else {
          SystemNavigator.pop();
        }
        return false;
      },
      child: Stack(
        children: [
          Center(
            child: HomeScreen(
              onTap: () {
                setState(() {
                  search = true;
                });
                Get.find<Controller>().increment();
              },
            ),
          ),
          search
              ? SearchLocationScreen(
                  onBack: () {
                    setState(() {
                      search = false;
                    });
                  },
                  toMap: () {
                    setState(() {
                      map = true;
                    });
                  },
                )
              : Container(),
          map
              ? MapScreen(onBack: () {
                  debugPrint("s");
                  setState(() {
                    map = false;
                  });
                })
              : Container(),
        ],
      ),
    );
  }
}
