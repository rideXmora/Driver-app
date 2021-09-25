import 'package:driver_app/pages/sign_in_up/pages/registration/selecting_vchicle_type.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:driver_app/pages/bottom_navigation_bar_handler.dart';
import 'package:driver_app/theme/colors.dart';
import 'package:driver_app/widgets/custom_back_button.dart';
import 'package:driver_app/widgets/custom_text_field.dart';
import 'package:driver_app/widgets/main_button.dart';

class RegistrationScreen extends StatefulWidget {
  final String phoneNo;

  RegistrationScreen({
    Key? key,
    required this.phoneNo,
  }) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool edit = true;
  String dropdownValue = "+94";
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController organizationController = TextEditingController();
  List<String> organizations = ["a", "B", "c"];
  late int selectedOrganization;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      mobileNumberController.text = widget.phoneNo.substring(3, 5) +
          " " +
          widget.phoneNo.substring(5, 8) +
          " " +
          widget.phoneNo.substring(8, 12);
      selectedOrganization = 0;
      organizationController.text = organizations[0];
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: primaryColorWhite,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 45,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomBackButton(),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Let's be a\nRideX Driver",
                    style: TextStyle(
                      color: primaryColorDark,
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 34,
                  ),
                  CustomTextField(
                    readOnly: edit ? false : true,
                    height: height,
                    width: width,
                    controller: nameController,
                    hintText: "Full Name",
                    prefixBoxColor: primaryColorBlack,
                    prefixIcon: Icon(
                      Icons.person,
                      color: primaryColorLight,
                    ),
                    dropDown: SizedBox(),
                    onChanged: () {},
                    phoneNumberPrefix: SizedBox(),
                    suffix: SizedBox(),
                    inputFormatters: [],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  CustomTextField(
                    readOnly: edit ? false : true,
                    height: height,
                    width: width,
                    controller: emailController,
                    hintText: "Email",
                    prefixBoxColor: primaryColorBlack,
                    prefixIcon: Icon(
                      Icons.email,
                      color: primaryColorLight,
                    ),
                    dropDown: SizedBox(),
                    onChanged: () {},
                    phoneNumberPrefix: SizedBox(),
                    suffix: SizedBox(),
                    inputFormatters: [],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  CustomTextField(
                    readOnly: edit ? false : true,
                    height: height,
                    width: width,
                    controller: cityController,
                    hintText: "city",
                    prefixBoxColor: primaryColorBlack,
                    prefixIcon: Icon(
                      Icons.location_on_sharp,
                      color: primaryColorLight,
                    ),
                    dropDown: SizedBox(),
                    onChanged: () {},
                    phoneNumberPrefix: SizedBox(),
                    suffix: SizedBox(),
                    inputFormatters: [],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  CustomTextField(
                    readOnly: true,
                    height: height,
                    width: width,
                    controller: mobileNumberController,
                    hintText: "Mobile Number",
                    prefixBoxColor: primaryColorBlack,
                    prefixIcon: Icon(
                      Icons.phone,
                      color: primaryColorLight,
                    ),
                    dropDown: SizedBox(),
                    keyboardType: TextInputType.number,
                    onChanged: () {},
                    phoneNumberPrefixWidth: 110,
                    inputFormatters: [
                      MaskedInputFormatter("## ### ####",
                          allowedCharMatcher: RegExp(r'\d')),
                    ],
                    phoneNumberPrefix: Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        IgnorePointer(
                          ignoring: true,
                          child: DropdownButton<String>(
                            underline: SizedBox(),
                            value: dropdownValue,
                            icon: Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: primaryColorWhite,
                            ),
                            style: TextStyle(
                              color: primaryColorWhite,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownValue = newValue.toString();
                              });
                            },
                            dropdownColor: primaryColorLight,
                            items: <String>['+94']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(
                                    color: primaryColorWhite,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        Container(
                          margin:
                              const EdgeInsets.only(top: 13.0, bottom: 13.0),
                          child: VerticalDivider(
                            color: primaryColorWhite,
                            width: 1,
                          ),
                        ),
                      ],
                    ),
                    suffix: SizedBox(),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  CustomTextField(
                    readOnly: true,
                    height: height,
                    width: width,
                    controller: organizationController,
                    hintText: "Organization",
                    prefixBoxColor: primaryColorBlack,
                    prefixIcon: Icon(
                      Icons.location_city,
                      color: primaryColorLight,
                    ),
                    dropDown: SizedBox(),
                    onChanged: () {},
                    phoneNumberPrefix: SizedBox(),
                    suffix: IgnorePointer(
                      ignoring: edit ? false : true,
                      child: PopupMenuButton<String>(
                        padding: EdgeInsets.all(0),
                        icon: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: primaryColorWhite,
                        ),
                        onSelected: (String value) {
                          setState(() {
                            debugPrint(value);
                            organizationController.text = value;
                          });
                        },
                        itemBuilder: (BuildContext context) {
                          return organizations
                              .map<PopupMenuItem<String>>((String language) {
                            return PopupMenuItem(
                                child: Text(language), value: language);
                          }).toList();
                        },
                      ),
                    ),
                    inputFormatters: [],
                  ),
                  SizedBox(
                    height: 90,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
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

              // await addInstructor(context);
              String phoneNumber = dropdownValue.trim() +
                  mobileNumberController.text.replaceAll(" ", "");
              debugPrint(phoneNumber.length.toString());
              if (phoneNumber.length == 12) {
                Future.delayed(Duration(seconds: 3)).then((value) {
                  setState(() {
                    loading = false;
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) =>
                          SelectingVechicleTypeScreen(),
                    ),
                  );
                });
              } else {
                setState(() {
                  loading = false;
                });
              }
            }
          },
          text: "CONTINUE",
          boxColor: primaryColorDark,
          shadowColor: primaryColorDark,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
