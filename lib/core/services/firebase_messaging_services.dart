import 'dart:io';

import 'package:android_id/android_id.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_it/get_it.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:pet_style_mobile/core/helpers/log_helper.dart';
import 'package:pet_style_mobile/core/secrets/app_secrets.dart';
import 'package:pet_style_mobile/core/services/storage_services.dart';
import 'package:pet_style_mobile/core/values/constants.dart';

class FirebaseMessagingServices {
  final Dio dio;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  FirebaseMessagingServices({required this.dio});

  void requestPermission() async {
    StorageServices storageServices = GetIt.I<StorageServices>();
    String? accessToken =
        storageServices.getString(AppConstants.STORAGE_ACCESS_TOKEN);

    if (accessToken == null) {
      return;
    }

    String? userId = '';
    String? deviceId = await _getId();
    String? deviceName = '';
    String? fcmToken = '';
    String? os = '';
    String? osVersion = '';

    final fcm = FirebaseMessaging.instance;

    try {
      final settings = await fcm.requestPermission();
      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        logInfo('User granted permission');
        fcmToken = await fcm.getToken();
        logInfo('fcmToken $fcmToken');
      } else {
        logInfo('User declined or has not accepted permission');
      }
    } catch (e) {
      logError("Error retrieving FCM token: $e");
      return;
    }

    deviceName = (await DeviceInfoPlugin().deviceInfo).data['name'];

    if (Platform.isAndroid) {
      var androidInfo = await DeviceInfoPlugin().androidInfo;
      var release = androidInfo.version.release;
      deviceName = androidInfo.model;
      os = "Android";
      osVersion = release;
    }

    if (Platform.isIOS) {
      var iosInfo = await DeviceInfoPlugin().iosInfo;
      os = "IOS";
      osVersion = iosInfo.systemVersion;
      deviceName = iosInfo.name;
    }

    userId = storageServices.getString(AppConstants.STORAGE_USER_ID);

    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    try {
      await dio.post(AppSecrets.devicesUrl, data: {
        "clientId": userId,
        "deviceId": deviceId,
        "deviceName": deviceName,
        "os": os,
        "osVersion": osVersion,
        "appVersion": packageInfo.version,
        "appBuild": packageInfo.buildNumber,
        "appPackage": packageInfo.packageName,
        "fcmToken": fcmToken,
        "lastConnect": DateTime.now().toIso8601String()
      });
    } catch (e, st) {
      logHandle(e.toString(), st);
    }
  }

  Future<String?> _getId() async {
    const androidIdPlugin = AndroidId();
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else if (Platform.isAndroid) {
      final String? androidId = await androidIdPlugin.getId();
      return androidId; // unique ID on Android
    }
    return 'Unknown device';
  }

  Future<void> sendNotificationToGroomer(
      String groomerFcmToken, String title, String body) async {
    try {
      await dio.post(AppSecrets.sendNotificationUrl,
          data: {
            "to": groomerFcmToken,
            "notification": {"title": title, "body": body, "sound": "default"},
            "data": {
              "title": title,
              "body": body,
            }
          },
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization":
                "oOWYa8P82GysNc_FaR8WxCoNy7NSUjkDsGOEQL5qnWA",
          }));
    } catch (e, st) {
      logHandle(e.toString(), st);
    }
  }
}
