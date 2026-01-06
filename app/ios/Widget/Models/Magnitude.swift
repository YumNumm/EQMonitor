//
//  Magnitude.swift
//  Widget
//
//  マグニチュードのUnion型（NORMAL / UNKNOWN / OVER_M8）
//  Dart定義: packages/eqapi_types/lib/src/model/v2/common/magnitude.dart
//

import Foundation

/// 地震の規模を表すマグニチュード
/// - normal: 通常のマグニチュード値
/// - unknown: M不明
/// - overM8: M8を超える巨大地震
enum Magnitude: Codable, Equatable {
    case normal(value: Double)
    case unknown
    case overM8

    // MARK: - Coding Keys
    private enum CodingKeys: String, CodingKey {
        case type
        case value
    }

    private enum MagnitudeType: String, Codable {
        case normal = "NORMAL"
        case unknown = "UNKNOWN"
        case overM8 = "OVER_M8"
    }

    // MARK: - Decodable
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(MagnitudeType.self, forKey: .type)

        switch type {
        case .normal:
            let value = try container.decode(Double.self, forKey: .value)
            self = .normal(value: value)
        case .unknown:
            self = .unknown
        case .overM8:
            self = .overM8
        }
    }

    // MARK: - Encodable
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        switch self {
        case .normal(let value):
            try container.encode(MagnitudeType.normal, forKey: .type)
            try container.encode(value, forKey: .value)
        case .unknown:
            try container.encode(MagnitudeType.unknown, forKey: .type)
        case .overM8:
            try container.encode(MagnitudeType.overM8, forKey: .type)
        }
    }

    // MARK: - Utility Properties

    /// マグニチュードの値を取得（取得できない場合はnil）
    var numericValue: Double? {
        switch self {
        case .normal(let value):
            return value
        case .unknown, .overM8:
            return nil
        }
    }

    /// 表示用文字列
    var displayString: String {
        switch self {
        case .normal(let value):
            return String(format: "M%.1f", value)
        case .unknown:
            return "M不明"
        case .overM8:
            return "M8以上"
        }
    }

    /// 短い表示用文字列（値のみ）
    var shortDisplayString: String {
        switch self {
        case .normal(let value):
            return String(format: "%.1f", value)
        case .unknown:
            return "不明"
        case .overM8:
            return "8+"
        }
    }

    /// マグニチュードが既知かどうか
    var isKnown: Bool {
        switch self {
        case .normal:
            return true
        case .unknown, .overM8:
            return false
        }
    }

    /// 大規模地震かどうか（M6以上）
    var isLarge: Bool {
        switch self {
        case .normal(let value):
            return value >= 6.0
        case .overM8:
            return true
        case .unknown:
            return false
        }
    }
}
