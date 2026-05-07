import Flutter
import Foundation

public final class BackgroundLocationPlugin: NSObject, FlutterPlugin,
    BackgroundLocationHostApi
{
    private var flutterApi: BackgroundLocationFlutterApi?
    private let monitor = SignificantLocationMonitor()

    public static func register(with registrar: FlutterPluginRegistrar) {
        let instance = BackgroundLocationPlugin()
        instance.flutterApi = BackgroundLocationFlutterApi(
            binaryMessenger: registrar.messenger()
        )
        BackgroundLocationHostApiSetup.setUp(
            binaryMessenger: registrar.messenger(),
            api: instance
        )
        instance.monitor.onLocationUpdate = { lat, lon, acc in
            instance.flutterApi?.onLocationUpdate(
                location: LocationUpdateMessage(
                    latitude: lat,
                    longitude: lon,
                    accuracy: acc
                )
            ) { _ in }
        }

        // killed状態のheadless runnerが永続化した位置情報を、
        // 通常起動時にDart側が読み出すための補助チャネル。
        let persistenceChannel = FlutterMethodChannel(
            name: "background_location_tracker/persistence",
            binaryMessenger: registrar.messenger()
        )
        persistenceChannel.setMethodCallHandler { call, result in
            switch call.method {
            case "consumePending":
                let defaults = UserDefaults.standard
                let latObj = defaults.object(forKey: "blt_pending_lat")
                let lonObj = defaults.object(forKey: "blt_pending_lon")
                guard let lat = latObj as? Double, let lon = lonObj as? Double
                else {
                    result(nil)
                    return
                }
                defaults.removeObject(forKey: "blt_pending_lat")
                defaults.removeObject(forKey: "blt_pending_lon")
                defaults.removeObject(forKey: "blt_pending_ts")
                result(["latitude": lat, "longitude": lon])
            default:
                result(FlutterMethodNotImplemented)
            }
        }
    }

    public func initialize(callbackHandle: Int64) throws {
        UserDefaults.standard.set(callbackHandle, forKey: "blt_callback_handle")
    }

    public func startMonitoring() throws {
        monitor.start()
    }

    public func stopMonitoring() throws {
        monitor.stop()
    }
}
