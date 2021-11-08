import 'package:driver_app/controllers/user_controller.dart';
import 'package:driver_app/modals/vehicle.dart';
import 'package:driver_app/pages/sign_in_up/pages/registration/documentation_screen.dart';
import 'package:driver_app/pages/sign_in_up/widgets/ducument_box.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:driver_app/theme/colors.dart';
import 'package:driver_app/widgets/custom_back_button.dart';
import 'package:driver_app/widgets/main_button.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:driver_app/utils/config.dart';
import 'package:driver_app/utils/pickedMedia.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloudinary_public/cloudinary_public.dart';

class ProfilePicUploadScreen extends StatefulWidget {
  ProfilePicUploadScreen({Key? key}) : super(key: key);

  @override
  _ProfilePicUploadScreenState createState() => _ProfilePicUploadScreenState();
}

class _ProfilePicUploadScreenState extends State<ProfilePicUploadScreen> {
  bool loading = false;

  @override
  void initState() {
    super.initState();
  }

  late File _image;
  final picker = ImagePicker();
  String imageUrl = "false";

  Future _pickImageFromCamera() async {
    final pickedImagefile = await PickMedia.takeImageToUpload(
      cropImage: cropSquareImage,
    );

    if (pickedImagefile == null) {
      print('No image selected.');
      setState(() {
        loading = false;
      });
      Navigator.pop(context);
    } else {
      setState(() {
        _image = File(pickedImagefile.path);
      });
      Navigator.pop(context);

      await uploadImage();
      setState(() {
        loading = false;
      });
    }
  }

  Future _pickImageFromGalary() async {
    final pickedImagefile = await PickMedia.pickImageToUpload(
      cropImage: cropSquareImage,
    );

    if (pickedImagefile == null) {
      setState(() {
        loading = false;
      });
      print('No image selected.');
      Navigator.pop(context);
    } else {
      setState(() {
        _image = File(pickedImagefile.path);
      });
      Navigator.pop(context);
      await uploadImage();
      setState(() {
        loading = false;
      });
    }
  }

  Future<File> cropSquareImage(File imageFile) async {
    File? file = await ImageCropper.cropImage(
      sourcePath: imageFile.path,
      aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
      aspectRatioPresets: [CropAspectRatioPreset.square],
      compressQuality: 70,
      compressFormat: ImageCompressFormat.jpg,
      androidUiSettings: androidUiSettingsLocked(),
      iosUiSettings: iosUiSettingsLocked(),
    );

    return file != null ? file : File("");
  }

  IOSUiSettings iosUiSettingsLocked() => IOSUiSettings(
        rotateClockwiseButtonHidden: false,
        rotateButtonsHidden: false,
        aspectRatioLockEnabled: true,
      );

  AndroidUiSettings androidUiSettingsLocked() => AndroidUiSettings(
        toolbarTitle: 'Crop Image',
        toolbarColor: Colors.black,
        toolbarWidgetColor: Colors.white,
        lockAspectRatio: true,
        // hideBottomControls: true,
      );

  Future uploadImage() async {
    try {
      debugPrint(UPLOAD_PRESET);
      final cloudinary =
          CloudinaryPublic(CLOUD_NAME, UPLOAD_PRESET, cache: false);
      debugPrint(cloudinary.toString());
      CloudinaryResponse response = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(_image.path,
            resourceType: CloudinaryResourceType.Image),
      );
      setState(() {
        imageUrl = response.url;
      });
      print(response.url);
      print(imageUrl);
    } catch (e) {
      debugPrint(e.toString());
      print("error here");
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: primaryColorWhite,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: MainButton(
          loading: loading,
          width: width,
          height: height,
          onPressed: () async {
            if (imageUrl == "false") {
              Get.snackbar("Not selected an image!!!",
                  "First select an image to upload");
            } else {
              Vehicle vehicle = Get.find<UserController>().driver.value.vehicle;
              Get.find<UserController>().driver.update((val) {
                val!.vehicle = Vehicle(
                  number: vehicle.number,
                  vehicleType: vehicle.vehicleType,
                  model: vehicle.model,
                  license: vehicle.license,
                  insurance: vehicle.insurance,
                  vehicleRegNo: vehicle.vehicleRegNo,
                );
              });
              Get.back();
            }
          },
          text: "CONTINUE",
          boxColor: primaryColorDark,
          shadowColor: primaryColorDark,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
              vertical: 45,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                CustomBackButton(),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "Take your profile photo",
                  style: TextStyle(
                    color: primaryColorDark,
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  "Your profile photo helps people recognise you. Please note that once you have submitted your profile photo, it cannot be changed.",
                  style: TextStyle(
                    color: primaryColorBlack,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  "1. Face the camera and make sure your eyes and mouth are clearly visible.",
                  style: TextStyle(
                    color: primaryColorBlack,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "2. Make sure the photo is well lit, free of glare and in focus.",
                  style: TextStyle(
                    color: primaryColorBlack,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "3. No photos of a photo, filters or alterations.",
                  style: TextStyle(
                    color: primaryColorBlack,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Container(
                    height: 170,
                    width: 170,
                    child: Stack(
                      children: [
                        // * Image
                        imageUrl == "false"
                            ? Container(
                                width: 170,
                                height: 170,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                        "assets/images/images/user_icon.png"),
                                  ),
                                ),
                              )
                            : Container(
                                height: width * 0.7 * (3 / 4),
                                width: width * 0.7,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(
                                      imageUrl,
                                    ),
                                  ),
                                ),
                              ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(200),
                            ),
                            child: IconButton(
                              icon: Icon(Icons.camera_alt),
                              color: Colors.white,
                              iconSize: 25,
                              onPressed: () {
                                if (Platform.isIOS) {
                                  final action = CupertinoActionSheet(
                                    actions: <Widget>[
                                      CupertinoActionSheetAction(
                                        child: Text("Pick from Library"),
                                        isDefaultAction: true,
                                        onPressed: () async {
                                          setState(() {
                                            loading = true;
                                          });
                                          await _pickImageFromGalary();
                                          Navigator.pop(context);
                                        },
                                      ),
                                      CupertinoActionSheetAction(
                                        child: Text("Take a Photo"),
                                        isDestructiveAction: true,
                                        onPressed: () async {
                                          setState(() {
                                            loading = true;
                                          });
                                          await _pickImageFromCamera();
                                          Navigator.pop(context);
                                        },
                                      )
                                    ],
                                    cancelButton: CupertinoActionSheetAction(
                                      child: Text("Cancel"),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  );

                                  showCupertinoModalPopup(
                                      context: context,
                                      builder: (context) => action);
                                } else {
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (context) {
                                        return Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            ListTile(
                                              title: Center(
                                                  child: new Text(
                                                      'Pick from Library')),
                                              onTap: () async {
                                                setState(() {
                                                  loading = true;
                                                });
                                                await _pickImageFromGalary();
                                              },
                                            ),
                                            Divider(
                                              color: Colors.grey,
                                              height: 0.5,
                                            ),
                                            ListTile(
                                              title: Center(
                                                  child:
                                                      new Text('Take a Photo')),
                                              onTap: () async {
                                                setState(() {
                                                  loading = true;
                                                });
                                                await _pickImageFromCamera();
                                              },
                                            ),
                                            Divider(
                                              color: Colors.grey,
                                              height: 0.5,
                                            ),
                                            ListTile(
                                              title: Center(
                                                  child: new Text('Cancel')),
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ],
                                        );
                                      });
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
