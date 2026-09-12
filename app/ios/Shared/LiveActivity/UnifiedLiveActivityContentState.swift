import Foundation

enum UnifiedLiveActivityPrimary: String, Codable, Hashable, Sendable {
    case shakeDetection = "shake_detection"
    case eew
    case earthquake
}

struct UnifiedLiveActivityContentState: Codable, Hashable, Sendable {
    let schemaVersion: Int
    let id: String
    let updatedAt: LiveActivityTimestamp
    let primary: UnifiedLiveActivityPrimary
    let shakeDetection: UnifiedShakeDetection?
    let eew: UnifiedEew?
    let earthquake: UnifiedEarthquake?

    private enum CodingKeys: String, CodingKey {
        case schemaVersion
        case id
        case updatedAt
        case primary
        case shakeDetection
        case eew
        case earthquake
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        schemaVersion = try container.decode(Int.self, forKey: .schemaVersion)
        guard schemaVersion == 2 else {
            throw DecodingError.dataCorruptedError(
                forKey: .schemaVersion,
                in: container,
                debugDescription: "Only schemaVersion 2 is supported"
            )
        }
        id = try container.decodeNonemptyString(forKey: .id)
        updatedAt = try container.decode(LiveActivityTimestamp.self, forKey: .updatedAt)
        primary = try container.decode(UnifiedLiveActivityPrimary.self, forKey: .primary)
        shakeDetection = try container.decodeRequiredNullable(
            UnifiedShakeDetection.self,
            forKey: .shakeDetection
        )
        eew = try container.decodeRequiredNullable(UnifiedEew.self, forKey: .eew)
        earthquake = try container.decodeRequiredNullable(
            UnifiedEarthquake.self,
            forKey: .earthquake
        )

        let primaryIsPresent = switch primary {
        case .shakeDetection: shakeDetection != nil
        case .eew: eew != nil
        case .earthquake: earthquake != nil
        }
        guard primaryIsPresent else {
            throw DecodingError.dataCorruptedError(
                forKey: .primary,
                in: container,
                debugDescription: "The primary information block must be present"
            )
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(schemaVersion, forKey: .schemaVersion)
        try container.encode(id, forKey: .id)
        try container.encode(updatedAt, forKey: .updatedAt)
        try container.encode(primary, forKey: .primary)
        try container.encodeRequiredNullable(shakeDetection, forKey: .shakeDetection)
        try container.encodeRequiredNullable(eew, forKey: .eew)
        try container.encodeRequiredNullable(earthquake, forKey: .earthquake)
    }
}
