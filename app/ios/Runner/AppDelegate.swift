import Flutter
import UIKit
import WidgetKit
import flutter_local_notifications
import background_location_tracker

@main
@objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    LocationHeadlessRunner.shared.registerRetryTaskHandlers()

    if #available(iOS 10.0, *) {
      UNUserNotificationCenter.current().delegate = self as UNUserNotificationCenterDelegate
    }

    let didFinishLaunching = super.application(
      application,
      didFinishLaunchingWithOptions: launchOptions
    )

    // super呼出し中のimplicit engine初期化でregistrantを設定してから監視を復元する。
    if launchOptions?[.location] != nil {
      LocationHeadlessRunner.shared.startFromLaunchOptions()
    }

    return didFinishLaunching
  }

  func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
    FlutterLocalNotificationsPlugin.setPluginRegistrantCallback { registry in
      GeneratedPluginRegistrant.register(with: registry)
    }
    LocationHeadlessRunner.pluginRegistrantCallback = { engine in
      GeneratedPluginRegistrant.register(with: engine)
    }
    GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)

    if let registrar = engineBridge.pluginRegistry.registrar(
      forPlugin: "ApnsTokenEventChannel"
    ) {
      ApnsTokenEventChannel.register(with: registrar)
    }

    // Register App Group container path method channel.
    if let registrar = engineBridge.pluginRegistry.registrar(
      forPlugin: "AppGroupMethodChannel"
    ) {
      AppGroupMethodChannel.register(with: registrar)
    }

    // Register the debug-only Live Activity local start/update/end channel.
    if let registrar = engineBridge.pluginRegistry.registrar(
      forPlugin: "LiveActivityDebugMethodChannel"
    ) {
      LiveActivityDebugMethodChannel.register(with: registrar)
    }

    // Register the widget reload method channel.
    // Flutter が App Group UserDefaults を更新したあとに `reloadTimelines` を
    // 呼び出すと、ホーム画面ウィジェットのタイムラインを再読み込みする。
    if let registrar = engineBridge.pluginRegistry.registrar(
      forPlugin: "WidgetReloadMethodChannel"
    ) {
      let channel = FlutterMethodChannel(
        name: "net.yumnumm.eqmonitor/widget",
        binaryMessenger: registrar.messenger()
      )
      channel.setMethodCallHandler { call, result in
        switch call.method {
        case "reloadTimelines":
          if #available(iOS 14.0, *) {
            WidgetCenter.shared.reloadAllTimelines()
          }
          result(nil)
        default:
          result(FlutterMethodNotImplemented)
        }
      }
    }
  }

  override func application(
    _ application: UIApplication,
    didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
  ) {
    super.application(
      application,
      didRegisterForRemoteNotificationsWithDeviceToken: deviceToken
    )
    ApnsTokenEventChannel.shared.publish(deviceToken)
  }
}
