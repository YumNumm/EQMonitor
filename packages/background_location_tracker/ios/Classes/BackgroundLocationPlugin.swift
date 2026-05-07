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
