swift
import UIKit

public class DeviceAppsPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "your_method_channel_name", binaryMessenger: registrar.messenger())
    let instance = DeviceAppsPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    if call.method == "getInstalledApps" {
      let apps = getInstalledApps()
      result(apps)
    } else {
      result(FlutterMethodNotImplemented)
    }
  }

  private func getInstalledApps() -> [[String: Any]] {
    var apps: [[String: Any]] = []

    if let bundleURLs = FileManager.default.urls(for: .applicationDirectory, in: .allDomainsMask) {
        for bundleURL in bundleURLs {
          if let appBundle = Bundle(url: bundleURL) {
            let appInfo: [String: Any] = [
              "appName": appBundle.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String ?? "",
              "packageName": appBundle.bundleIdentifier ?? "",
              // Add other necessary app information properties
            ]
            apps.append(appInfo)
          }
        }
      }

    return apps
  }
}
