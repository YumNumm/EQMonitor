//
//  Depth.swift
//  Widget
//
//  震源の深さのUnion型（SHALLOW / NORMAL / OVER_700 / UNKNOWN）
//  Dart定義: packages/eqapi_types/lib/src/model/v2/common/depth.dart
//

import Foundation

/// 震源の深さ
/// - shallow: ごく浅い
/// - normal: 10~700km
/// - over700: 700km以上
/// - unknown: 不明
enum Depth: Codable, Equatable {
    case shallow
    case normal(value: Double)
    case over700
    case unknown

    // MARK: - Coding Keys
    private enum CodingKeys: String, CodingKey {
        case type
        case value
    }

    private enum DepthType: String, Codable {
        case shallow = "SHALLOW"
        case normal = "NORMAL"
        case over700 = "OVER_700"
        case unknown = "UNKNOWN"
    }

    // MARK: - Decodable
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(DepthType.self, forKey: .type)

        switch type {
        case .shallow:
            self = .shallow
        case .normal:
            let value = try container.decode(Double.self, forKey: .value)
            self = .normal(value: value)
        case .over700:
            self = .over700
        case .unknown:
            self = .unknown
        }
    }

    // MARK: - Encodable
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        switch self {
        case .shallow:
            try container.encode(DepthType.shallow, forKey: .type)
        case .normal(let value):
            try container.encode(DepthType.normal, forKey: .type)
            try container.encode(value, forKey: .value)
        case .over700:
            try container.encode(DepthType.over700, forKey: .type)
        case .unknown:
            try container.encode(DepthType.unknown, forKey: .type)
        }
    }

    // MARK: - Utility Properties

    /// 深さの値を取得（km単位、取得できない場合はnil）
    var valueInKm: Int? {
        switch self {
        case .shallow:
            return 0
        case .normal(let value):
            return Int(value)
        case .over700:
            return 700
        case .unknown:
            return nil
        }
    }

    /// 表示用文字列
    var displayString: String {
        switch self {
        case .shallow:
            return "ごく浅い"
        case .normal(let value):
            return "\(Int(value))km"
        case .over700:
            return "700km以上"
        case .unknown:
            return "不明"
        }
    }

    /// 深さが既知かどうか
    var isKnown: Bool {
        switch self {
        case .unknown:
            return false
        default:
            return true
        }
    }
}
