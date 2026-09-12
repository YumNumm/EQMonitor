import Foundation
import Testing

private final class UnifiedDisplayFixtureMarker {}

struct UnifiedLiveActivityDisplayTests {
    @Test func primaryControlsEveryDisplayedSource() throws {
        let json = try fixture()
        for primary in ["shake_detection", "eew", "earthquake"] {
            var selected = json
            selected["primary"] = primary
            let display = try display(selected)
            #expect((display.shake != nil) == (primary == "shake_detection"))
            #expect((display.eew != nil) == (primary == "eew"))
            #expect((display.earthquake != nil) == (primary == "earthquake"))
            if primary == "shake_detection" {
                #expect(display.maximumIntensity == nil)
                #expect(display.localIntensity == nil)
                #expect(display.magnitude == nil)
                #expect(display.arrivalDate == nil)
                #expect(display.shakeLevel == .stronger)
                #expect(display.url?.absoluteString == "eqmonitor:///")
            }
            if primary == "earthquake" {
                #expect(display.arrivalDate == nil)
                #expect(display.localLpgmIntensity == nil)
                #expect(display.maximumIntensityLabel == "最大震度")
            }
        }
    }

    @Test func cancellationSuppressesStaleValuesInBothEarthquakeSources() throws {
        for primary in ["eew", "earthquake"] {
            var json = try fixture()
            json["primary"] = primary
            var block = try #require(json[primary] as? [String: Any])
            block["isCanceled"] = true
            json[primary] = block
            let display = try display(json)
            #expect(display.isCanceled)
            #expect(display.headline.contains("取り消されました"))
            #expect(display.maximumIntensity == nil)
            #expect(display.localIntensity == nil)
            #expect(display.localLpgmIntensity == nil)
            #expect(display.regionName == nil)
            #expect(display.arrivalDate == nil)
            #expect(display.hypocenterName == nil)
            #expect(display.magnitude == nil)
            #expect(display.depth == nil)
            #expect(display.eventDate == nil)
            #expect(!display.isLocationWarning)
        }
    }

    @Test func lowForecastIntensityAndFinalArrivalRemainVisible() throws {
        var json = try fixture()
        json["primary"] = "eew"
        var eew = try #require(json["eew"] as? [String: Any])
        eew["isWarning"] = false
        var location = try #require(eew["location"] as? [String: Any])
        location["forecastIntensity"] = "0"
        eew["location"] = location
        json["eew"] = eew
        let display = try display(json)
        #expect(display.localIntensity == .zero)
        #expect(display.arrivalDate != nil)
        #expect(display.title.contains("最終"))
    }

    @Test func plumAndLevelSuppressAssumedSourceMetricsAndCountdown() throws {
        for flag in ["isPlum", "isLevel"] {
            var json = try fixture()
            json["primary"] = "eew"
            var eew = try #require(json["eew"] as? [String: Any])
            eew[flag] = true
            json["eew"] = eew
            let display = try display(json)
            #expect(display.magnitude == nil)
            #expect(display.depth == nil)
            #expect(display.arrivalDate == nil)
            #expect(display.localIntensity == .fiveLower)
            #expect(display.methodLabel != nil)
        }
    }

    @Test func eventIdIsOneEncodedPathComponent() {
        #expect(EarthquakeDetailURL.make(eventId: "a/b?#%")?.absoluteString
            == "eqmonitor:///earthquake-history-details/a%2Fb%3F%23%25")
        #expect(EarthquakeDetailURL.make(eventId: "") == nil)
    }

    private func fixture() throws -> [String: Any] {
        let url = try #require(Bundle(for: UnifiedDisplayFixtureMarker.self)
            .url(forResource: "canonical", withExtension: "json"))
        return try #require(JSONSerialization.jsonObject(with: Data(contentsOf: url)) as? [String: Any])
    }

    private func display(_ json: [String: Any]) throws -> UnifiedLiveActivityDisplay {
        UnifiedLiveActivityDisplay(state: try JSONDecoder().decode(
            UnifiedLiveActivityContentState.self,
            from: JSONSerialization.data(withJSONObject: json)
        ))
    }
}
