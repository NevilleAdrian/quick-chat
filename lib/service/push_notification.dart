import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';


class PushNotification {
  final FirebaseMessaging _fbm = FirebaseMessaging();

  void initialize() {
    if (Platform.isIOS) {
      //require IOS permission
      _fbm.requestNotificationPermissions(IosNotificationSettings());
    }

    _fbm.configure(
        //called when app is in foreground and notification comes
        onMessage: (Map<String, dynamic> message) async {
      print('onMessage: $message');
      var notificationData = message['notification'];

      print('done');
    },
        //called when app has been closed completely and it's opened from notification drawer
        onLaunch: (Map<String, dynamic> message) async {
      print('onMessage: $message');
      _serializeAndNavigate(message);
    },
        //called when app is in the background and it's opened from notification drawer
        onResume: (Map<String, dynamic> message) async {
      print('onMessage: $message');
      _serializeAndNavigate(message);
    });
  }

  Future<String> getDeviceToken() async {
    print('i am here');
    try {
      return await _fbm.getToken();
    } catch(ex) {
      return null;
    }
  }

  void _serializeAndNavigate(Map<String, dynamic> message) {
    var notificationData = message['data'];
    var route = notificationData['view'];
    var data = notificationData['data'];
    print('$route $data');
  }
}
