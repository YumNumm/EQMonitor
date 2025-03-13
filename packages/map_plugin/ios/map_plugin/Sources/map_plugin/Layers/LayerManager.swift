import Foundation
import UIKit
import MapLibre


/// レイヤーを管理するクラス
@objc public class LayerManager: NSObject {
    /// 管理対象のマップビュー
    private let mapView: MLNMapView

    /// 追加済みレイヤーの識別子とレイヤーのマップ
    private var layers: [String: MLNStyleLayer] = [:]

    /// 初期化
    /// - Parameter mapView: MapLibreのマップビュー
    @objc public init(mapView: MLNMapView) {
        self.mapView = mapView
        super.init()
    }

    /// レイヤーを追加する
    /// - Parameter layer: 追加するレイヤー
    /// - Returns: 追加が成功したかどうか
    @objc public func addLayer(_ layer: MLNStyleLayer) -> Bool {
        guard !isLayerExists(layer.identifier) else {
            print("LayerManager: Layer with ID \(layer.identifier) already exists")
            return false
        }

        mapView.style?.addLayer(layer)
        layers[layer.identifier] = layer
        return true
    }

    /// レイヤーを指定したレイヤーの上に追加する
    /// - Parameters:
    ///   - layer: 追加するレイヤー
    ///   - above: このレイヤーの上に追加する
    /// - Returns: 追加が成功したかどうか
    @objc public func addLayer(_ layer: MLNStyleLayer, aboveLayerId: String) -> Bool {
        guard !isLayerExists(layer.identifier) else {
            print("LayerManager: Layer with ID \(layer.identifier) already exists")
            return false
        }

        guard let aboveLayer = mapView.style?.layer(withIdentifier: aboveLayerId) else {
            print("LayerManager: Above layer with ID \(aboveLayerId) not found")
            return false
        }

        mapView.style?.insertLayer(layer, above: aboveLayer)
        layers[layer.identifier] = layer
        return true
    }

    /// レイヤーを指定したレイヤーの下に追加する
    /// - Parameters:
    ///   - layer: 追加するレイヤー
    ///   - below: このレイヤーの下に追加する
    /// - Returns: 追加が成功したかどうか
    @objc public func addLayer(_ layer: MLNStyleLayer, belowLayerId: String) -> Bool {
        guard !isLayerExists(layer.identifier) else {
            print("LayerManager: Layer with ID \(layer.identifier) already exists")
            return false
        }

        guard let belowLayer = mapView.style?.layer(withIdentifier: belowLayerId) else {
            print("LayerManager: Below layer with ID \(belowLayerId) not found")
            return false
        }

        mapView.style?.insertLayer(layer, below: belowLayer)
        layers[layer.identifier] = layer
        return true
    }

    /// レイヤーを削除する
    /// - Parameter layerId: 削除するレイヤーのID
    /// - Returns: 削除が成功したかどうか
    @objc public func removeLayer(layerId: String) -> Bool {
        guard let layer = getLayer(layerId: layerId) else {
            return false
        }

        mapView.style?.removeLayer(layer)
        layers.removeValue(forKey: layerId)
        return true
    }

    /// レイヤーを取得する
    /// - Parameter layerId: レイヤーのID
    /// - Returns: レイヤー（見つからない場合はnil）
    @objc public func getLayer(layerId: String) -> MLNStyleLayer? {
        return mapView.style?.layer(withIdentifier: layerId)
    }

    /// レイヤーの表示・非表示を設定する
    /// - Parameters:
    ///   - layerId: レイヤーのID
    ///   - visible: 表示する場合はtrue、非表示にする場合はfalse
    /// - Returns: 設定が成功したかどうか
    @objc public func setLayerVisibility(layerId: String, visible: Bool) -> Bool {
        guard let layer = getLayer(layerId: layerId) else {
            return false
        }

        let visibility = visible ? "visible" : "none"
        // KVCを使用して可視性を設定
        let expression = NSExpression(forConstantValue: visibility)
        layer.setValue(expression, forKey: "visibility")
        return true
    }

    /// レイヤーが存在するかどうかを確認する
    /// - Parameter layerId: レイヤーのID
    /// - Returns: 存在する場合はtrue、存在しない場合はfalse
    @objc public func isLayerExists(_ layerId: String) -> Bool {
        return mapView.style?.layer(withIdentifier: layerId) != nil
    }

    /// 全てのレイヤーのIDを取得する
    /// - Returns: レイヤーIDの配列
    @objc public func getAllLayerIds() -> [String] {
        return Array(layers.keys)
    }

}
