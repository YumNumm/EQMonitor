import Foundation
import MapLibre
import UIKit

// FFI用の座標範囲クラス
@objc public class CoordinateBoundsStruct: NSObject {
  @objc public var minLatitude: Double
  @objc public var minLongitude: Double
  @objc public var maxLatitude: Double
  @objc public var maxLongitude: Double

  
}

// FFI用のパディングクラス
@objc public class PaddingStruct: NSObject {
  @objc public var top: Double
  @objc public var left: Double
  @objc public var bottom: Double
  @objc public var right: Double
}

@objc public class MapHelper: NSObject {
  // 指定した緯度経度矩形に合わせる
  @objc public static func setVisibleCoordinateBounds(
    mapView: MLNMapView,
    bounds: CoordinateBoundsStruct,
    padding: PaddingStruct,
    animated: Bool
  ) {
    // MLNCoordinateBoundsを作成
    let southwest = CLLocationCoordinate2D(latitude: bounds.minLatitude, longitude: bounds.minLongitude)
    let northeast = CLLocationCoordinate2D(latitude: bounds.maxLatitude, longitude: bounds.maxLongitude)
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
