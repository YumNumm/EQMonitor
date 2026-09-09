import AppIntents
import Foundation
import Testing
import EQMonitorAPI

struct EarthquakeIntentTests {
    let areas: [JmaCodeTable.JmaArea] = [
        .init(code: "13", nameJa: "東京都", kind: .prefecture),
        .init(code: "1310100", nameJa: "千代田区", kind: .city),
    ]

    @Test(arguments: ["", "prefecture:", "prefecture:99", "city:13", "prefecture:13:1", "bad:13"])
    func invalidRegionDoesNotFallBackToNationwide(id: String) {
        #expect(throws: EQIntentError.invalidRegion) {
            try EarthquakeIntentRequest.resolve(regionID: id, limit: 3, settings: .init(isPro: true), areas: areas)
        }
    }

    @Test func nationwideNeedsNoSubscription() throws {
        #expect(try EarthquakeIntentRequest.resolve(regionID: nil, limit: 3, settings: .init(), areas: areas).plan == .nationwide)
    }

    @Test(arguments: ["prefecture:13", "city:1310100"])
    func specifiedRegionRequiresPro(id: String) {
        #expect(throws: EQIntentError.proRequired) {
            try EarthquakeIntentRequest.resolve(regionID: id, limit: 3, settings: .init(), areas: areas)
        }
    }

    @Test(arguments: [0, -1, 11, Int.max])
    func invalidLimitIsRejected(limit: Int) {
        #expect(throws: EQIntentError.invalidLimit) {
            try EarthquakeIntentRequest.resolve(regionID: nil, limit: limit, settings: .init(), areas: areas)
        }
    }

    @Test func savedLocationDoesNotClaimFreshnessOrRequirePro() throws {
        let request = try EarthquakeIntentRequest.resolve(
            regionID: "region:350", limit: 3,
            settings: .init(currentLocationRegionCode: "350", currentLocationRegionName: "東京都２３区"), areas: areas)
        #expect(request.plan == .region(code: "350"))
        #expect(request.area == "保存地域（東京都２３区）")
        #expect(request.locationNotice.contains("取得時刻は不明"))
        #expect(request.locationNotice.contains("現在地とは限りません"))
    }

    @Test(arguments: [WidgetRegionSettings(), .init(currentLocationRegionCode: "350"),
                      .init(currentLocationRegionCode: "351", currentLocationRegionName: "別の地域")])
    func unknownOrMovedLocationRequiresNewInvocation(settings: WidgetRegionSettings) {
        #expect(throws: EQIntentError.locationUnavailable) {
            try EarthquakeIntentRequest.resolve(regionID: "region:350", limit: 3, settings: settings, areas: areas)
        }
    }

    @Test func snapshotsRemainIndependentAndRefreshDoesNotChangeReturnedValue() async throws {
        let store = EarthquakeSnippetStore()
        let request = try EarthquakeIntentRequest.resolve(regionID: nil, limit: 3, settings: .init(), areas: areas)
        let item = EarthquakeDisplayItem(from: try EarthquakeIntentDialogTests().earthquake())
        let original = [item]
        let id = await store.save(.init(request: request, items: original, fetchedAt: Date(), wasRefreshed: false))
        let otherID = await store.save(.init(request: request, items: [], fetchedAt: Date(), wasRefreshed: false))
        #expect(try await store.get(id).items == original)
        _ = await store.save(.init(request: request, items: [], fetchedAt: Date(), wasRefreshed: true), id: id)
        #expect(try await store.get(id).items.isEmpty)
        #expect(try await store.get(id).wasRefreshed)
        #expect(try await !store.get(otherID).wasRefreshed)
        #expect(original == [item])
    }

    @Test func missingSnapshotIsExplicitError() async {
        let store = EarthquakeSnippetStore()
        await #expect(throws: EQIntentError.snapshotUnavailable) { try await store.get("missing") }
    }

    @Test func mainIntentRejectsInvalidLimitBeforeFetching() async {
        var intent = GetLatestEarthquakesIntent()
        intent.limit = 0
        await #expect(throws: EQIntentError.invalidLimit) { try await intent.perform() }
    }

    @Test func snippetAndRefreshRejectInvalidRegionBeforeFetching() async {
        let snippet = EarthquakeSnippetIntent(regionID: "bad:13", minIntensity: nil, limit: 3, snapshotID: nil)
        await #expect(throws: EQIntentError.invalidRegion) { try await snippet.perform() }
        let refresh = RefreshEarthquakeSnippetIntent(regionID: "bad:13", minIntensity: nil, limit: 3, snapshotID: "missing")
        await #expect(throws: EQIntentError.invalidRegion) { try await refresh.perform() }
    }

    @Test func entityKeepsEarthquakeMaximum() throws {
        let item = EarthquakeDisplayItem(from: Components.Schemas.IntensityPrefectureSearchItem(
            intensity: ._1, earthquake: try EarthquakeIntentDialogTests().earthquake()))
        #expect(EarthquakeEntity(item: item).maxIntensity == "4")
    }

    @Test func errorMessagesDoNotExposeRawErrors() {
        let network = APIError.from(URLError(.notConnectedToInternet))
        #expect(network.errorDescription == "インターネットに接続されていません")
        let decoding = DecodingError.dataCorrupted(.init(codingPath: [], debugDescription: "private payload"))
        #expect(APIError.from(decoding).errorDescription == WidgetErrorMessage.unknown)
    }
}
