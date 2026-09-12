import Foundation

struct UnifiedEewLocation: Codable, Hashable, Sendable {
    let regionName: String
    let forecastIntensity: IntensityValue?
    let forecastLpgmIntensity: LpgmIntensityValue?
    let arrivalTime: LiveActivityTimestamp?
    let isPlum: Bool?
    let isWarning: Bool?

    private enum CodingKeys: String, CodingKey {
        case regionName
        case forecastIntensity
        case forecastLpgmIntensity
        case arrivalTime
        case isPlum
        case isWarning
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        regionName = try container.decode(String.self, forKey: .regionName)
        forecastIntensity = try container.decodeOptionalNonNull(
            IntensityValue.self,
            forKey: .forecastIntensity
        )
        forecastLpgmIntensity = try container.decodeOptionalNonNull(
            LpgmIntensityValue.self,
            forKey: .forecastLpgmIntensity
        )
        arrivalTime = try container.decodeOptionalNonNull(
            LiveActivityTimestamp.self,
            forKey: .arrivalTime
        )
        isPlum = try container.decodeOptionalNonNull(Bool.self, forKey: .isPlum)
        isWarning = try container.decodeOptionalNonNull(Bool.self, forKey: .isWarning)
        if isPlum == false {
            throw DecodingError.dataCorruptedError(
                forKey: .isPlum,
                in: container,
                debugDescription: "isPlum may only be true when present"
            )
        }
    }
}

struct UnifiedEew: Codable, Hashable, Sendable {
    let eventId: String
    let headline: String
    let hypocenterName: String?
    let magnitude: Double?
    let depth: Double?
    let time: LiveActivityTimestamp?
    let isOriginTime: Bool
    let maxIntensity: IntensityValue?
    let serialNo: Int
    let isFinal: Bool
    let isWarning: Bool
    let isCanceled: Bool
    let isPlum: Bool
    let isLevel: Bool
    let isOnePoint: Bool
    let issuedAt: LiveActivityTimestamp
    let location: UnifiedEewLocation?

    private enum CodingKeys: String, CodingKey {
        case eventId
        case headline
        case hypocenterName
        case magnitude
        case depth
        case time
        case isOriginTime
        case maxIntensity
        case serialNo
        case isFinal
        case isWarning
        case isCanceled
        case isPlum
        case isLevel
        case isOnePoint
        case issuedAt
        case location
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        eventId = try container.decodeNonemptyString(forKey: .eventId)
        headline = try container.decode(String.self, forKey: .headline)
        hypocenterName = try container.decodeRequiredNullable(String.self, forKey: .hypocenterName)
        magnitude = try container.decodeRequiredNullableFiniteDouble(forKey: .magnitude)
        depth = try container.decodeRequiredNullableFiniteDouble(forKey: .depth)
        time = try container.decodeRequiredNullable(LiveActivityTimestamp.self, forKey: .time)
        isOriginTime = try container.decode(Bool.self, forKey: .isOriginTime)
        maxIntensity = try container.decodeRequiredNullable(IntensityValue.self, forKey: .maxIntensity)
        serialNo = try container.decode(Int.self, forKey: .serialNo)
        guard serialNo >= 0 else {
            throw DecodingError.dataCorruptedError(
                forKey: .serialNo,
                in: container,
                debugDescription: "serialNo must be nonnegative"
            )
        }
        isFinal = try container.decode(Bool.self, forKey: .isFinal)
        isWarning = try container.decode(Bool.self, forKey: .isWarning)
        isCanceled = try container.decode(Bool.self, forKey: .isCanceled)
        isPlum = try container.decode(Bool.self, forKey: .isPlum)
        isLevel = try container.decode(Bool.self, forKey: .isLevel)
        isOnePoint = try container.decode(Bool.self, forKey: .isOnePoint)
        issuedAt = try container.decode(LiveActivityTimestamp.self, forKey: .issuedAt)
        location = try container.decodeRequiredNullable(UnifiedEewLocation.self, forKey: .location)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(eventId, forKey: .eventId)
        try container.encode(headline, forKey: .headline)
        try container.encodeRequiredNullable(hypocenterName, forKey: .hypocenterName)
        try container.encodeRequiredNullable(magnitude, forKey: .magnitude)
        try container.encodeRequiredNullable(depth, forKey: .depth)
        try container.encodeRequiredNullable(time, forKey: .time)
        try container.encode(isOriginTime, forKey: .isOriginTime)
        try container.encodeRequiredNullable(maxIntensity, forKey: .maxIntensity)
        try container.encode(serialNo, forKey: .serialNo)
        try container.encode(isFinal, forKey: .isFinal)
        try container.encode(isWarning, forKey: .isWarning)
        try container.encode(isCanceled, forKey: .isCanceled)
        try container.encode(isPlum, forKey: .isPlum)
        try container.encode(isLevel, forKey: .isLevel)
        try container.encode(isOnePoint, forKey: .isOnePoint)
        try container.encode(issuedAt, forKey: .issuedAt)
        try container.encodeRequiredNullable(location, forKey: .location)
    }
}
