import Foundation

struct LiveActivityTimestamp: Codable, Hashable, Sendable {
    let date: Date
    private let encodedValue: String

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)
        guard let parsed = LiveActivityTimestampParser().parse(rawValue: rawValue) else {
            throw DecodingError.dataCorruptedError(
                in: container,
                debugDescription: "Expected a valid ISO 8601 timestamp"
            )
        }
        date = parsed
        encodedValue = rawValue
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(encodedValue)
    }

    static func == (lhs: Self, rhs: Self) -> Bool { lhs.date == rhs.date }

    func hash(into hasher: inout Hasher) { hasher.combine(date) }
}

struct LiveActivityTimestampParser {
    func parse(rawValue: String) -> Date? {
        guard rawValue.range(
            of: #"^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}(?:\.\d+)?(?:Z|[+-]\d{2}:\d{2})$"#,
            options: .regularExpression
        ) == rawValue.startIndex..<rawValue.endIndex else {
            return nil
        }
        // Validate whole seconds separately: the legacy formatter truncates
        // fractions after three digits, and Date itself has finite precision.
        let zone = rawValue.hasSuffix("Z") ? "Z" : String(rawValue.suffix(6))
        let wholeSeconds = String(rawValue.prefix(19)) + zone
        guard let parsed = ISO8601DateFormatter().date(from: wholeSeconds),
              preservesCalendarComponents(rawValue, date: parsed) else { return nil }
        let fraction = rawValue.dropFirst(19).hasPrefix(".")
            ? String(rawValue.dropFirst(20).prefix(while: \.isNumber)) : "0"
        guard let fractionalSeconds = Double("0." + fraction) else { return nil }
        return parsed.addingTimeInterval(fractionalSeconds)
    }

    func preservesCalendarComponents(_ rawValue: String, date: Date) -> Bool {
        let components = rawValue.prefix(19).split { "-T:".contains($0) }
        guard components.count == 6,
              let year = Int(components[0]),
              let month = Int(components[1]),
              let day = Int(components[2]),
              let hour = Int(components[3]),
              let minute = Int(components[4]),
              let second = Int(components[5]),
              let timeZone = timeZone(rawValue: rawValue) else {
            return false
        }
        let actual = Calendar(identifier: .gregorian).dateComponents(
            in: timeZone,
            from: date
        )
        return actual.year == year
            && actual.month == month
            && actual.day == day
            && actual.hour == hour
            && actual.minute == minute
            && actual.second == second
    }

    func timeZone(rawValue: String) -> TimeZone? {
        guard rawValue.last != "Z" else { return TimeZone(secondsFromGMT: 0) }
        let suffix = rawValue.suffix(6)
        guard suffix.count == 6,
              let sign = suffix.first,
              sign == "+" || sign == "-",
              let hours = Int(suffix.dropFirst().prefix(2)),
              let minutes = Int(suffix.suffix(2)),
              hours <= 23,
              minutes <= 59 else {
            return nil
        }
        let seconds = (hours * 60 + minutes) * 60
        return TimeZone(secondsFromGMT: sign == "-" ? -seconds : seconds)
    }
}

struct LiveActivityCodingKey: CodingKey {
    let stringValue: String
    let intValue: Int? = nil

    init?(stringValue: String) {
        self.stringValue = stringValue
    }

    init?(intValue: Int) {
        return nil
    }
}

func rejectUnknownKeys(
    from decoder: Decoder,
    allowed: Set<String>
) throws {
    let container = try decoder.container(keyedBy: LiveActivityCodingKey.self)
    if let unknown = container.allKeys.first(where: { !allowed.contains($0.stringValue) }) {
        throw DecodingError.dataCorruptedError(
            forKey: unknown,
            in: container,
            debugDescription: "Unexpected key \(unknown.stringValue)"
        )
    }
}

extension KeyedDecodingContainer {
    func decodeRequiredNullable<T: Decodable>(
        _ type: T.Type,
        forKey key: Key
    ) throws -> T? {
        guard contains(key) else {
            throw DecodingError.keyNotFound(
                key,
                .init(codingPath: codingPath, debugDescription: "Required nullable key is missing")
            )
        }
        return try decodeIfPresent(type, forKey: key)
    }

    func decodeOptionalNonNull<T: Decodable>(
        _ type: T.Type,
        forKey key: Key
    ) throws -> T? {
        guard contains(key) else { return nil }
        return try decode(type, forKey: key)
    }

    func decodeNonemptyString(forKey key: Key) throws -> String {
        let value = try decode(String.self, forKey: key)
        guard !value.isEmpty else {
            throw DecodingError.dataCorruptedError(
                forKey: key,
                in: self,
                debugDescription: "Identifier must not be empty"
            )
        }
        return value
    }

    func decodeRequiredNullableFiniteDouble(forKey key: Key) throws -> Double? {
        let value = try decodeRequiredNullable(Double.self, forKey: key)
        guard value?.isFinite != false else {
            throw DecodingError.dataCorruptedError(
                forKey: key,
                in: self,
                debugDescription: "Number must be finite"
            )
        }
        return value
    }
}

extension KeyedEncodingContainer {
    mutating func encodeRequiredNullable<T: Encodable>(
        _ value: T?,
        forKey key: Key
    ) throws {
        if let value {
            try encode(value, forKey: key)
        } else {
            try encodeNil(forKey: key)
        }
    }
}
