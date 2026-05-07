import CoreLocation
import Flutter
import Foundation

public typealias PluginRegistrantCallback = (FlutterEngine) -> Void

/// アプリがkilled状態から位置情報で起動された時に
/// Headless FlutterEngineを起動してDartコードを実行するクラス。
public final class LocationHeadlessRunner: NSObject, CLLocationManagerDelegate {
    public static let shared = LocationHeadlessRunner()

    /// アプリのAppDelegateで設定するプラグイン登録コールバック。
    public static var pluginRegistrantCallback: PluginRegistrantCallback?

    private var headlessEngine: FlutterEngine?
    private var channel: FlutterMethodChannel?
    private var pendingLocations: [(Double, Double)] = []
    private var isReady = false
    private var locationManager: CLLocationManager?
    private var hasStarted = false

    private override init() {}

    private var storedCallbackHandle: Int64? {
        let value = UserDefaults.standard.object(forKey: "blt_callback_handle")
        guard let rawValue = value else { return nil }
        if let intValue = rawValue as? Int64 { return intValue }
        if let intValue = rawValue as? Int { return Int64(intValue) }
        return nil
    }

    /// killed状態からの復帰時にAppDelegateから呼ぶ。
    /// CLLocationManagerを再生成して位置更新を待つ。
    public func startFromLaunchOptions() {
        guard !hasStarted else { return }
        hasStarted = true

        let manager = CLLocationManager()
        manager.delegate = self
        locationManager = manager
        manager.startMonitoringSignificantLocationChanges()
    }

    public func start(latitude: Double, longitude: Double) {
        // killed状態の場合はDart側にRiverpod等のリスナーが存在しないため、
        // ネイティブ層で永続化しておき、次回通常起動時にDart側が読み出して反映する。
        let defaults = UserDefaults.standard
        defaults.set(latitude, forKey: "blt_pending_lat")
        defaults.set(longitude, forKey: "blt_pending_lon")
        defaults.set(Date().timeIntervalSince1970, forKey: "blt_pending_ts")

        pendingLocations.append((latitude, longitude))
        launchEngine()
    }

    private func launchEngine() {
        guard storedCallbackHandle != nil else {
            pendingLocations.removeAll()
            return
        }

        if headlessEngine != nil {
            sendPendingLocations()
            return
        }

        guard let handle = storedCallbackHandle,
              let info = FlutterCallbackCache.lookupCallbackInformation(handle)
        else {
            pendingLocations.removeAll()
            return
        }

        let engine = FlutterEngine(
            name: "blt_headless",
            project: nil,
            allowHeadlessExecution: true
        )
        headlessEngine = engine
        engine.run(
            withEntrypoint: info.callbackName,
            libraryURI: info.callbackLibraryPath
        )
        // アプリが設定したコールバックでプラグインを登録する
        LocationHeadlessRunner.pluginRegistrantCallback?(engine)

        channel = FlutterMethodChannel(
            name: "background_location_tracker/headless",
            binaryMessenger: engine.binaryMessenger
        )
        channel?.setMethodCallHandler { [weak self] call, result in
            if call.method == "ready" {
                self?.isReady = true
                self?.sendPendingLocations()
                result(nil)
            }
        }
    }

    private func sendPendingLocations() {
        guard isReady else { return }
        let locations = pendingLocations
        pendingLocations.removeAll()
        for (lat, lon) in locations {
            channel?.invokeMethod(
                "onLocationUpdate",
                arguments: ["latitude": lat, "longitude": lon]
            )
        }
    }

    // MARK: - CLLocationManagerDelegate (killed状態復帰時のみ使用)

    public func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        guard let location = locations.last else { return }
        start(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
    }

    public func locationManager(
        _ manager: CLLocationManager,
        didFailWithError error: Error
    ) {
        // サイレントに無視する
    }
}
