import Foundation

enum LiveActivityInformationType: String, Codable, Hashable, Sendable {
    case vxse51 = "VXSE51"
    case vxse52 = "VXSE52"
    case vxse53 = "VXSE53"
    case ixac41 = "IXAC41"
}

struct UnifiedEarthquakeLocation: Codable, Hashable, Sendable {
    let regionName: String
    let maxIntensity: IntensityValue?

    private enum CodingKeys: String, CodingKey {
        case regionName
        case maxIntensity
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        regionName = try container.decode(String.self, forKey: .regionName)
        maxIntensity = try container.decodeRequiredNullable(
            IntensityValue.self,
            forKey: .maxIntensity
        )
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(regionName, forKey: .regionName)
        try container.encodeRequiredNullable(maxIntensity, forKey: .maxIntensity)
    }
}

struct UnifiedEarthquake: Codable, Hashable, Sendable {
    let eventId: String
    let headline: String
    let informationType: [LiveActivityInformationType]
    let issuedAt: LiveActivityTimestamp
    let isCanceled: Bool
    let hypocenterName: String?
    let magnitude: UnifiedLiveActivityMagnitude?
    let depth: Double?
    let originTime: LiveActivityTimestamp?
    let maxIntensity: IntensityValue?
    let location: UnifiedEarthquakeLocation?

    private enum CodingKeys: String, CodingKey {
        case eventId
        case headline
        case informationType
        case issuedAt
        case isCanceled
        case hypocenterName
        case magnitude
        case depth
        case originTime
        case maxIntensity
        case location
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        eventId = try container.decodeNonemptyString(forKey: .eventId)
        headline = try container.decode(String.self, forKey: .headline)
        informationType = try container.decode(
            [LiveActivityInformationType].self,
            forKey: .informationType
        )
        issuedAt = try container.decode(LiveActivityTimestamp.self, forKey: .issuedAt)
        isCanceled = try container.decode(Bool.self, forKey: .isCanceled)
        hypocenterName = try container.decodeRequiredNullable(String.self, forKey: .hypocenterName)
        magnitude = try container.decodeRequiredNullable(
            UnifiedLiveActivityMagnitude.self,
            forKey: .magnitude
        )
        depth = try container.decodeRequiredNullableFiniteDouble(forKey: .depth)
        originTime = try container.decodeRequiredNullable(
            LiveActivityTimestamp.self,
            forKey: .originTime
        )
        maxIntensity = try container.decodeRequiredNullable(
            IntensityValue.self,
            forKey: .maxIntensity
        )
        location = try container.decodeRequiredNullable(
            UnifiedEarthquakeLocation.self,
            forKey: .location
        )
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(eventId, forKey: .eventId)
        try container.encode(headline, forKey: .headline)
        try container.encode(informationType, forKey: .informationType)
        try container.encode(issuedAt, forKey: .issuedAt)
        try container.encode(isCanceled, forKey: .isCanceled)
        try container.encodeRequiredNullable(hypocenterName, forKey: .hypocenterName)
        try container.encodeRequiredNullable(magnitude, forKey: .magnitude)
        try container.encodeRequiredNullable(depth, forKey: .depth)
        try container.encodeRequiredNullable(originTime, forKey: .originTime)
        try container.encodeRequiredNullable(maxIntensity, forKey: .maxIntensity)
        try container.encodeRequiredNullable(location, forKey: .location)
    }
}
