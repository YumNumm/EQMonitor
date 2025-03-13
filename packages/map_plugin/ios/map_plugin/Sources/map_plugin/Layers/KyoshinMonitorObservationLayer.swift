import MapLibre
import Foundation
import CoreLocation
import UIKit

/// 強震モニタの観測点を表示するレイヤー
public class KyoshinMonitorObservationLayer {
    private let layerId = "kmoni-circle"
    private let sourceId = "kmoni-source"
    private let controller: MLNMapView
    private var isInitialized = false
    private var lastUpdateTimestamp: Date?

    /// 初期化
    /// - Parameter controller: MapLibreのマップビュー
    public init(controller: MLNMapView) {
        self.controller = controller
    }

    /// レイヤーを初期化する
    public func initialize() {
        dispose()

        // GeoJSONソースを追加
        let emptyFeatureCollection: [String: Any] = [
            "type": "FeatureCollection",
            "features": []
        ]

        do {
            let data = try JSONSerialization.data(withJSONObject: emptyFeatureCollection)

            // ソースオプションを設定
            let options: [MLNShapeSourceOption: Any] = [
                .clusterRadius: 20,
                .maximumZoomLevel: 15,
                .buffer: 128,
                .simplificationTolerance: 0.5
            ]

            // GeoJSONデータからMLNShapeを作成
            let shape = try MLNShape(data: data, encoding: String.Encoding.utf8.rawValue)

            // ソースを作成
            let source = MLNShapeSource(identifier: sourceId, shape: shape, options: options)
            controller.style?.addSource(source)

            // サークルレイヤーを追加
            let circleLayer = MLNCircleStyleLayer(identifier: layerId, source: source)

            // 円の半径を設定（ズームレベルに応じて変化）
            circleLayer.circleRadius = NSExpression(format: "mgl_interpolate:withCurveType:parameters:stops:($zoomLevel, 'linear', nil, %@)",
                                                   [3: 1, 10: 10])

            // 円の色を設定（プロパティから取得）
            circleLayer.circleColor = NSExpression(format: "CAST(get('color'), 'UIColor')")

            // 円の枠線の色を設定
            circleLayer.circleStrokeColor = NSExpression(forConstantValue: UIColor.gray)

            // 円の枠線の幅を設定（ズームレベルに応じて変化）
            circleLayer.circleStrokeWidth = NSExpression(format: "mgl_interpolate:withCurveType:parameters:stops:($zoomLevel, 'linear', nil, %@)",
                                                        [3: 0.2, 10: 1])

            // 円のソートキーを設定（震度値が大きいものを上に表示）
            circleLayer.circleSortKey = NSExpression(format: "get('intensity')")

            // 円の不透明度を設定
            circleLayer.circleOpacity = NSExpression(forConstantValue: 0.8)


            // 円のピッチアライメントを設定（マップの傾きに合わせる）
            circleLayer.circlePitchAlignment = NSExpression(forConstantValue: "map")

            // 円のスケールアライメントを設定（マップの傾きに合わせてスケーリング）
            circleLayer.circleScaleAlignment = NSExpression(forConstantValue: "map")

            // トランジション設定
            let transition = MLNTransition(duration: 0.3, delay: 0)
            circleLayer.circleColorTransition = transition
            circleLayer.circleOpacityTransition = transition
            circleLayer.circleRadiusTransition = transition

            // レイヤーを追加
            controller.style?.addLayer(circleLayer)

            isInitialized = true
            lastUpdateTimestamp = Date()
        } catch {
            print("Error initializing KyoshinMonitorObservationLayer: \(error)")
        }
    }

    /// レイヤーを破棄する
    public func dispose() {
        if let layer = controller.style?.layer(withIdentifier: layerId) {
            controller.style?.removeLayer(layer)
        }

        if let source = controller.style?.source(withIdentifier: sourceId) {
            controller.style?.removeSource(source)
        }

        isInitialized = false
        lastUpdateTimestamp = nil
    }

    /// 観測点データを更新する
    /// - Parameter points: 観測点データ
    public func update(points: [AnalyzedKmoniObservationPoint]) {
        guard isInitialized, let source = controller.style?.source(withIdentifier: sourceId) as? MLNShapeSource else {
            print("KyoshinMonitorObservationLayer: Layer not initialized or source not found")
            return
        }

        // 観測点がない場合は空のGeoJSONを設定
        if points.isEmpty {
            let emptyFeatureCollection: [String: Any] = [
                "type": "FeatureCollection",
                "features": []
            ]

            do {
                let data = try JSONSerialization.data(withJSONObject: emptyFeatureCollection)
                let shape = try MLNShape(data: data, encoding: String.Encoding.utf8.rawValue)
                source.shape = shape
            } catch {
                print("Error updating KyoshinMonitorObservationLayer with empty data: \(error)")
            }
            return
        }

        // 観測点データからGeoJSONを作成
        let geoJson = createGeoJson(points: points)

        do {
            let data = try JSONSerialization.data(withJSONObject: geoJson)
            let shape = try MLNShape(data: data, encoding: String.Encoding.utf8.rawValue)
            source.shape = shape
        } catch {
            print("Error updating KyoshinMonitorObservationLayer: \(error)")
        }
    }

    /// GeoJSONを作成する
    /// - Parameter points: 観測点データ
    /// - Returns: GeoJSON
    private func createGeoJson(points: [AnalyzedKmoniObservationPoint]) -> [String: Any] {
        let features = points
            .filter { $0.intensityValue != nil }
            .map { point -> [String: Any] in
                return [
                    "type": "Feature",
                    "geometry": [
                        "type": "Point",
                        "coordinates": [
                            point.point.location.longitude,
                            point.point.location.latitude
                        ]
                    ],
                    "properties": [
                        "color": point.intensityColor?.hexString ?? "#000000",
                        "intensity": point.intensityValue as Any,
                        "name": point.point.name,
                        "id": "\(point.point.location.latitude),\(point.point.location.longitude)"
                    ]
                ]
            }

        return [
            "type": "FeatureCollection",
            "features": features
        ]
    }

    /// 指定した座標の観測点を取得する
    /// - Parameter coordinate: 座標
    /// - Returns: 観測点（見つからない場合はnil）
    public func getFeatureAt(coordinate: CLLocationCoordinate2D) -> AnalyzedKmoniObservationPoint? {
        guard isInitialized, let _ = controller.style?.source(withIdentifier: sourceId) as? MLNShapeSource else {
            return nil
        }

        // 座標を画面上のポイントに変換
        let point = controller.convert(coordinate, toPointTo: nil)

        // 指定した座標の特徴を取得
        let features = controller.visibleFeatures(
            at: point,
            styleLayerIdentifiers: [layerId]
        )

        // 最初の特徴を返す
        if let feature = features.first as? MLNPointFeature,
           let name = feature.attribute(forKey: "name") as? String,
           let intensity = feature.attribute(forKey: "intensity") as? Double {

            let kmoniPoint = KmoniObservationPoint(
                location: feature.coordinate,
                name: name
            )

            // 色を取得
            var color: UIColor? = nil
            if let colorString = feature.attribute(forKey: "color") as? String {
                color = UIColor(hexString: colorString)
            }

            return AnalyzedKmoniObservationPoint(
                point: kmoniPoint,
                intensityValue: intensity,
                intensityColor: color
            )
        }

        return nil
    }

    /// 指定した矩形内の観測点を取得する
    /// - Parameter rect: 矩形（画面座標）
    /// - Returns: 観測点の配列
    public func getFeaturesIn(rect: CGRect) -> [AnalyzedKmoniObservationPoint] {
        guard isInitialized else {
            return []
        }

        // 矩形内の特徴を取得
        let features = controller.visibleFeatures(
            in: rect,
            styleLayerIdentifiers: [layerId]
        )

        // 特徴を観測点データに変換
        return features.compactMap { feature in
            guard let pointFeature = feature as? MLNPointFeature,
                  let name = pointFeature.attribute(forKey: "name") as? String,
                  let intensity = pointFeature.attribute(forKey: "intensity") as? Double else {
                return nil
            }

            let kmoniPoint = KmoniObservationPoint(
                location: pointFeature.coordinate,
                name: name
            )

            // 色を取得
            var color: UIColor? = nil
            if let colorString = pointFeature.attribute(forKey: "color") as? String {
                color = UIColor(hexString: colorString)
            }

            return AnalyzedKmoniObservationPoint(
                point: kmoniPoint,
                intensityValue: intensity,
                intensityColor: color
            )
        }
    }
}

/// 解析済み観測点データ
public struct AnalyzedKmoniObservationPoint {
    /// 観測点
    public let point: KmoniObservationPoint
    /// 震度値
    public let intensityValue: Double?
    /// 震度の色
    public let intensityColor: UIColor?

    /// 初期化
    public init(point: KmoniObservationPoint, intensityValue: Double?, intensityColor: UIColor?) {
        self.point = point
        self.intensityValue = intensityValue
        self.intensityColor = intensityColor
    }
}

/// 観測点データ
public struct KmoniObservationPoint {
    /// 観測点の位置
    public let location: CLLocationCoordinate2D
    /// 観測点の名前
    public let name: String

    /// 初期化
    public init(location: CLLocationCoordinate2D, name: String) {
        self.location = location
        self.name = name
    }
}

extension UIColor {
    /// 16進数の色文字列を取得
    var hexString: String {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0

        self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        let redInt = Int(red * 255.0)
        let greenInt = Int(green * 255.0)
        let blueInt = Int(blue * 255.0)

        return String(format: "#%02X%02X%02X", redInt, greenInt, blueInt)
    }

    /// 16進数の色文字列から初期化
    convenience init?(hexString: String) {
        let r, g, b: CGFloat

        if hexString.hasPrefix("#") {
            let start = hexString.index(hexString.startIndex, offsetBy: 1)
            let hexColor = String(hexString[start...])

            if hexColor.count == 6 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff0000) >> 16) / 255
                    g = CGFloat((hexNumber & 0x00ff00) >> 8) / 255
                    b = CGFloat(hexNumber & 0x0000ff) / 255

                    self.init(red: r, green: g, blue: b, alpha: 1.0)
                    return
                }
            }
        }

        return nil
    }
}
