import ActivityKit
import Flutter
import Foundation

/// Local ActivityKit inspection uses the production unified attributes and state.
/// It does not register update tokens or simulate the server's lifetime timers.
final class LiveActivityDebugMethodChannel: NSObject, FlutterPlugin {
    static func register(with registrar: any FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(
            name: "net.yumnumm.eqmonitor/live_activity_debug",
            binaryMessenger: registrar.messenger()
        )
        registrar.addMethodCallDelegate(LiveActivityDebugMethodChannel(), channel: channel)
    }

    func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard ["isSupported", "start", "update", "end", "list"].contains(call.method) else {
            result(FlutterMethodNotImplemented)
            return
        }
        if call.method == "isSupported" {
            result(Self.isSupported)
            return
        }
        guard #available(iOS 16.1, *), Self.isSupported else {
            result(FlutterError(code: "unsupported", message: "この端末ではLive Activityを利用できません", details: nil))
            return
        }
        Task { @MainActor in
            do {
                let request = try LiveActivityDebugRequest.decode(
                    method: call.method, arguments: call.arguments as? [String: Any]
                )
                switch request {
                case let .start(attributes, state):
                    let activity: Activity<EarthquakeLiveActivityAttributes>
                    if #available(iOS 16.2, *) {
                        activity = try Activity.request(
                            attributes: attributes,
                            content: ActivityContent(state: state, staleDate: nil), pushType: nil
                        )
                    } else {
                        activity = try Activity.request(attributes: attributes, contentState: state, pushType: nil)
                    }
                    result(Self.session(activity))
                case let .update(activityId, state):
                    let activity = try Self.activity(id: activityId)
                    try LiveActivityDebugRequest.validateIdentity(attributesId: activity.attributes.id, state: state)
                    if #available(iOS 16.2, *) {
                        await activity.update(ActivityContent(state: state, staleDate: nil))
                    } else {
                        await activity.update(using: state)
                    }
                    result(nil)
                case let .end(activityId, state):
                    let activity = try Self.activity(id: activityId)
                    try LiveActivityDebugRequest.validateIdentity(attributesId: activity.attributes.id, state: state)
                    if #available(iOS 16.2, *) {
                        await activity.end(
                            state.map { ActivityContent(state: $0, staleDate: nil) },
                            dismissalPolicy: .immediate
                        )
                    } else {
                        await activity.end(using: state, dismissalPolicy: .immediate)
                    }
                    result(nil)
                case .list:
                    result(Activity<EarthquakeLiveActivityAttributes>.activities
                        .filter(Self.isActive)
                        .map(Self.session))
                }
            } catch let error as LiveActivityDebugError {
                result(FlutterError(code: error.rawValue, message: error.message, details: nil))
            } catch {
                result(FlutterError(code: "live_activity_error", message: "Live Activityの操作に失敗しました", details: nil))
            }
        }
    }

    static var isSupported: Bool {
        guard #available(iOS 16.1, *), !ProcessInfo.processInfo.isiOSAppOnMac else { return false }
        if #available(iOS 26.1, *), ProcessInfo.processInfo.isiOSAppOnVision { return false }
        return ActivityAuthorizationInfo().areActivitiesEnabled
    }

    @available(iOS 16.1, *)
    static func activity(id: String) throws -> Activity<EarthquakeLiveActivityAttributes> {
        guard let activity = Activity<EarthquakeLiveActivityAttributes>.activities.first(where: {
            $0.id == id && Self.isActive($0)
        }) else { throw LiveActivityDebugError.activityNotFound }
        return activity
    }

    @available(iOS 16.1, *)
    static func isActive(_ activity: Activity<EarthquakeLiveActivityAttributes>) -> Bool {
        if #available(iOS 16.2, *) {
            return activity.activityState == .active || activity.activityState == .stale
        }
        return activity.activityState == .active
    }

    @available(iOS 16.1, *)
    static func session(_ activity: Activity<EarthquakeLiveActivityAttributes>) -> [String: Any] {
        let state: UnifiedLiveActivityContentState
        if #available(iOS 16.2, *) {
            state = activity.content.state
        } else {
            state = activity.contentState
        }
        let eventId: String?
        switch state.primary {
        case .eew: eventId = state.eew?.eventId
        case .earthquake: eventId = state.earthquake?.eventId
        case .shakeDetection: eventId = nil
        }
        var result: [String: Any] = ["activityId": activity.id, "logicalId": activity.attributes.id]
        if let eventId { result["eventId"] = eventId }
        return result
    }
}
