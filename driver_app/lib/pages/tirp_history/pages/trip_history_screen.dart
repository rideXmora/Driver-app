import 'package:driver_app/controllers/user_controller.dart';
import 'package:driver_app/widgets/circular_loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:driver_app/pages/tirp_history/widgets/history_data_box.dart';
import 'package:driver_app/theme/colors.dart';
import 'package:get/get.dart';

class TripHistoryScreen extends StatefulWidget {
  TripHistoryScreen({Key? key, this.onBack}) : super(key: key);
  final onBack;
  @override
  _TripHistoryScreenState createState() => _TripHistoryScreenState();
}

class _TripHistoryScreenState extends State<TripHistoryScreen> {
  bool loading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    loadData();
  }

  Future<void> loadData() async {
    setState(() {
      loading = true;
    });
    await Get.find<UserController>().getPastTripDetails();
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async {
        widget.onBack();

        return false;
      },
      child: loading
          ? Scaffold(
              backgroundColor: primaryColorWhite,
              body: Center(
                child: CircularLoading(),
              ),
            )
          : Scaffold(
              backgroundColor: primaryColorWhite,
              appBar: AppBar(
                backgroundColor: primaryColorWhite,
                title: Text(
                  "Trip history",
                  style: TextStyle(
                    color: primaryColorBlack,
                    fontSize: 23,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                centerTitle: true,
                leading: Container(),
              ),
              body: Get.find<UserController>().pastTrips.value.length == 0
                  ? Center(
                      child: Text(
                        "No history detail yet...",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  : SafeArea(
                      child: SingleChildScrollView(
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.8,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 30,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 16),
                              child: Obx(
                                () => ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: Get.find<UserController>()
                                      .pastTrips
                                      .value
                                      .length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return HistoryDataBox(
                                      pastTrip: Get.find<UserController>()
                                          .pastTrips[index],
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
            ),
    );
  }
}
