import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:driver_app/pages/tirp_history/widgets/history_data_box.dart';
import 'package:driver_app/theme/colors.dart';

class TripHistoryScreen extends StatefulWidget {
  TripHistoryScreen({Key? key, this.onBack}) : super(key: key);
  final onBack;
  @override
  _TripHistoryScreenState createState() => _TripHistoryScreenState();
}

class _TripHistoryScreenState extends State<TripHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async {
        widget.onBack();

        return false;
      },
      child: Scaffold(
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
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Column(
                  children: [
                    HistoryDataBox(),
                    HistoryDataBox(),
                    HistoryDataBox(),
                    HistoryDataBox(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
