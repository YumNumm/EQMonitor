import Flutter
import Foundation

#if canImport(ActivityKit)
    import ActivityKit
#endif

/// アプリ内から ActivityKit を用いて Live Activity をローカル開始・更新・終了する
/// デバッグ用 MethodChannel。
///
/// Push-to-Start（サーバー経由）とは別経路で、開発時の表示検証に用いる。
///
/// Channel name: `net.yumnumm.eqmonitor/live_activity_debug`
/// Methods:
///   - `isSupported` → `Bool`
///   - `start`  (kind, eventId, contentState[JSON String]) → `String`(activityId)
///   - `update` (kind, activityId, contentState[JSON String]) → `nil`
///   - `end`    (kind, activityId, contentState[JSON String?]) → `nil`
///   - `hasTestEew` → `Bool` (通知テスト専用の Activity を復元)
///   - `showTestEew` (contentState[JSON String]) → `nil` (開始または更新)
///   - `endTestEew` → `nil` (通知テスト専用の Activity のみ終了)
///
/// - Important: ここで定義する `EewLiveActivityAttributes` は、Widget Extension 側の
///   同名型（`app/ios/Widget/LiveActivity/...`）と **型名・Codable フィールド名** を
///   一致させている。ActivityKit は ActivityAttributes 型名で Widget の
///   `ActivityConfiguration` と紐付けるため、ローカル開始した Activity は既存の
///   Widget レイアウトで描画される。フィールドを変更する場合は両方を同期すること。
final class LiveActivityDebugMethodChannel: NSObject, FlutterPlugin {
    private static let testEventId = "eqmonitor-local-test-eew"
    private var testOperationInProgress = false

    private static let channelName = "net.yumnumm.eqmonitor/live_activity_debug"

    static func register(with registrar: any FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(
            name: channelName,
            binaryMessenger: registrar.messenger()
        )
        let instance = LiveActivityDebugMethodChannel()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "isSupported":
            result(Self.isSupported())
        case "hasTestEew":
            if #available(iOS 16.1, *) {
                result(!Self.testActivities.isEmpty)
            } else {
                result(false)
            }
        case "showTestEew", "endTestEew":
            handleTestEew(call, result: result)
        case "start":
            handleStart(call, result: result)
        case "update":
            handleUpdate(call, result: result)
        case "end":
            handleEnd(call, result: result)
        default:
            result(FlutterMethodNotImplemented)
        }
    }

    private static func isSupported() -> Bool {
        if #available(iOS 16.1, *) {
            return ActivityAuthorizationInfo().areActivitiesEnabled
        }
        return false
    }

    // テスト専用の eventId だけを操作する。再起動後も ActivityKit から復元する。
    @available(iOS 16.1, *)
    private static var testActivities: [Activity<EewLiveActivityAttributes>] {
        Activity<EewLiveActivityAttributes>.activities.filter {
            $0.attributes.eventId == testEventId
                && $0.activityState != .dismissed
        }
    }

    private func handleTestEew(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard #available(iOS 16.1, *) else {
            result(Self.unsupportedError())
            return
        }
        guard !testOperationInProgress else {
            result(Self.failure("テストの操作が完了するまでお待ちください"))
            return
        }
        testOperationInProgress = true
        Task { @MainActor in
            defer { self.testOperationInProgress = false }
            do {
                let activities = Self.testActivities
                if call.method == "endTestEew" {
                    for activity in activities {
                        await activity.end(nil, dismissalPolicy: .immediate)
                    }
                    result(nil)
                    return
                }
                guard Self.isSupported() else {
                    result(Self.unsupportedError())
                    return
                }
                guard
                    let args = call.arguments as? [String: Any],
                    let json = args["contentState"] as? String,
                    let data = json.data(using: .utf8)
                else {
                    result(Self.argumentError())
                    return
                }
                let state = try JSONDecoder().decode(
                    EewLiveActivityAttributes.ContentState.self, from: data
                )
                guard state.eventId == Self.testEventId, state.type == "eew" else {
                    result(Self.argumentError("invalid test event"))
                    return
                }
                let content = ActivityContent(state: state, staleDate: Self.eewStaleDate())
                if let activity = activities.first(where: {
                    $0.activityState == .active || $0.activityState == .stale
                }) {
                    await activity.update(content)
                    for duplicate in activities where duplicate.id != activity.id {
                        await duplicate.end(nil, dismissalPolicy: .immediate)
                    }
                } else {
                    for ended in activities {
                        await ended.end(nil, dismissalPolicy: .immediate)
                    }
                    _ = try Activity.request(
                        attributes: EewLiveActivityAttributes(eventId: Self.testEventId),
                        content: content,
                        pushType: nil
                    )
                }
                result(nil)
            } catch {
                result(Self.failure("テストの操作に失敗しました: \(error.localizedDescription)"))
            }
        }
    }

    // MARK: - start

    private func handleStart(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard #available(iOS 16.1, *) else {
            result(Self.unsupportedError())
            return
        }
        guard
            let args = call.arguments as? [String: Any],
            let kind = args["kind"] as? String,
            let eventId = args["eventId"] as? String,
            let contentStateJson = args["contentState"] as? String,
            let stateData = contentStateJson.data(using: .utf8)
        else {
            result(Self.argumentError())
            return
        }

        do {
            switch kind {
            case "eew":
                let state = try JSONDecoder().decode(
                    EewLiveActivityAttributes.ContentState.self, from: stateData
                )
                let activity = try Activity.request(
                    attributes: EewLiveActivityAttributes(eventId: eventId),
                    content: ActivityContent(state: state, staleDate: Self.eewStaleDate()),
                    pushType: nil
                )
                result(activity.id)
            default:
                result(Self.argumentError("unknown kind: \(kind)"))
            }
        } catch {
            result(Self.failure("start failed: \(error.localizedDescription)"))
        }
    }

    // MARK: - update

    private func handleUpdate(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard #available(iOS 16.1, *) else {
            result(Self.unsupportedError())
            return
        }
        guard
            let args = call.arguments as? [String: Any],
            let kind = args["kind"] as? String,
            let activityId = args["activityId"] as? String,
            let contentStateJson = args["contentState"] as? String,
            let stateData = contentStateJson.data(using: .utf8)
        else {
            result(Self.argumentError())
            return
        }

        Task {
            do {
                switch kind {
                case "eew":
                    let state = try JSONDecoder().decode(
                        EewLiveActivityAttributes.ContentState.self, from: stateData
                    )
                    for activity in Activity<EewLiveActivityAttributes>.activities
                    where activity.id == activityId {
                        await activity.update(
                            ActivityContent(state: state, staleDate: Self.eewStaleDate())
                        )
                    }
                default:
                    result(Self.argumentError("unknown kind: \(kind)"))
                    return
                }
                result(nil)
            } catch {
                result(Self.failure("update failed: \(error.localizedDescription)"))
            }
        }
    }

    // MARK: - end

    private func handleEnd(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard #available(iOS 16.1, *) else {
            result(Self.unsupportedError())
            return
        }
        guard
            let args = call.arguments as? [String: Any],
            let kind = args["kind"] as? String,
            let activityId = args["activityId"] as? String
        else {
            result(Self.argumentError())
            return
        }
        let contentStateJson = args["contentState"] as? String

        Task {
            do {
                switch kind {
                case "eew":
                    let state = try Self.decodeOptional(
                        EewLiveActivityAttributes.ContentState.self, json: contentStateJson
                    )
                    for activity in Activity<EewLiveActivityAttributes>.activities
                    where activity.id == activityId {
                        await activity.end(
                            state.map { ActivityContent(state: $0, staleDate: nil) },
                            dismissalPolicy: .immediate
                        )
                    }
                default:
                    result(Self.argumentError("unknown kind: \(kind)"))
                    return
                }
                result(nil)
            } catch {
                result(Self.failure("end failed: \(error.localizedDescription)"))
            }
        }
    }

    // MARK: - Helpers

    private static func decodeOptional<T: Decodable>(_ type: T.Type, json: String?) throws -> T? {
        guard let json, let data = json.data(using: .utf8), !json.isEmpty else {
            return nil
        }
        return try JSONDecoder().decode(type, from: data)
    }

    @available(iOS 16.1, *)
    private static func eewStaleDate() -> Date {
        // 仕様書 9.3: EEW 開始/更新時の stale-date は 30 分後。
        Date().addingTimeInterval(30 * 60)
    }

    private static func argumentError(_ message: String = "invalid arguments") -> FlutterError {
        FlutterError(code: "invalid_arguments", message: message, details: nil)
    }

    private static func unsupportedError() -> FlutterError {
        FlutterError(
            code: "unsupported",
            message: "Live Activity is not supported on this device (iOS 16.1+ required)",
            details: nil
        )
    }

    private static func failure(_ message: String) -> FlutterError {
        FlutterError(code: "live_activity_error", message: message, details: nil)
    }
}

#if canImport(ActivityKit)

    // MARK: - Attributes (Widget Extension と型名・フィールドを一致させる)

    @available(iOS 16.1, *)
    struct EewLiveActivityAttributes: ActivityAttributes, Identifiable {
        struct ContentState: Codable, Hashable {
            let eventId: String
            let type: String
            let hypocenterName: String?
            let magnitude: Double?
            let depth: Double?
            let time: String?
            let isOriginTime: Bool?
            let maxIntensity: String?
            let serialNo: Int?
            let isFinal: Bool?
            let isWarning: Bool?
            let isCanceled: Bool?
            let headline: String?
            let isPlum: Bool?
            let isLevel: Bool?
            let isOnePoint: Bool?
            let location: DebugLiveActivityLocationInfo?
        }

        var id = UUID()
        let eventId: String
    }

    /// Widget 側 `LocationInfo` と同一の JSON 形状。型名の衝突を避けるため別名で定義する
    /// （ActivityKit の紐付けには ContentState の型名は不要で、フィールドの一致のみが要件）。
    struct DebugLiveActivityLocationInfo: Codable, Hashable {
        let regionName: String
        let forecastIntensity: String?
        let forecastLpgmIntensity: String?
        let arrivalTime: String?
    }

#endif
