import 'package:get/get.dart';

bool isEmailValid(String email) {
  if (email.length == 0) {
    Get.snackbar("E-mail is not valid!!!", "E-mail field cannot be empty");
    return false;
  } else if (!RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email)) {
    Get.snackbar("E-mail is not valid!!!", "Please check your E-mail");
    return false;
  } else {
    return true;
  }
}
