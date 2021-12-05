import 'dart:io';

import 'package:driver_app/controllers/ride_controller.dart';
import 'package:driver_app/controllers/user_controller.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseNotifications {
  late FirebaseMessaging _messaging;

  Future<void> setupFirebase() async {
    _messaging = FirebaseMessaging.instance;
    await firebaseCloudMessageListner();
  }

  Future<void> firebaseCloudMessageListner() async {
    // check if app is opened with message
    await FirebaseMessaging.instance.getInitialMessage();

    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    print('User granted permission: ${settings.authorizationStatus}');

    await _messaging.setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );
  }

  //TODO
  Future<String> getToken() async {
    var token = await _messaging.getToken();

    print('My token 1: $token ');
    return token.toString();
  }

  Future<void> startListening() async {
    await FirebaseMessaging.instance.getInitialMessage();
// listen to foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint("new foreground message");
      if (message.notification != null) {
        debugPrint(message.notification!.title);
        debugPrint(message.notification!.body);
        debugPrint(message.data.toString());
        debugPrint("id: " + message.data['id']);
        //{passengerName: Ksr Raj, passengerPhone: +94772597206, startLocationX: 12.123454, startLocationY: 12.123454, id: 61828f08bac86e6a352bd80e, passengerRating: 4.0}

        if (message.data['id'] != null) {
          debugPrint("id");
          String passengerName = message.data['passengerName'];
          String passengerPhone = message.data['passengerPhone'];
          String startLocationX = message.data['startLocationX'];
          String startLocationY = message.data['startLocationY'];
          String endLocationX = message.data['endLocationX'];
          String endLocationY = message.data['endLocationY'];
          String id = message.data['id'];
          String passengerRating = message.data['passengerRating'];

          Get.find<RideController>().getRideRequest(
            id,
            passengerName,
            passengerPhone,
            startLocationX,
            startLocationY,
            passengerRating,
            endLocationX,
            endLocationY,
          );
        } else {
          debugPrint("error  - no id");
        }
      }
    });

    // listen to os notification clicks
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint("new background message");
      if (message.notification != null) {
        debugPrint(message.notification!.title);
        debugPrint(message.notification!.body);
        debugPrint(message.data.toString());
        debugPrint("id: " + message.data['id']);
        //{passengerName: Ksr Raj, passengerPhone: +94772597206, startLocationX: 12.123454, startLocationY: 12.123454, id: 61828f08bac86e6a352bd80e, passengerRating: 4.0}

        if (message.data['id'] != null) {
          debugPrint("id");
          String passengerName = message.data['passengerName'];
          String passengerPhone = message.data['passengerPhone'];
          String startLocationX = message.data['startLocationX'];
          String startLocationY = message.data['startLocationY'];
          String endLocationX = message.data['endLocationX'];
          String endLocationY = message.data['endLocationY'];
          String id = message.data['id'];
          String passengerRating = message.data['passengerRating'];

          Get.find<RideController>().getRideRequest(
            id,
            passengerName,
            passengerPhone,
            startLocationX,
            startLocationY,
            passengerRating,
            endLocationX,
            endLocationY,
          );
        } else {
          debugPrint("error  - no id");
        }
      }
    });
  }

  Future<void> subscribeTopic(String topic) async {
    _messaging = FirebaseMessaging.instance;
    await _messaging.subscribeToTopic(topic);
  }

  Future<void> unSubscribeTopic(String topic) async {
    _messaging = FirebaseMessaging.instance;
    await _messaging.unsubscribeFromTopic(topic);
  }
}
