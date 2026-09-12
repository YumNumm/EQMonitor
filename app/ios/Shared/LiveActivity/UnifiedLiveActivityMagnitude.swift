import Foundation

enum UnifiedLiveActivityMagnitude: Hashable, Sendable {
    case normal(Double)
    case unknown
    case overM8
}

extension UnifiedLiveActivityMagnitude: Codable {
    private enum MagnitudeType: String, Codable {
        case normal = "NORMAL"
        case unknown = "UNKNOWN"
        case overM8 = "OVER_M8"
    }

    private enum CodingKeys: String, CodingKey {
        case type
        case value
    }

    init(from decoder: Decoder) throws {
        try rejectUnknownKeys(
            from: decoder,
            allowed: [CodingKeys.type.rawValue, CodingKeys.value.rawValue]
        )
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(MagnitudeType.self, forKey: .type)
        switch type {
        case .normal:
            let value = try container.decode(Double.self, forKey: .value)
            guard value.isFinite else {
                throw DecodingError.dataCorruptedError(
                    forKey: .value,
                    in: container,
                    debugDescription: "Magnitude must be finite"
                )
            }
            self = .normal(value)
        case .unknown:
            guard !container.contains(.value) else {
                throw DecodingError.dataCorruptedError(
                    forKey: .value,
                    in: container,
                    debugDescription: "UNKNOWN must not contain value"
                )
            }
            self = .unknown
        case .overM8:
            guard !container.contains(.value) else {
                throw DecodingError.dataCorruptedError(
                    forKey: .value,
                    in: container,
                    debugDescription: "OVER_M8 must not contain value"
                )
            }
            self = .overM8
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case let .normal(value):
            guard value.isFinite else {
                throw EncodingError.invalidValue(
                    value,
                    .init(codingPath: encoder.codingPath, debugDescription: "Magnitude must be finite")
                )
            }
            try container.encode(MagnitudeType.normal, forKey: .type)
            try container.encode(value, forKey: .value)
        case .unknown:
            try container.encode(MagnitudeType.unknown, forKey: .type)
        case .overM8:
            try container.encode(MagnitudeType.overM8, forKey: .type)
        }
    }
}
