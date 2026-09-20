import Foundation
import Testing

struct UnifiedLiveActivityTests {
    @Test func eewViewStatePreservesAllPayloadFields() throws {
        let json = Data("""
        {"eventId":"20260921000000","headline":"関東で強い揺れ",
         "hypocenterName":"茨城県沖","magnitude":6.8,"depth":30,
         "time":"2026-09-21T00:00:00+09:00","isOriginTime":true,
         "maxIntensity":"6-","serialNo":12,"isFinal":true,
         "isWarning":true,"isCanceled":false,"isPlum":false,
         "isLevel":false,"isOnePoint":false,
         "location":{"regionName":"東京都23区","forecastIntensity":"5-",
         "arrivalTime":"2026-09-21T00:00:20+09:00","isWarning":true}}
        """.utf8)
        let decoder = JSONDecoder()
        let unified = try decoder.decode(UnifiedEew.self, from: json)
        let legacy = try decoder.decode(EewContentState.self, from: json)
        #expect(unified.eewContentState == legacy)
    }

    @Test func missingEewValuesAreNotInvented() throws {
        let eew = try JSONDecoder().decode(UnifiedEew.self, from: Data("{}".utf8))
        #expect(eew.eewContentState.eventId == nil)
        #expect(eew.eewContentState.display.maxIntensity == nil)
        #expect(eew.eewContentState.display.countdownArrivalDate == nil)
        #expect(eew.eewContentState.hypocenterName == nil)
    }

    @Test func eewCancellationStillSuppressesStaleValues() throws {
        let json = Data("""
        {"isCanceled":true,"isWarning":true,"maxIntensity":"6+",
         "headline":"関東で強い揺れ","location":{"regionName":"東京都23区","forecastIntensity":"5+",
         "arrivalTime":"2026-09-21T00:00:20+09:00","isWarning":true}}
        """.utf8)
        let eew = try JSONDecoder().decode(UnifiedEew.self, from: json).eewContentState
        #expect(eew.display.localIntensity == nil)
        #expect(eew.display.countdownArrivalDate == nil)
        #expect(eew.display.showsEarthquakeDetails == false)
    }

    @Test func earthquakeDoesNotDisplayCancellation() throws {
        let json = Data("""
        {"primary":"earthquake","earthquake":{"isCanceled":true,
         "headline":"茨城県沖で地震 最大震度６弱","informationType":["VXSE53"],
         "maxIntensity":"6-","location":{"regionName":"東京都23区","maxIntensity":"5-"}}}
        """.utf8)
        let state = try JSONDecoder().decode(UnifiedLiveActivityContentState.self, from: json)
        let display = UnifiedLiveActivityDisplay(state)
        #expect(display.typeLabel == "震源・震度に関する情報")
        #expect(display.headline == "茨城県沖で地震 最大震度６弱")
        #expect(display.headerIntensity == .sixLower)
        #expect(display.locationIntensity == .fiveLower)
    }
}
