import Foundation

enum ShakeDetectionLevel: String, Codable, CaseIterable, Hashable, Sendable {
    case weaker = "Weaker"
    case weak = "Weak"
    case medium = "Medium"
    case strong = "Strong"
    case stronger = "Stronger"
}

enum UnifiedShakeDetectionStatus: String, Codable, Hashable, Sendable {
    case active
    case ended
}

struct UnifiedShakeDetectionLocation: Codable, Hashable, Sendable {
    let name: String
    let level: ShakeDetectionLevel
}

struct UnifiedShakeDetection: Codable, Hashable, Sendable {
    let headline: String
    let detectedAt: LiveActivityTimestamp
    let updatedAt: LiveActivityTimestamp
    let level: ShakeDetectionLevel
    let status: UnifiedShakeDetectionStatus
    let location: UnifiedShakeDetectionLocation?

    private enum CodingKeys: String, CodingKey {
        case headline
        case detectedAt
        case updatedAt
        case level
        case status
        case location
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        headline = try container.decode(String.self, forKey: .headline)
        detectedAt = try container.decode(LiveActivityTimestamp.self, forKey: .detectedAt)
        updatedAt = try container.decode(LiveActivityTimestamp.self, forKey: .updatedAt)
        level = try container.decode(ShakeDetectionLevel.self, forKey: .level)
        status = try container.decode(UnifiedShakeDetectionStatus.self, forKey: .status)
        location = try container.decodeRequiredNullable(
            UnifiedShakeDetectionLocation.self,
            forKey: .location
        )
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(headline, forKey: .headline)
        try container.encode(detectedAt, forKey: .detectedAt)
        try container.encode(updatedAt, forKey: .updatedAt)
        try container.encode(level, forKey: .level)
        try container.encode(status, forKey: .status)
        try container.encodeRequiredNullable(location, forKey: .location)
    }
}
