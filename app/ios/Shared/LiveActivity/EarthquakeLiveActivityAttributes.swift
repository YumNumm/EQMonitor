import ActivityKit
import Foundation

struct EarthquakeLiveActivityAttributes: ActivityAttributes {
    typealias ContentState = UnifiedLiveActivityContentState

    let id: String

    init?(id: String) {
        guard !id.isEmpty else { return nil }
        self.id = id
    }

    private enum CodingKeys: String, CodingKey {
        case id
    }

    init(from decoder: Decoder) throws {
        try rejectUnknownKeys(from: decoder, allowed: [CodingKeys.id.rawValue])
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeNonemptyString(forKey: .id)
    }
}
