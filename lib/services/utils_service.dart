import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:instagram_clone/services/prefs_service.dart';

class Utils {

  // static Future<void> showLocalNotification(String title, String body) async {
  //   var android = const AndroidNotificationDetails("channelId", "channelName",
  //       channelDescription: "channelDescription");
  //   var iOS = const DarwinNotificationDetails();
  //   var platform = NotificationDetails(android: android, iOS: iOS);
  //
  //   int id = Random().nextInt((pow(2, 31) - 1).toInt());
  //   await FlutterLocalNotificationsPlugin().show(id, title, body, platform);
  // }

  static void fireToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static Future<Map<String, String>> deviceParams() async {
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    Map<String, String> params = {};

    /// Only IOS and Android
    String getDeviceId;
    if(Platform.isIOS) {
      final info = await deviceInfoPlugin.iosInfo;
      getDeviceId = info.identifierForVendor!;
    } else if(Platform.isAndroid) {
      final info = await deviceInfoPlugin.androidInfo;
      getDeviceId = info.id;
    } else {
      final info = await deviceInfoPlugin.webBrowserInfo;
      getDeviceId = info.vendor!;
    }
    String fcmToken = await Prefs.loadFCM();

    if (Platform.isIOS) {
      params.addAll({
        'device_id': getDeviceId,
        'device_type': "I",
        'device_token': fcmToken,
      });
    } else {
      params.addAll({
        'device_id': getDeviceId,
        'device_type': "A",
        'device_token': fcmToken,
      });
    }
    return params;
  }

  static String currentDate() {
    DateTime now = DateTime.now();

    String convertedDateTime =
        "${now.year.toString()}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} ${now.hour.toString()}:${now.minute.toString()}";
    return convertedDateTime;
  }

  static Future<bool> dialogCommon(
      BuildContext context, String title, String message, bool isSingle) async {
    return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: [
              !isSingle
                  ? MaterialButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: const Text("Cancel"),
              )
                  : const SizedBox.shrink(),
              MaterialButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: const Text("Confirm"),
              ),
            ],
          );
        });
  }
}