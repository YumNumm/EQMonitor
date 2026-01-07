import Flutter
import UIKit
import flutter_local_notifications
import ActivityKit
import Foundation

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
    
    // サーバ起点（push-to-start）Live Activityのupdate token監視
    if let registrar = self.registrar(forPlugin: "LiveActivityObserverPlugin") {
      LiveActivityObserverPlugin.register(with: registrar)
    }

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}

// MARK: - Live Activity (push-to-start) observer

@available(iOS 16.1, *)
struct LiveActivitiesAppAttributes: ActivityAttributes {
  public typealias ContentState = LiveActivityContentState

  // Push-to-Start payload の attributes と一致
  let eventId: String
  let type: String // "eew" or "shake_detection"
}

@available(iOS 16.1, *)
struct LiveActivityContentState: Codable, Hashable {
  // Push-to-Start / Update payload の content-state と一致（最低限）
  let eventId: String
  let type: String
}

public final class LiveActivityObserverPlugin: NSObject, FlutterPlugin, FlutterStreamHandler {
  private var eventSink: FlutterEventSink?
  private var pollingTimer: Timer?
  private var observedActivityIds = Set<String>()
  private var lastSentTokenByActivityId: [String: String] = [:]

  public static func register(with registrar: FlutterPluginRegistrar) {
    let methodChannel = FlutterMethodChannel(
      name: "eqmonitor/live_activity_observer",
      binaryMessenger: registrar.messenger()
    )
    let eventChannel = FlutterEventChannel(
      name: "eqmonitor/live_activity_observer/events",
      binaryMessenger: registrar.messenger()
    )

    let instance = LiveActivityObserverPlugin()
    registrar.addMethodCallDelegate(instance, channel: methodChannel)
    eventChannel.setStreamHandler(instance)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "start":
      startObserving()
      result(nil)
    default:
      result(FlutterMethodNotImplemented)
    }
  }

  public func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
    eventSink = events
    // start()が先に呼ばれてイベントが取りこぼされても、
    // listen開始時に必ず再スキャンして送出できるようにリセットする
    observedActivityIds.removeAll()
    lastSentTokenByActivityId.removeAll()
    startObserving()
    return nil
  }

  public func onCancel(withArguments arguments: Any?) -> FlutterError? {
    eventSink = nil
    pollingTimer?.invalidate()
    pollingTimer = nil
    observedActivityIds.removeAll()
    lastSentTokenByActivityId.removeAll()
    return nil
  }

  private func startObserving() {
    guard #available(iOS 16.1, *), !ProcessInfo.processInfo.isiOSAppOnMac else {
      return
    }

    observeCurrentActivities()

    // 新規Activity追加を取りこぼさないためにポーリングで補う
    if pollingTimer == nil {
      pollingTimer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { [weak self] _ in
        self?.observeCurrentActivities()
      }
    }
  }

  @available(iOS 16.1, *)
  private func observeCurrentActivities() {
    for activity in Activity<LiveActivitiesAppAttributes>.activities {
      observe(activity)
    }
  }

  @available(iOS 16.1, *)
  private func observe(_ activity: Activity<LiveActivitiesAppAttributes>) {
    let activityId = activity.id
    if observedActivityIds.contains(activityId) {
      return
    }
    observedActivityIds.insert(activityId)

    // 既にpush tokenが取得済みなら即通知
    if let tokenData = activity.pushToken {
      sendActiveEvent(activity: activity, tokenData: tokenData)
    }

    // push token の更新を監視
    Task {
      for await tokenData in activity.pushTokenUpdates {
        self.sendActiveEvent(activity: activity, tokenData: tokenData)
      }
    }

    // 終了 / stale を監視（サーバ側のクリーンアップに利用）
    Task {
      for await state in activity.activityStateUpdates {
        switch state {
        case .dismissed, .ended:
          self.sendStatusEvent(activityId: activityId, status: "ended")
        case .stale:
          self.sendStatusEvent(activityId: activityId, status: "stale")
        case .active:
          break
        @unknown default:
          break
        }
      }
    }
  }

  @available(iOS 16.1, *)
  private func sendActiveEvent(activity: Activity<LiveActivitiesAppAttributes>, tokenData: Data) {
    let token = tokenData.map { String(format: "%02x", $0) }.joined()
    let activityId = activity.id

    if lastSentTokenByActivityId[activityId] == token {
      return
    }
    lastSentTokenByActivityId[activityId] = token

    let payload: [String: Any] = [
      "status": "active",
      "activityId": activityId,
      "token": token,
      "eventId": activity.attributes.eventId,
      "type": activity.attributes.type,
    ]

    DispatchQueue.main.async {
      self.eventSink?(payload)
    }
  }

  private func sendStatusEvent(activityId: String, status: String) {
    let payload: [String: Any] = [
      "status": status,
      "activityId": activityId,
    ]

    DispatchQueue.main.async {
      self.eventSink?(payload)
    }
  }
}
