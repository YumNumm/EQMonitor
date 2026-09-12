import Foundation
import Testing

private final class UnifiedLiveActivityFixtureBundleMarker {}

struct UnifiedLiveActivityContractTests {
    @Test func canonicalBackendFixtureDecodesWithoutCustomDateStrategy() throws {
        let state = try JSONDecoder().decode(
            UnifiedLiveActivityContentState.self,
            from: fixtureData(named: "canonical")
        )

        #expect(state.schemaVersion == 2)
        #expect(state.primary == .earthquake)
        #expect(state.eew?.maxIntensity == .sixLower)
        #expect(state.earthquake?.magnitude == .normal(6.8))
        #expect(state.shakeDetection?.level == .stronger)
    }

    @Test func sharedContractMatrixMatchesExpectedValidity() throws {
        let value = try JSONSerialization.jsonObject(
            with: fixtureData(named: "matrix")
        )
        let cases = try #require(value as? [[String: Any]])
        #expect(cases.count >= 25)

        for item in cases {
            let name = try #require(item["name"] as? String)
            let expected = try #require(item["valid"] as? Bool)
            let attributes = try #require(item["attributes"])
            let contentState = try #require(item["contentState"])
            let attributesData = try JSONSerialization.data(withJSONObject: attributes)
            let contentStateData = try JSONSerialization.data(withJSONObject: contentState)
            let attributesValid = (try? JSONDecoder().decode(
                EarthquakeLiveActivityAttributes.self,
                from: attributesData
            )) != nil
            let contentStateValid = (try? JSONDecoder().decode(
                UnifiedLiveActivityContentState.self,
                from: contentStateData
            )) != nil

            if attributesValid && contentStateValid != expected {
                Issue.record("\(name): expected valid=\(expected)")
            } else if !attributesValid && expected {
                Issue.record("\(name): attributes unexpectedly rejected")
            } else if attributesValid && !contentStateValid && expected {
                Issue.record("\(name): contentState unexpectedly rejected")
            }
        }
    }

    @Test func allIntensityWireValuesDecode() throws {
        for value in IntensityValue.allCases {
            let data = try #require("\"\(value.rawValue)\"".data(using: .utf8))
            #expect(try JSONDecoder().decode(IntensityValue.self, from: data) == value)
        }
        for value in LpgmIntensityValue.allCases {
            let data = try #require("\"\(value.rawValue)\"".data(using: .utf8))
            #expect(try JSONDecoder().decode(LpgmIntensityValue.self, from: data) == value)
        }
    }

    @Test func completeSnapshotCanRemovePreviouslyPresentBlocks() throws {
        let canonical = try JSONDecoder().decode(
            UnifiedLiveActivityContentState.self,
            from: fixtureData(named: "canonical")
        )
        var json = try #require(
            JSONSerialization.jsonObject(with: fixtureData(named: "canonical"))
                as? [String: Any]
        )
        json["primary"] = "earthquake"
        json["shakeDetection"] = NSNull()
        json["eew"] = NSNull()
        let removed = try JSONDecoder().decode(
            UnifiedLiveActivityContentState.self,
            from: JSONSerialization.data(withJSONObject: json)
        )

        #expect(canonical.shakeDetection != nil)
        #expect(canonical.eew != nil)
        #expect(removed.shakeDetection == nil)
        #expect(removed.eew == nil)
        #expect(removed.earthquake != nil)
    }

    @Test func allValidMatrixCasesRoundTripWithRequiredNulls() throws {
        let matrix = try JSONSerialization.jsonObject(
            with: fixtureData(named: "matrix")
        )
        let cases = try #require(matrix as? [[String: Any]])

        for item in cases where item["valid"] as? Bool == true {
            let attributes = try #require(item["attributes"])
            let contentState = try #require(item["contentState"])
            let originalAttributes = try JSONSerialization.data(withJSONObject: attributes)
            let original = try JSONSerialization.data(withJSONObject: contentState)
            let decodedAttributes = try JSONDecoder().decode(
                EarthquakeLiveActivityAttributes.self,
                from: originalAttributes
            )
            let decoded = try JSONDecoder().decode(
                UnifiedLiveActivityContentState.self,
                from: original
            )
            let encodedAttributes = try JSONEncoder().encode(decodedAttributes)
            let encoded = try JSONEncoder().encode(decoded)
            _ = try JSONDecoder().decode(
                EarthquakeLiveActivityAttributes.self,
                from: encodedAttributes
            )
            _ = try JSONDecoder().decode(
                UnifiedLiveActivityContentState.self,
                from: encoded
            )
        }
    }

    private func fixtureData(named name: String) throws -> Data {
        guard let url = Bundle(for: UnifiedLiveActivityFixtureBundleMarker.self)
            .url(forResource: name, withExtension: "json") else {
            throw CocoaError(.fileNoSuchFile)
        }
        return try Data(contentsOf: url)
    }
}
