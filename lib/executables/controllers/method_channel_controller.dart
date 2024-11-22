import 'dart:developer';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app_lock_flutter/executables/controllers/apps_controller.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:usage_stats/usage_stats.dart';

class MethodChannelController extends GetxController implements GetxService {
  static const platform = MethodChannel('flutter.native/helper');

  bool isOverlayPermissionGiven = false;
  bool isUsageStatPermissionGiven = false;
  bool isNotificationPermissionGiven = false;

  // Check overlay permission
  Future<bool> checkOverlayPermission() async {
    try {
      return await platform.invokeMethod('checkOverlayPermission').then((value) {
        log("$value", name: "checkOverlayPermission");
        isOverlayPermissionGiven = value as bool;
        update();
        return isOverlayPermissionGiven;
      });
    } on PlatformException catch (e) {
      log("Failed to Invoke: '${e.message}'");
      isOverlayPermissionGiven = false;
      update();
      return isOverlayPermissionGiven;
    }
  }

  // Check notification permission
  Future<bool> checkNotificationPermission() async {
    return isNotificationPermissionGiven = await Permission.notification.isGranted;
  }

  // Check usage stats permission
  Future<bool> checkUsageStatePermission() async {
    isUsageStatPermissionGiven = (await UsageStats.checkUsagePermission() ?? false);
    update();
    return isUsageStatPermissionGiven;
  }

  // Add or remove app from locked apps
  addToLockedAppsMethod() async {
    try {
      Map<String, dynamic> data = {
        "app_list": Get.find<AppsController>().selectLockList.map((e) {
          return {
            "app_name": e,
          };
        }).toList()
      };
      await platform.invokeMethod('addToLockedApps', data).then((value) {
        log("$value", name: "addToLockedApps CALLED");
      });
    } on PlatformException catch (e) {
      log("Failed to Invoke: '${e.message}'");
    }
  }
}
