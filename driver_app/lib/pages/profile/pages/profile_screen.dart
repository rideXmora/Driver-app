import 'package:driver_app/controllers/auth_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:driver_app/theme/colors.dart';
import 'package:driver_app/widgets/custom_text_field.dart';
import 'package:driver_app/widgets/secondary_button.dart';
import 'package:get/get.dart';

import 'card_page.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key, this.onBack}) : super(key: key);
  final onBack;

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool edit = false;
  String dropdownValue = "+94";
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController languageController = TextEditingController();
  bool loading = false;
  List<String> languageList = ["English", "Sinhala", "Tamil"];

  @override
  void initState() {
    super.initState();
    languageController.text = languageList[0];
  }

  void mainSubmitOnPressed() async {
    if (!edit) {
      if (!loading) {
        setState(() {
          loading = true;
        });
        await Get.find<AuthController>().signOut();
        setState(() {
          loading = false;
        });
      }
    } else {
      // if (!loading) {
      //   setState(() {
      //     loading = true;
      //   });

      //   if (await checkChange()) {
      //     bool changed = await Get.find<UserController>().changeProfile(
      //       name: nameController.text.trim(),
      //       email: emailController.text.trim(),
      //       language: languageController.text.trim(),
      //     );
      //     if (changed) {
      //       edit = false;
      //     }
      //   } else {
      //     Get.snackbar(
      //         "No change", "First edit your info. Nothing has changed so far");
      //   }
      //   setState(() {
      //     loading = false;
      //   });
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async {
        if (edit) {
          setState(() {
            edit = false;
          });
        } else if (!edit) {
          widget.onBack();
        }
        return false;
      },
      child: Scaffold(
        backgroundColor: primaryColorWhite,
        appBar: AppBar(
          backgroundColor: primaryColorWhite,
          title: Text(
            "Profile",
            style: TextStyle(
              color: primaryColorBlack,
              fontSize: 23,
              fontWeight: FontWeight.w700,
            ),
          ),
          centerTitle: true,
          leading: Container(),
          actions: [
            edit
                ? Container()
                : Padding(
                    padding: const EdgeInsets.only(
                      right: 10,
                      top: 10,
                      bottom: 10,
                    ),
                    child: SecondaryButton(
                      onPressed: () {
                        setState(() {
                          edit = !edit;
                        });
                        debugPrint(edit.toString());
                      },
                      text: "Edit",
                      boxColor: primaryColorDark,
                      shadowColor: primaryColorDark.withOpacity(0),
                      width: 100,
                    ),
                  ),
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 30,
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 17,
                  ),
                  Center(
                    child: Container(
                      height: 115,
                      width: 115,
                      child: Stack(
                        children: [
                          // * Image
                          Container(
                            width: 115,
                            height: 115,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(
                                    "assets/images/images/user_icon.png"),
                              ),
                            ),
                          ),
                          edit
                              ? Align(
                                  alignment: Alignment.bottomRight,
                                  child: Container(
                                    width: 35,
                                    height: 35,
                                    decoration: BoxDecoration(
                                      color: primaryColor,
                                      borderRadius: BorderRadius.circular(200),
                                    ),
                                    child: IconButton(
                                      icon: Icon(Icons.camera_alt),
                                      color: Colors.white,
                                      iconSize: 18,
                                      onPressed: () {
                                        //_pickImageFromToProfile(context);
                                      },
                                    ),
                                  ),
                                )
                              : Container(),
                        ],
                      ),
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
                    hintText: "Name",
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
                  edit
                      ? Container()
                      : Column(
                          children: [
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
                                          .map<DropdownMenuItem<String>>(
                                              (String value) {
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
                                    margin: const EdgeInsets.only(
                                        top: 13.0, bottom: 13.0),
                                    child: VerticalDivider(
                                      color: primaryColorWhite,
                                      width: 1,
                                    ),
                                  ),
                                ],
                              ),
                              suffix: SizedBox(),
                            ),
                          ],
                        ),
                  SizedBox(
                    height: 16,
                  ),
                  CustomTextField(
                    readOnly: true,
                    height: height,
                    width: width,
                    controller: languageController,
                    hintText: "Language",
                    prefixBoxColor: primaryColorBlack,
                    prefixIcon: Icon(
                      Icons.language,
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
                            languageController.text = value;
                          });
                        },
                        itemBuilder: (BuildContext context) {
                          return languageList
                              .map<PopupMenuItem<String>>((String language) {
                            return PopupMenuItem(
                                child: Text(language), value: language);
                          }).toList();
                        },
                      ),
                    ),
                    inputFormatters: [],
                  ),
                  edit
                      ? Container()
                      : Column(
                          children: [
                            SizedBox(
                              height: 16,
                            ),
                            GestureDetector(
                              onTap: () {
                                debugPrint("saf");
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            MyCardsScreen()));
                              },
                              child: Text(
                                "View card details",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                  SizedBox(
                    height: 32,
                  ),
                  SecondaryButton(
                      loading: loading,
                      onPressed: mainSubmitOnPressed,
                      text: edit ? "Update" : "Sign out",
                      boxColor: primaryColorDark,
                      shadowColor: primaryColorDark.withOpacity(0),
                      width: width * 0.5)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
