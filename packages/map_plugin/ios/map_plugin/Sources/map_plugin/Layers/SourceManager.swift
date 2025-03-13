import Foundation
import UIKit
import MapLibre


/// ソースを管理するクラス
@objc public class SourceManager: NSObject {
    /// 管理対象のマップビュー
    private let mapView: MLNMapView

    /// 追加済みソースの識別子とソースのマップ
    private var sources: [String: MLNSource] = [:]

    /// 初期化
    /// - Parameter mapView: MapLibreのマップビュー
    @objc public init(mapView: MLNMapView) {
        self.mapView = mapView
        super.init()
    }

    /// ソースを追加する
    /// - Parameter source: 追加するソース
    /// - Returns: 追加が成功したかどうか
    @objc public func addSource(_ source: MLNSource) -> Bool {
        guard !sourceExists(source.identifier) else {
            print("SourceManager: Source with ID \(source.identifier) already exists")
            return false
        }

        mapView.style?.addSource(source)
        sources[source.identifier] = source
        return true
    }

    /// GeoJSONソースを作成して追加する
    /// - Parameters:
    ///   - sourceId: ソースID
    ///   - geoJson: GeoJSON形式のデータ
    ///   - options: ソースオプション
    /// - Returns: 追加が成功した場合はソース、失敗した場合はnil
    @objc public func addGeoJSONSource(sourceId: String, geoJson: [String: Any], options: [MLNShapeSourceOption: Any]? = nil) -> MLNShapeSource? {
        guard !sourceExists(sourceId) else {
            print("SourceManager: Source with ID \(sourceId) already exists")
            return nil
        }

        do {
            let data = try JSONSerialization.data(withJSONObject: geoJson)
            let shape = try MLNShape(data: data, encoding: String.Encoding.utf8.rawValue)
            let source = MLNShapeSource(identifier: sourceId, shape: shape, options: options ?? [:])

            if addSource(source) {
                return source
            } else {
                return nil
            }
        } catch {
            print("SourceManager: Error creating GeoJSON source: \(error)")
            return nil
        }
    }

    /// 空のGeoJSONソースを作成して追加する
    /// - Parameters:
    ///   - sourceId: ソースID
    ///   - options: ソースオプション
    /// - Returns: 追加が成功した場合はソース、失敗した場合はnil
    @objc public func addEmptyGeoJSONSource(sourceId: String, options: [MLNShapeSourceOption: Any]? = nil) -> MLNShapeSource? {
        let emptyFeatureCollection: [String: Any] = [
            "type": "FeatureCollection",
            "features": []
        ]

        return addGeoJSONSource(sourceId: sourceId, geoJson: emptyFeatureCollection, options: options)
    }

    /// ソースを削除する
    /// - Parameter sourceId: 削除するソースのID
    /// - Returns: 削除が成功したかどうか
    @objc public func removeSource(sourceId: String) -> Bool {
        guard let source = getSource(sourceId: sourceId) else {
            return false
        }

        mapView.style?.removeSource(source)
        sources.removeValue(forKey: sourceId)
        return true
    }


    /// ソースを取得する
    /// - Parameter sourceId: ソースのID
    /// - Returns: ソース（見つからない場合はnil）
    @objc public func getSource(sourceId: String) -> MLNSource? {
        return mapView.style?.source(withIdentifier: sourceId)
    }

    /// GeoJSONソースを取得する
    /// - Parameter sourceId: ソースのID
    /// - Returns: GeoJSONソース（見つからない場合はnil）
    @objc public func getGeoJSONSource(sourceId: String) -> MLNShapeSource? {
        return getSource(sourceId: sourceId) as? MLNShapeSource
    }

    /// GeoJSONソースを更新する
    /// - Parameters:
    ///   - sourceId: ソースのID
    ///   - geoJson: GeoJSON形式のデータ
    /// - Returns: 更新が成功したかどうか
    @objc public func updateGeoJSONSource(sourceId: String, geoJson: [String: Any]) -> Bool {
        guard let source = getGeoJSONSource(sourceId: sourceId) else {
            return false
        }

        do {
            let data = try JSONSerialization.data(withJSONObject: geoJson)
            let shape = try MLNShape(data: data, encoding: String.Encoding.utf8.rawValue)
            source.shape = shape
            return true
        } catch {
            print("SourceManager: Error updating GeoJSON source: \(error)")
            return false
        }
    }

    /// ソースが存在するかどうかを確認する
    /// - Parameter sourceId: ソースのID
    /// - Returns: 存在する場合はtrue、存在しない場合はfalse
    @objc public func sourceExists(_ sourceId: String) -> Bool {
        return mapView.style?.source(withIdentifier: sourceId) != nil
    }

    /// 全てのソースのIDを取得する
    /// - Returns: ソースIDの配列
    @objc public func getAllSourceIds() -> [String] {
        return Array(sources.keys)
    }

    /// 画像を追加する
    /// - Parameters:
    ///   - name: 画像名
    ///   - image: 追加する画像
    /// - Returns: 追加が成功したかどうか
    @objc public func addImage(name: String, image: UIImage) -> Bool {
        guard mapView.style != nil else { return false }

        mapView.style?.setImage(image, forName: name)
        return true
    }

    /// 画像をデータから追加する
    /// - Parameters:
    ///   - name: 画像名
    ///   - data: 画像データ
    /// - Returns: 追加が成功したかどうか
    @objc public func addImageFromData(name: String, data: Data) -> Bool {
        guard let image = UIImage(data: data) else {
            print("SourceManager: Failed to create image from data")
            return false
        }

        return addImage(name: name, image: image)
    }


    /// GeoJSONソースをJSONオブジェクトで更新する
    /// - Parameters:
    ///   - sourceId: ソースID
    ///   - geoJson: GeoJSONオブジェクト
    /// - Returns: 更新が成功したかどうか
    @objc public func updateGeoJSONSourceWithObject(sourceId: String, geoJson: [String: Any]) -> Bool {
        guard let source = getGeoJSONSource(sourceId: sourceId) else {
            print("SourceManager: Source with ID \(sourceId) not found or is not a GeoJSON source")
            return false
        }

        do {
            let data = try JSONSerialization.data(withJSONObject: geoJson)
            let shape = try MLNShape(data: data, encoding: String.Encoding.utf8.rawValue)
            source.shape = shape
            return true
        } catch {
            print("SourceManager: Error updating GeoJSON source: \(error)")
            return false
        }
    }

    /// GeoJSONソースをJSON文字列で更新する
    /// - Parameters:
    ///   - sourceId: ソースID
    ///   - geoJsonString: GeoJSON文字列
    /// - Returns: 更新が成功したかどうか
    @objc public func updateGeoJSONSourceWithString(sourceId: String, geoJsonString: String) -> Bool {
        guard let source = getGeoJSONSource(sourceId: sourceId) else {
            print("SourceManager: Source with ID \(sourceId) not found or is not a GeoJSON source")
            return false
        }

        do {
            guard let data = geoJsonString.data(using: .utf8) else {
                print("SourceManager: Failed to convert string to data")
                return false
            }

            let shape = try MLNShape(data: data, encoding: String.Encoding.utf8.rawValue)
            source.shape = shape
            return true
        } catch {
            print("SourceManager: Error updating GeoJSON source: \(error)")
            return false
        }
    }
}
