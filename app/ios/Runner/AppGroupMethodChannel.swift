import Flutter

/// Provides the App Group container path to Dart via a MethodChannel.
///
/// The container path is resolved using
/// `FileManager.default.containerURL(forSecurityApplicationGroupIdentifier:)`,
/// which is the only reliable way to obtain this path on iOS.
///
/// Channel name: `net.yumnumm.eqmonitor/app_group`
/// Methods:
///   - `getContainerPath` → `String` (the absolute path to the container)
final class AppGroupMethodChannel: NSObject, FlutterPlugin {
    private static let channelName = "net.yumnumm.eqmonitor/app_group"
    private static let appGroupId = "group.net.yumnumm.eqmonitor"

    static func register(with registrar: any FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(
            name: channelName,
            binaryMessenger: registrar.messenger()
        )
        let instance = AppGroupMethodChannel()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "getContainerPath":
            guard let url = FileManager.default.containerURL(
                forSecurityApplicationGroupIdentifier: Self.appGroupId
            ) else {
                result(
                    FlutterError(
                        code: "APP_GROUP_ERROR",
                        message: "Failed to resolve container URL for \(Self.appGroupId). "
                            + "Check that the App Group entitlement is configured.",
                        details: nil
                    )
                )
                return
            }
            result(url.path)
        default:
            result(FlutterMethodNotImplemented)
        }
    }
}
