import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:driver_app/pages/sign_in_up/pages/registration_screen.dart';
import 'package:driver_app/theme/colors.dart';
import 'package:driver_app/widgets/custom_back_button.dart';
import 'package:driver_app/widgets/main_button.dart';
import 'package:pinput/pin_put/pin_put.dart';

class MobileNumberVerificationScreen extends StatefulWidget {
  final String phoneNo;
  final String page;
  MobileNumberVerificationScreen(
      {Key? key, required this.phoneNo, required this.page})
      : super(key: key);

  @override
  _MobileNumberVerificationScreenState createState() =>
      _MobileNumberVerificationScreenState();
}

class _MobileNumberVerificationScreenState
    extends State<MobileNumberVerificationScreen> {
  String verificationId = "";

  bool codeSent = false;
  bool loading = false;

  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    //verifyPhone(widget.phoneNo);
  }

  // Future<void> verifyPhone(String phoneNo) async {
  //   final PhoneVerificationCompleted verified = (AuthCredential authResult) {
  //     print("Code verification completed: $phoneNo");
  //     try {
  //       AuthenticationService().signIn(authResult);
  //       loginSuccess();
  //     } catch (e) {
  //       print(e);
  //       loginFailed();
  //     }
  //   };

  //   final PhoneVerificationFailed verificationfailed =
  //       (FirebaseAuthException authException) {
  //     print("Code verification failed: $phoneNo, ${authException.message}");
  //     loginFailed();
  //   };

  //   final PhoneCodeSent smsSent = (String verId, [int forceResend]) {
  //     print("Code sent: $phoneNo");
  //     this.verificationId = verId;
  //     setState(() {
  //       loading = false;
  //     });
  //   };

  //   final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
  //     print("Code auto retrieval timeout: $phoneNo");
  //     this.verificationId = verId;
  //   };

  //   try {
  //     await FirebaseAuth.instance.verifyPhoneNumber(
  //         phoneNumber: phoneNo,
  //         timeout: const Duration(seconds: 30),
  //         verificationCompleted: verified,
  //         verificationFailed: verificationfailed,
  //         codeSent: smsSent,
  //         codeAutoRetrievalTimeout: autoTimeout);
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  // void submitOTP() async {
  //   // verift otp
  //   // send to sign up detail page if successful
  //   // start signup again if failed
  //   // do nothing if pin is not entered

  //   String otp = _pinPutController.text;
  //   if (otp.length == 6) {
  //     setState(() {
  //       loading = true;
  //     });
  //     try {
  //       await AuthenticationService().signInWithOTP(otp, verificationId);
  //       loginSuccess();
  //     } catch (e) {
  //       print(e);
  //       loginFailed();
  //     }
  //   }
  // }

  // void loginSuccess() async {
  //   User firebaseUser = FirebaseAuth.instance.currentUser;
  //   AppConstant.USER_ID = firebaseUser.uid;
  //   AppConstant.PHONE_NO = firebaseUser.phoneNumber;

  //   print("Auth passed: ${firebaseUser.uid}");

  //   // check if user has a customer account
  //   if (await DatabaseService().getMyCustomer(AppConstant.USER_ID) != null) {
  //     await CustomerService().getMyCustomer(AppConstant.USER_ID);
  //     setState(() {
  //       loading = false;
  //     });
  //     Navigator.pushAndRemoveUntil(
  //         context,
  //         PageTransition(
  //             type: PageTransitionType.fade,
  //             duration: Duration(milliseconds: 0),
  //             child: NewsFeedPage()),
  //         (route) => false);
  //     //Navigator.of(context).pushReplacement(pageRoute(NewsFeedPage()));
  //   } else {
  //     setState(() {
  //       loading = false;
  //     });
  //     pageReplacementTransition(context, SignUpPage(),
  //         Duration(milliseconds: 0), PageTransitionType.fade);
  //     //Navigator.of(context).pushReplacement(pageRoute(SignUpPage()));
  //   }
  // }

  // void loginFailed() {
  //   print("Auth failed");
  //   Get.snackbar("Login failed!", "Please try again.");
  //   // pageTransition(
  //   //     context,
  //   //     VerifyMobilePage(
  //   //       phoneNo: phoneNo,
  //   //     ),
  //   //     Duration(milliseconds: 0),
  //   //     PageTransitionType.fade);
  //   //
  //   setState(() {
  //     loading = false;
  //   });
  //   Navigator.pushAndRemoveUntil(
  //       context,
  //       PageTransition(
  //           type: PageTransitionType.fade,
  //           duration: Duration(milliseconds: 0),
  //           child: MobileSignUpInPage()),
  //       (route) => false);
  //   // Navigator.of(context).pushReplacement(pageRoute(MobileSignUpInPage()));
  // }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: primaryColorWhite,
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
                  "Confirm your number",
                  style: TextStyle(
                    color: primaryColorDark,
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 7,
                ),
                RichText(
                  textAlign: TextAlign.left,
                  maxLines: 2,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Enter the 6-digit code app just sent to",
                        style: TextStyle(
                          color: primaryColorDark,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextSpan(
                        text: "${width > 310 ? '\n' : ' '}" +
                            widget.phoneNo.substring(0, 3) +
                            " " +
                            widget.phoneNo.substring(3, 5) +
                            " " +
                            widget.phoneNo.substring(5, 8) +
                            " " +
                            widget.phoneNo.substring(8, 12),
                        style: TextStyle(
                          color: primaryColorDark,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                  width: width - 60,
                  child: PinPut(
                    fieldsCount: 6,
                    eachFieldHeight: ((width - 80) / 6) * 0.11,
                    eachFieldWidth: ((width - 80) / 6) * 0.11,
                    textStyle: TextStyle(
                      color: primaryColorBlack,
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                    ),
                    onSubmit: (String pin) {
//submitOTP();
                    },
                    focusNode: _pinPutFocusNode,
                    controller: _pinPutController,
                    submittedFieldDecoration: BoxDecoration(
                      color: primaryColor,
                      border: Border.all(color: primaryColorLight),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    selectedFieldDecoration: BoxDecoration(
                      color: primaryColorLight.withOpacity(0.5),
                      border: Border.all(color: primaryColorBlack),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    followingFieldDecoration: BoxDecoration(
                      color: primaryColorLight,
                      border: Border.all(color: primaryColorLight),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                MainButton(
                  loading: loading,
                  width: width,
                  height: height,
                  onPressed: () async {
                    if (!loading) {
                      setState(() {
                        loading = true;
                      });
//submitOTP();
                      Future.delayed(Duration(seconds: 3)).then((value) {
                        setState(() {
                          loading = false;
                        });
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    RegistrationScreen(
                                      phoneNo: widget.phoneNo,
                                    )));
                      });
                    }
                  },
                  text: "CONTINUE",
                  boxColor: primaryColorDark,
                  shadowColor: primaryColorDark,
                ),
                SizedBox(
                  height: 15,
                ),
                Align(
                  alignment: Alignment.center,
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Didn't get a code?",
                          style: TextStyle(
                            color: primaryColorBlack,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextSpan(
                          text: " Resend",
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                          recognizer: TapGestureRecognizer()..onTap = () {},
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
