import Foundation
import UIKit
import MapLibre


// FFI用の座標範囲クラス
@objc public class CoordinateBoundsStruct: NSObject {
  @objc public var minLatitude: Double
  @objc public var minLongitude: Double
  @objc public var maxLatitude: Double
  @objc public var maxLongitude: Double

  @objc public override init() {
    self.minLatitude = 0.0
    self.minLongitude = 0.0
    self.maxLatitude = 0.0
    self.maxLongitude = 0.0
    super.init()
  }

  @objc public init(minLatitude: Double, minLongitude: Double, maxLatitude: Double, maxLongitude: Double) {
    self.minLatitude = minLatitude
    self.minLongitude = minLongitude
    self.maxLatitude = maxLatitude
    self.maxLongitude = maxLongitude
    super.init()
  }
}

// FFI用のパディングクラス
@objc public class PaddingStruct: NSObject {
  @objc public var top: Double
  @objc public var left: Double
  @objc public var bottom: Double
  @objc public var right: Double

  @objc public override init() {
    self.top = 0.0
    self.left = 0.0
    self.bottom = 0.0
    self.right = 0.0
    super.init()
  }

  @objc public init(top: Double, left: Double, bottom: Double, right: Double) {
    self.top = top
    self.left = left
    self.bottom = bottom
    self.right = right
    super.init()
  }
}

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

  // 単独パラメータでも呼び出せるようにするためのオーバーロードメソッド
  @objc public static func setVisibleCoordinateBounds(
    mapView: MLNMapView,
    bounds: CoordinateBoundsStruct,
    paddingTop: CGFloat = 50,
    paddingLeft: CGFloat = 50,
    paddingBottom: CGFloat = 50,
    paddingRight: CGFloat = 50,
    animated: Bool = false
  ) {
    let padding = PaddingStruct(
      top: Double(paddingTop),
      left: Double(paddingLeft),
      bottom: Double(paddingBottom),
      right: Double(paddingRight)
    )

    setVisibleCoordinateBounds(
      mapView: mapView,
      bounds: bounds,
      padding: padding,
      animated: animated
    )
  }
}
