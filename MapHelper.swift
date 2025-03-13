import Foundation
import UIKit
import MapLibre

@objc public class MapHelper: NSObject {
  // 指定した緯度経度矩形に合わせる
  @objc public static func setVisibleCoordinateBounds(
    mapView: MLNMapView,
    bounds: CoordinateBoundsStruct,
    padding: PaddingStruct,
    animated: Bool
  ) {
    // 緯度を-90〜90度の範囲にクランプする
    let clampedMinLatitude = max(-90.0, min(90.0, bounds.minLatitude))
    let clampedMaxLatitude = max(-90.0, min(90.0, bounds.maxLatitude))

    // 経度を-180〜180度の範囲に正規化する
    var normalizedMinLongitude = fmod(bounds.minLongitude + 540.0, 360.0) - 180.0
    var normalizedMaxLongitude = fmod(bounds.maxLongitude + 540.0, 360.0) - 180.0

    // 日付変更線をまたぐケースの処理
    if (normalizedMaxLongitude < normalizedMinLongitude) {
      // 東西が逆転している場合、地球を一周する
      normalizedMaxLongitude += 360.0
    }

    // 範囲が360度以上の場合は全経度を表示
    if (normalizedMaxLongitude - normalizedMinLongitude >= 360.0) {
      normalizedMinLongitude = -180.0
      normalizedMaxLongitude = 180.0
    }

    // MLNCoordinateBoundsを作成
    let southwest = CLLocationCoordinate2D(latitude: clampedMinLatitude, longitude: normalizedMinLongitude)
    let northeast = CLLocationCoordinate2D(latitude: clampedMaxLatitude, longitude: normalizedMaxLongitude)
    let coordinateBounds = MLNCoordinateBounds(sw: southwest, ne: northeast)

    // エッジパディングを設定
    let edgeInsets = UIEdgeInsets(
      top: padding.top,
      left: padding.left,
      bottom: padding.bottom,
      right: padding.right
    )

    // 座標範囲を適用（completionHandlerを追加）
    mapView.setVisibleCoordinateBounds(coordinateBounds, edgePadding: edgeInsets, animated: animated) {
      print("setVisibleCoordinateBounds completed")
    }
  }
}
