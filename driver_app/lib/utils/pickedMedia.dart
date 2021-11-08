import 'dart:io';

import 'package:image_picker/image_picker.dart';

class PickMedia {
  static Future<File> pickImageToUpload({
    required Future<File> Function(File file) cropImage,
  }) async {
    final source = ImageSource.gallery;
    final pickedFile = await ImagePicker().pickImage(source: source);

    // if (pickedFile == null) return null;

    if (cropImage == null) {
      return File(pickedFile!.path);
    } else {
      final file = File(pickedFile!.path);

      return cropImage(file);
    }
  }

  static Future<File> takeImageToUpload({
    required Future<File> Function(File file) cropImage,
  }) async {
    final source = ImageSource.camera;
    final pickedFile = await ImagePicker().pickImage(source: source);

    // if (pickedFile == null) return null;

    if (cropImage == null) {
      return File(pickedFile!.path);
    } else {
      final file = File(pickedFile!.path);

      return cropImage(file);
    }
  }
}
