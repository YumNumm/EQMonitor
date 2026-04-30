//
//  Coordinate.swift
//  Widget
//
//  震源座標のUnion型（LAT_LNG / UNKNOWN）
//  Dart定義: packages/eqapi_types/lib/src/model/v2/common/coordinate.dart
//

import Foundation

/// 震源座標
/// - LAT_LNG: 緯度経度が存在する場合
/// - UNKNOWN: 不明な場合
enum Coordinate: Codable, Equatable {
    case latLng(latitude: Double, longitude: Double)
    case unknown(condition: String)

    // MARK: - Coding Keys
    private enum CodingKeys: String, CodingKey {
        case type
        case latitude
        case longitude
        case condition
    }

    private enum CoordinateType: String, Codable {
        case latLng = "LAT_LNG"
        case unknown = "UNKNOWN"
    }

    // MARK: - Decodable
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(CoordinateType.self, forKey: .type)

        switch type {
        case .latLng:
            let latitude = try container.decode(Double.self, forKey: .latitude)
            let longitude = try container.decode(Double.self, forKey: .longitude)
            self = .latLng(latitude: latitude, longitude: longitude)
        case .unknown:
            let condition = try container.decodeIfPresent(String.self, forKey: .condition) ?? "不明"
            self = .unknown(condition: condition)
        }
    }

    // MARK: - Encodable
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        switch self {
        case .latLng(let latitude, let longitude):
            try container.encode(CoordinateType.latLng, forKey: .type)
            try container.encode(latitude, forKey: .latitude)
            try container.encode(longitude, forKey: .longitude)
        case .unknown(let condition):
            try container.encode(CoordinateType.unknown, forKey: .type)
            try container.encode(condition, forKey: .condition)
        }
    }

    // MARK: - Utility Properties

    /// 緯度を取得（unknownの場合はnil）
    var latitude: Double? {
        switch self {
        case .latLng(let lat, _):
            return lat
        case .unknown:
            return nil
        }
    }

    /// 経度を取得（unknownの場合はnil）
    var longitude: Double? {
        switch self {
        case .latLng(_, let lng):
            return lng
        case .unknown:
            return nil
        }
    }

    /// 座標が有効かどうか
    var isValid: Bool {
        switch self {
        case .latLng:
            return true
        case .unknown:
            return false
        }
    }

    /// 表示用文字列
    var displayString: String {
        switch self {
        case .latLng(let lat, let lng):
            let latDirection = lat >= 0 ? "N" : "S"
            let lngDirection = lng >= 0 ? "E" : "W"
            return String(format: "%.1f°%@ %.1f°%@", abs(lat), latDirection, abs(lng), lngDirection)
        case .unknown(let condition):
            return condition
        }
    }
}
