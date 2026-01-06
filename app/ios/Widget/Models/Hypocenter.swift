//
//  Hypocenter.swift
//  Widget
//
//  震源に関する情報
//  Dart定義: packages/eqapi_types/lib/src/model/v2/earthquake/hypocenter.dart
//

import Foundation

/// 震源に関する情報
struct Hypocenter: Codable, Equatable {
    /// 震央地名（コード・名前）
    let value: CodeName

    /// 詳細震央地名（オプション）
    let detailed: CodeName?

    /// 震源座標
    let coordinates: Coordinate

    /// マグニチュード
    let magnitude: Magnitude

    /// 震源の深さ
    let depth: Depth

    // MARK: - Utility Properties

    /// 震央地名
    var name: String {
        return value.name
    }

    /// 震央コード
    var code: String {
        return value.code
    }

    /// 詳細震央地名（あれば）
    var detailedName: String? {
        return detailed?.name
    }

    /// 表示用の震央地名（詳細があれば詳細を使用）
    var displayName: String {
        return detailed?.name ?? value.name
    }

    /// 緯度
    var latitude: Double? {
        return coordinates.latitude
    }

    /// 経度
    var longitude: Double? {
        return coordinates.longitude
    }

    /// マグニチュードの表示文字列
    var magnitudeDisplayString: String {
        return magnitude.displayString
    }

    /// 深さの表示文字列
    var depthDisplayString: String {
        return depth.displayString
    }

    /// 震源情報のサマリー文字列
    var summary: String {
        return "\(displayName) 深さ\(depthDisplayString) \(magnitudeDisplayString)"
    }

    /// 座標が有効かどうか
    var hasValidCoordinates: Bool {
        return coordinates.isValid
    }
}
