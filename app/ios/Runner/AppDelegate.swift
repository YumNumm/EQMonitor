import Flutter
import UIKit
import flutter_local_notifications
import background_location_tracker

@main
@objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    if #available(iOS 10.0, *) {
      UNUserNotificationCenter.current().delegate = self as UNUserNotificationCenterDelegate
    }

    // killed状態からの位置情報起動を検知してHeadless Engineを起動する
    if launchOptions?[.location] != nil {
      LocationHeadlessRunner.shared.startFromLaunchOptions()
    }

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
    FlutterLocalNotificationsPlugin.setPluginRegistrantCallback { (registry) in
      GeneratedPluginRegistrant.register(with: registry)
    }
    LocationHeadlessRunner.pluginRegistrantCallback = { engine in
      GeneratedPluginRegistrant.register(with: engine)
    }
    GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)

    // Register App Group container path method channel.
    if let registrar = engineBridge.pluginRegistry.registrar(
      forPlugin: "AppGroupMethodChannel"
    ) {
      AppGroupMethodChannel.register(with: registrar)
    }
  }
}
