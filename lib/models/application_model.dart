import 'dart:typed_data';

class ApplicationDataModel {
  ApplicationDataModel({
    this.isLocked,
    this.application,
  });

  bool? isLocked;
  ApplicationData? application;
}

class ApplicationData {
  ApplicationData({
    required this.appName,
    this.apkFilePath = "", // Default empty string instead of null
    required this.packageName,
    required this.versionName,
    required this.versionCode,
    this.dataDir = "", // Default empty string instead of null
    this.systemApp = false,
    this.installTimeMillis = "", // Default empty string instead of null
    this.updateTimeMillis = "", // Default empty string instead of null
    this.category = "Unknown", // Default value
    required this.enabled,
    this.icon,
  });

  String appName;
  Uint8List? icon; // Icon can still be nullable, but handle it gracefully
  String apkFilePath;
  String packageName;
  String versionName;
  String versionCode;
  String dataDir;
  bool systemApp;
  String installTimeMillis;
  String updateTimeMillis;
  String category;
  bool enabled;
}
