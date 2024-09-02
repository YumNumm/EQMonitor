import ActivityKit
import Flutter
import UIKit
import flutter_local_notifications
import os.log

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // This is required to make any communication available in the action isolate.
    FlutterLocalNotificationsPlugin.setPluginRegistrantCallback { (registry) in
      GeneratedPluginRegistrant.register(with: registry)
    }

    if #available(iOS 10.0, *) {
      UNUserNotificationCenter.current().delegate = self as UNUserNotificationCenterDelegate
    }

    if #available(iOS 16.1, *) {
      LiveActivityManager.shared.getPushToStartToken()
      observeActivityPushToken()
    } else {
      print("LiveActivity is not supported!")
    }

    print("")

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}

extension AppDelegate {
  func observeActivityPushToken() {
    Task {
      if #available(iOS 16.1, *) {
        print("Waiting for ActivityPushToken...")
        for await activityData in Activity<EarthquakeEarlyWarningAttributes>.activityUpdates {
          Task {
            for await tokenData in activityData.pushTokenUpdates {
              let token = tokenData.map { String(format: "%02x", $0) }.joined()
              print(
                "Activity:\(activityData.id) Push token: \(token)"
              )
              //send this token to your notification server
            }
          }
        }
      } else {
        print("Live Activity is not avaiable on under iOS16.1")
      }
    }
  }
}
