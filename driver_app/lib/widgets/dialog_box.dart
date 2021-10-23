import 'package:flutter/material.dart';
import 'package:driver_app/theme/colors.dart';
import 'package:driver_app/widgets/circular_loading.dart';

class DialogBox extends StatelessWidget {
  const DialogBox({
    Key? key,
    this.onYes,
    this.onNo,
    this.onTap,
    required this.loading,
    required this.topic,
  }) : super(key: key);
  final onYes;
  final onNo;
  final onTap;
  final bool loading;
  final String topic;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            color: primaryColorBlack.withOpacity(0.5),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Container(
            decoration: BoxDecoration(
              color: primaryColorWhite,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Material(
                    child: Text(
                      topic,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      RawMaterialButton(
                        fillColor: Colors.white,
                        child: Padding(
                          padding: EdgeInsets.all(1.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const <Widget>[
                              Text(
                                "No",
                                maxLines: 1,
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                        onPressed: onNo,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            side: BorderSide(color: Colors.grey)),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      RawMaterialButton(
                        fillColor: primaryColor,
                        splashColor: primaryColor,
                        child: Padding(
                          padding: EdgeInsets.all(1.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const <Widget>[
                              Text(
                                "Yes",
                                maxLines: 1,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                        onPressed: onYes,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            side: BorderSide(color: Colors.grey)),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        loading
            ? Align(
                alignment: Alignment.center,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: primaryColorBlack.withOpacity(0.5),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularLoading(),
                    ],
                  ),
                ),
              )
            : Container(),
      ],
    );
  }
}
