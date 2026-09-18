import CoreLocation
import Foundation

/// CLLocationManagerのsignificantLocationChangesをラップする。
/// 約1km以上の移動時にコールバックが呼ばれる。
final class SignificantLocationMonitor: NSObject, CLLocationManagerDelegate {
    var onLocationUpdate: ((Double, Double, Double, Int64) -> Void)?

    private let manager: CLLocationManager

    override init() {
        manager = CLLocationManager()
        super.init()
        manager.delegate = self
    }

    func start() {
        manager.startMonitoringSignificantLocationChanges()
    }

    func stop() {
        manager.stopMonitoringSignificantLocationChanges()
    }

    func locationManager(
        _: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        guard let location = locations.last else { return }
        onLocationUpdate?(
            location.coordinate.latitude,
            location.coordinate.longitude,
            location.horizontalAccuracy,
            Int64(location.timestamp.timeIntervalSince1970 * 1000)
        )
    }

    func locationManager(
        _: CLLocationManager,
        didFailWithError _: Error
    ) {
        // 位置情報取得失敗はサイレントに無視する
    }
}
