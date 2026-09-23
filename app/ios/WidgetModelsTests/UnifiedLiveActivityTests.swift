import Foundation
import Testing

struct UnifiedLiveActivityTests {
    @Test(arguments: [["VXSE51"], ["VXSE51", "VXSE53"], ["VXSE53", "VXSE51"]])
    func intensityReportRemovesDuplicateHeaderBadge(types: [String]) throws {
        let json = """
        {"primary":"earthquake","earthquake":{"informationType":\(String(decoding: try JSONEncoder().encode(types), as: UTF8.self)),"maxIntensity":"6-"}}
        """
        let state = try JSONDecoder().decode(UnifiedLiveActivityContentState.self, from: Data(json.utf8))
        let display = UnifiedLiveActivityDisplay(state)
        #expect(display.lockScreenHeaderIntensity == nil)
        #expect(display.headerIntensity == .sixLower)
    }

    @Test(arguments: ["VXSE52", "VXSE53"])
    func sourceReportKeepsHeaderBadge(type: String) throws {
        let json = """
        {"primary":"earthquake","earthquake":{"informationType":["\(type)"],"maxIntensity":"6-"}}
        """
        let state = try JSONDecoder().decode(UnifiedLiveActivityContentState.self, from: Data(json.utf8))
        #expect(UnifiedLiveActivityDisplay(state).lockScreenHeaderIntensity == .sixLower)
    }

    @Test func magnitudeLabelsDistinguishUnknownMissingAndOverM8() {
        #expect(UnifiedMagnitude(type: "NORMAL", value: 6.8).displayText == "M6.8")
        #expect(UnifiedMagnitude(type: "NORMAL", value: nil).displayText == nil)
        #expect(UnifiedMagnitude(type: "UNKNOWN", value: nil).displayText == "M不明")
        #expect(UnifiedMagnitude(type: "OVER_M8", value: nil).displayText == "M8+")
        #expect(UnifiedMagnitude(type: nil, value: nil).displayText == nil)
    }

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

// Backend contract: eqmonitor-backend 3ba540e0, docs/examples/unified-live-activity-content-state.json.
// The production-shaped snapshot is the saved 2026-09-24 shake-only prepared state;
// its ID is anonymized. No token, channel ID, device ID or routing is included.
private let canonicalUnifiedJSON = #"""
{
  "schemaVersion": 2,
  "id": "019937ad-0000-7000-8000-000000000001",
  "updatedAt": "2026-09-11T12:38:00+09:00",
  "primary": "earthquake",
  "shakeDetection": {
    "headline": "関東地方で強い揺れを検知しました",
    "detectedAt": "2026-09-11T12:35:05+09:00",
    "updatedAt": "2026-09-11T12:36:30+09:00",
    "level": "Stronger",
    "status": "ended",
    "location": {
      "name": "東京都２３区",
      "level": "Stronger"
    }
  },
  "eew": {
    "eventId": "20260911123456",
    "headline": "茨城県沖で地震 関東地方で強い揺れ",
    "hypocenterName": "茨城県沖",
    "magnitude": 6.8,
    "depth": 30,
    "time": "2026-09-11T12:34:56+09:00",
    "isOriginTime": true,
    "maxIntensity": "6-",
    "serialNo": 12,
    "isFinal": true,
    "isWarning": true,
    "isCanceled": false,
    "isPlum": false,
    "isLevel": false,
    "isOnePoint": false,
    "issuedAt": "2026-09-11T12:36:00+09:00",
    "location": {
      "regionName": "東京都２３区",
      "forecastIntensity": "5-",
      "forecastLpgmIntensity": "2",
      "arrivalTime": "2026-09-11T12:35:30+09:00",
      "isWarning": true
    }
  },
  "earthquake": {
    "eventId": "20260911123456",
    "headline": "茨城県沖で地震 最大震度６弱",
    "informationType": [
      "VXSE53"
    ],
    "issuedAt": "2026-09-11T12:38:00+09:00",
    "isCanceled": false,
    "hypocenterName": "茨城県沖",
    "magnitude": {
      "type": "NORMAL",
      "value": 6.8
    },
    "depth": 30,
    "originTime": "2026-09-11T12:34:56+09:00",
    "maxIntensity": "6-",
    "location": {
      "regionName": "東京都２３区",
      "maxIntensity": "5-"
    }
  }
}
"""#

private let productionShakeJSON = #"""
{
  "attributes": {
    "id": "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
  },
  "content-state": {
    "schemaVersion": 2,
    "id": "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
    "updatedAt": "2026-09-23T16:33:59.000Z",
    "primary": "shake_detection",
    "shakeDetection": {
      "headline": "でやや強い揺れを検知",
      "detectedAt": "2026-09-23T16:33:08.000Z",
      "updatedAt": "2026-09-23T16:33:59.000Z",
      "level": "Medium",
      "status": "ended",
      "location": null
    },
    "eew": null,
    "earthquake": null
  }
}
"""#

private struct UnifiedPushSnapshot: Decodable {
    let attributes: EarthquakeLiveActivityAttributes
    let contentState: UnifiedLiveActivityContentState
    enum CodingKeys: String, CodingKey {
        case attributes
        case contentState = "content-state"
    }
}

extension UnifiedLiveActivityTests {
    @Test func canonicalBackendSnapshotDecodes() throws {
        let state = try JSONDecoder().decode(UnifiedLiveActivityContentState.self, from: Data(canonicalUnifiedJSON.utf8))
        #expect(state.schemaVersion == 2)
        #expect(state.eew?.eventId == state.earthquake?.eventId)
        #expect(state.earthquake?.magnitude?.displayText == "M6.8")
        #expect(state.eew?.location?.forecastLpgmIntensity == "2")
        #expect(state.shakeDetection?.isEnded == true)
        #expect(state.shakeDetection?.shakeLevel == .stronger)
        #expect(UnifiedLiveActivityDisplay(state).primary == .earthquake)
    }

    @Test func productionShakeSnapshotAcceptsOpaqueIDAndNullLocation() throws {
        let push = try JSONDecoder().decode(UnifiedPushSnapshot.self, from: Data(productionShakeJSON.utf8))
        #expect(String(describing: EarthquakeLiveActivityAttributes.self) == "EarthquakeLiveActivityAttributes")
        #expect(push.attributes.id.count == 64)
        #expect(push.contentState.id == push.attributes.id)
        #expect(push.contentState.eew == nil)
        #expect(push.contentState.earthquake == nil)
        #expect(push.contentState.shakeDetection?.location == nil)
        #expect(push.contentState.shakeDetection?.detectedDate != nil)
        let display = UnifiedLiveActivityDisplay(push.contentState)
        #expect(display.primary == .shakeDetection)
        #expect(display.headerShakeLevel == .medium)
        #expect(display.showsLocation == false)
        #expect(display.locationName == nil)
    }

    @Test(arguments: 1...7)
    func everyNonemptyBlockCombinationDecodes(mask: Int) throws {
        var json = try #require(JSONSerialization.jsonObject(with: Data(canonicalUnifiedJSON.utf8)) as? [String: Any])
        let keys = ["shakeDetection", "eew", "earthquake"]
        for (index, key) in keys.enumerated() where mask & (1 << index) == 0 {
            json[key] = NSNull()
        }
        json["primary"] = mask & 4 != 0 ? "earthquake" : mask & 2 != 0 ? "eew" : "shake_detection"
        let state = try JSONDecoder().decode(UnifiedLiveActivityContentState.self, from: JSONSerialization.data(withJSONObject: json))
        let expected: UnifiedPrimaryBlock = mask & 4 != 0 ? .earthquake : mask & 2 != 0 ? .eew : .shakeDetection
        #expect(UnifiedLiveActivityDisplay(state).primary == expected)
        #expect((state.shakeDetection != nil) == (mask & 1 != 0))
        #expect((state.eew != nil) == (mask & 2 != 0))
        #expect((state.earthquake != nil) == (mask & 4 != 0))
    }

    @Test(arguments: ["shake_detection", "eew", "earthquake"])
    func serverPrimaryWinsWhenAllBlocksExist(primary: String) throws {
        var json = try #require(JSONSerialization.jsonObject(with: Data(canonicalUnifiedJSON.utf8)) as? [String: Any])
        json["primary"] = primary
        let state = try JSONDecoder().decode(UnifiedLiveActivityContentState.self, from: JSONSerialization.data(withJSONObject: json))
        let expected: UnifiedPrimaryBlock = primary == "eew" ? .eew : primary == "earthquake" ? .earthquake : .shakeDetection
        #expect(UnifiedLiveActivityDisplay(state).primary == expected)
    }

    @Test(arguments: ["active", "ended"])
    func shakeLifecyclePreservesPeak(status: String) throws {
        let json = "{\"primary\":\"shake_detection\",\"shakeDetection\":{\"status\":\"\(status)\",\"level\":\"Stronger\",\"location\":{\"name\":\"東京都２３区\",\"level\":\"Strong\"}}}"
        let state = try JSONDecoder().decode(UnifiedLiveActivityContentState.self, from: Data(json.utf8))
        let display = UnifiedLiveActivityDisplay(state)
        #expect(display.primary == .shakeDetection)
        #expect(display.headerShakeLevel == .stronger)
        #expect(display.locationShakeLevel == .strong)
        #expect(state.shakeDetection?.isEnded == (status == "ended"))
    }

    @Test(arguments: ["{\"type\":\"NORMAL\",\"value\":6.8}", "{\"type\":\"UNKNOWN\"}", "{\"type\":\"OVER_M8\"}", "null"])
    func magnitudeVariantsDecode(magnitude: String) throws {
        let json = "{\"primary\":\"earthquake\",\"earthquake\":{\"magnitude\":\(magnitude),\"informationType\":[\"VXSE51\",\"VXSE52\",\"VXSE53\",\"IXAC41\"]}}"
        let state = try JSONDecoder().decode(UnifiedLiveActivityContentState.self, from: Data(json.utf8))
        #expect(state.earthquake?.informationType?.count == 4)
        #expect(state.earthquake?.primaryInformationType == .vxse53)
        let expected = magnitude.contains("NORMAL") ? "M6.8" : magnitude.contains("UNKNOWN") ? "M不明" : magnitude.contains("OVER_M8") ? "M8+" : nil
        #expect(state.earthquake?.magnitude?.displayText == expected)
    }

    @Test func endedShakeAndFinalEewRemainVisibleUntilServerEnd() throws {
        let state = try JSONDecoder().decode(UnifiedLiveActivityContentState.self, from: Data(canonicalUnifiedJSON.utf8))
        #expect(state.eew?.isFinal == true)
        #expect(state.shakeDetection?.isEnded == true)
        #expect(UnifiedLiveActivityDisplay(state).eewStrip != nil)
        #expect(state.shakeDetection?.shakeLevel == .stronger)
        #expect(UnifiedLiveActivityDisplay(state).primary != .empty)
    }
}
