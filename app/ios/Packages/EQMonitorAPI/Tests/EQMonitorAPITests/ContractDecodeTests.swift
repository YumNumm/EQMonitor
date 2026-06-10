import Foundation
import Testing
@testable import EQMonitorAPI

@Suite("Contract fixture decode tests")
struct ContractDecodeTests {

    private let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .custom { dec in
            let container = try dec.singleValueContainer()
            let string = try container.decode(String.self)
            let withFS = ISO8601DateFormatter()
            withFS.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
            if let d = withFS.date(from: string) { return d }
            let noFS = ISO8601DateFormatter()
            noFS.formatOptions = [.withInternetDateTime]
            if let d = noFS.date(from: string) { return d }
            throw DecodingError.dataCorruptedError(
                in: container, debugDescription: "Invalid ISO8601 date: \(string)")
        }
        return decoder
    }()

    private func loadFixture(_ name: String) throws -> Data {
        let url = Bundle.module.url(forResource: name, withExtension: "json", subdirectory: "fixtures")!
        return try Data(contentsOf: url)
    }

    @Test("Decode EarthquakeListResponse — full-info")
    func decodeEarthquakeFullInfo() throws {
        let data = try loadFixture("get__v2_earthquake__full-info")
        let decoded = try decoder.decode(
            Components.Schemas.EarthquakeListResponse.self,
            from: data
        )
        #expect(!decoded.items.isEmpty)
        #expect(decoded.items[0].event_id == "20251215120000")
        #expect(decoded.items[0].intensity?.value1.max_intensity == ._4)
    }

    @Test("Decode EarthquakeListResponse — major earthquake")
    func decodeEarthquakeMajor() throws {
        let data = try loadFixture("get__v2_earthquake__major-earthquake")
        let decoded = try decoder.decode(
            Components.Schemas.EarthquakeListResponse.self,
            from: data
        )
        #expect(!decoded.items.isEmpty)
    }

    @Test("Decode EewListResponse — warning")
    func decodeEewWarning() throws {
        let data = try loadFixture("get__v2_eew__warning")
        let decoded = try decoder.decode(
            Components.Schemas.EewListResponse.self,
            from: data
        )
        #expect(!decoded.items.isEmpty)
        #expect(decoded.items[0].is_warning == true)
    }

    @Test("Decode EewListResponse — basic")
    func decodeEewBasic() throws {
        let data = try loadFixture("get__v2_eew")
        let decoded = try decoder.decode(
            Components.Schemas.EewListResponse.self,
            from: data
        )
        #expect(!decoded.items.isEmpty)
    }

    @Test("Decode TsunamiListResponse — active warning")
    func decodeTsunamiActiveWarning() throws {
        let data = try loadFixture("get__v2_tsunami__active-warning")
        let decoded = try decoder.decode(
            Components.Schemas.TsunamiListResponse.self,
            from: data
        )
        #expect(!decoded.items.isEmpty)
    }
}
