import 'package:driver_app/controllers/auth_controller.dart';
import 'package:driver_app/controllers/organization_controller.dart';
import 'package:driver_app/controllers/user_controller.dart';
import 'package:driver_app/modals/driver.dart';
import 'package:driver_app/modals/organization.dart';
import 'package:driver_app/utils/language.dart';
import 'package:driver_app/widgets/circular_loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:driver_app/theme/colors.dart';
import 'package:driver_app/widgets/custom_text_field.dart';
import 'package:driver_app/widgets/secondary_button.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  TextEditingController cityController = TextEditingController();
  TextEditingController organizationController = TextEditingController();
  late List<String> organizations = ["No organization"];
  late List<Organization> allOrgs;
  late int selectedOrganization;
  bool loading = false;
  bool pageLoading = false;
  List<String> languageList = ["English", "Sinhala", "Tamil"];
  bool change = false;

  @override
  void initState() {
    super.initState();
    fillFields();
  }

  Future<void> fillFields() async {
    setState(() {
      pageLoading = true;
    });
    SharedPreferences store = await SharedPreferences.getInstance();
    await getOrganizations();
    setState(() {
      Driver driver = Get.find<UserController>().driver.value;
      mobileNumberController.text = driver.phone.substring(3, 5) +
          " " +
          driver.phone.substring(5, 8) +
          " " +
          driver.phone.substring(8, 12);
      nameController.text = driver.name;
      emailController.text = driver.email;
      cityController.text = driver.city;
      debugPrint("as" + driver.driverOrganization.name.toString());
      debugPrint("asq" + organizations.toString());
      if (driver.driverOrganization.name != "") {
        selectedOrganization =
            organizations.indexOf(driver.driverOrganization.name);
        organizationController.text = organizations[selectedOrganization];
      }

      String lan = LanguageUtils.getLanguage(store.getString("lan")!);
      languageController.text = lan;
    });
    setState(() {
      pageLoading = false;
    });
  }

  Future<void> getOrganizations() async {
    SharedPreferences store = await SharedPreferences.getInstance();
    allOrgs = await Get.find<OrganizationController>()
        .allOrg(token: Get.find<UserController>().driver.value.token);
    setState(() {
      organizations = allOrgs.map((org) => org.name).toList();
      selectedOrganization = 0;
      organizationController.text = organizations[0];
    });
    debugPrint("org" + allOrgs.toString());
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
      if (!loading) {
        setState(() {
          loading = true;
        });

        if (await checkChange()) {
          // bool changed = await Get.find<UserController>().changeProfile(
          //   name: nameController.text.trim(),
          //   email: emailController.text.trim(),
          //   language: languageController.text.trim(),
          // );
          // if (changed) {
          //   edit = false;
          // }
        } else {
          Get.snackbar(
              "No change", "First edit your info. Nothing has changed so far");
        }
        setState(() {
          loading = false;
        });
      }
    }
  }

  Future<bool> checkChange() async {
    UserController userController = Get.find<UserController>();
    String name = userController.driver.value.name;
    String email = userController.driver.value.email;
    SharedPreferences store = await SharedPreferences.getInstance();
    String lan = LanguageUtils.getLanguage(store.getString("lan")!);

    bool changed = false;
    if (name != nameController.text.trim()) {
      changed = true;
    } else if (email != emailController.text.trim()) {
      debugPrint("a");
      changed = true;
    } else if (lan != languageController.text.trim()) {
      debugPrint(lan);
      debugPrint(languageController.text.trim());
      debugPrint("a");
      changed = true;
    }

    return changed;
  }

  void editOnPressed() async {
    if (!pageLoading) {
      setState(() {
        edit = !edit;
      });
      if (!edit) {
        setState(() {
          pageLoading = true;
        });
        await fillFields();
        setState(() {
          pageLoading = false;
        });
      }
      debugPrint(edit.toString());
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
      child: pageLoading
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
                  // edit
                  //     ? Container()
                  //     : Padding(
                  //         padding: const EdgeInsets.only(
                  //           right: 10,
                  //           top: 10,
                  //           bottom: 10,
                  //         ),
                  //         child: SecondaryButton(
                  //           onPressed: editOnPressed,
                  //           text: !edit ? "Edit" : "Cancel",
                  //           boxColor: primaryColorDark,
                  //           shadowColor: primaryColorDark.withOpacity(0),
                  //           width: 100,
                  //         ),
                  //       ),
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
                                            borderRadius:
                                                BorderRadius.circular(200),
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
                          textInputAction: TextInputAction.next,
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
                          textInputAction: TextInputAction.next,
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
                                                dropdownValue =
                                                    newValue.toString();
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
                                return languageList.map<PopupMenuItem<String>>(
                                    (String language) {
                                  return PopupMenuItem(
                                      child: Text(language), value: language);
                                }).toList();
                              },
                            ),
                          ),
                          inputFormatters: [],
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
                                  selectedOrganization =
                                      organizations.indexOf(value);
                                });
                              },
                              itemBuilder: (BuildContext context) {
                                return organizations.map<PopupMenuItem<String>>(
                                    (String language) {
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
