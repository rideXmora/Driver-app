import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:driver_app/pages/home/map_screens/widgets/vehicle_Selection_RadioButton.dart';
import 'package:driver_app/theme/colors.dart';
import 'package:driver_app/widgets/secondary_button.dart';

class SelectVechicleTypeFloatingPanel extends StatelessWidget {
  SelectVechicleTypeFloatingPanel({
    Key? key,
    required this.paymentMethod,
    required this.methods,
    required this.slectedMethod,
    this.onSelect,
    required this.loading,
    this.onPressed,
  }) : super(key: key);

  final onPressed;
  final TextEditingController paymentMethod;
  final List<Map<String, dynamic>> methods;
  final int slectedMethod;
  final onSelect;

  final bool loading;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
          color: primaryColorDark,
          borderRadius: BorderRadius.all(Radius.circular(17)),
          boxShadow: [
            BoxShadow(
              blurRadius: 5,
              color: primaryColorDark,
            ),
          ]),
      margin: const EdgeInsets.only(
        left: 15,
        right: 15,
        bottom: 10,
        top: 24,
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: VehicleSelectionRadioButton(),
              ),
            ),
            Container(
              height: 40,
              child: TextField(
                readOnly: true,
                style: TextStyle(
                  color: primaryColorWhite,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                controller: paymentMethod,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 8),
                  prefixIcon: Icon(
                    methods[slectedMethod]["Icon"],
                    color: primaryColor,
                  ),
                  suffixIcon: PopupMenuButton<String>(
                    padding: EdgeInsets.all(0),
                    icon: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: primaryColorWhite,
                    ),
                    onSelected: onSelect,
                    itemBuilder: (BuildContext context) {
                      return methods.map<PopupMenuItem<String>>((Map method) {
                        return PopupMenuItem(
                            child: Text(method["method"]),
                            value: method["index"].toString());
                      }).toList();
                    },
                  ),
                  suffixIconConstraints: BoxConstraints(
                    minWidth: 0,
                  ),
                  prefixIconConstraints: BoxConstraints(
                    minWidth: 20,
                  ),
                ),
              ),
            ),
            SecondaryButton(
              width: MediaQuery.of(context).size.width * 0.4,
              onPressed: onPressed,
              loading: loading,
              text: "Confirm",
              boxColor: primaryColorLight,
              shadowColor: Colors.transparent,
            )
          ],
        ),
      ),
    );
  }
}
