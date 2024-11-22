import 'dart:typed_data'; // For Uint8List
import 'package:app_lock_flutter/models/application_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppsController extends GetxController {
  // List of searched apps (filtered by search query)
  List<ApplicationDataModel> searchedApps = [];

  // List of locked apps (app names or app identifiers)
  List<String> selectLockList = [];

  // Controller for the search text field
  TextEditingController searchApkText = TextEditingController();

  // Method for searching apps based on the text in the search field
  void appSearch() {
    String searchQuery = searchApkText.text.toLowerCase();
    searchedApps = allApps.where((app) {
      return app.application!.appName.toLowerCase().contains(searchQuery);
    }).toList();
    update(); // Notify listeners to rebuild UI
  }

  // Method to get the app icon (fallback if no icon is available)
   Uint8List getAppIcon(String appName) {
  var app = searchedApps.firstWhere(
    (element) => element.application!.appName == appName,
    orElse: () => null, // Returns null if app is not found
  );

  // Instead of returning null, return a fallback value (empty Uint8List or a default icon)
  return app?.application?.icon ?? Uint8List(0); // Fallback to empty Uint8List if no icon
}

  // Method to add or remove apps from the lock list (based on search results)
  void addRemoveFromLockedAppsFromSearch(ApplicationData app) {
    if (selectLockList.contains(app.appName)) {
      selectLockList.remove(app.appName); // Unlock the app
    } else {
      selectLockList.add(app.appName); // Lock the app
    }
    update(); // Notify listeners about the updated list
  }

  // Method to fetch passcode (for verifying if password is set)
  Future<String> getPasscode() async {
    final prefs = await SharedPreferences.getInstance(); // Await the instance
    return prefs.getString('passcode') ??
        ""; // Now call getString on the instance
  }

  // List of all available apps (from data source)
  List<ApplicationDataModel> allApps = [];
}
