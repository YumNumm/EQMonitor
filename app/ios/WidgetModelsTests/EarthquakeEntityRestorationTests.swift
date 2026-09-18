import AppIntents
import Foundation
import Testing
import EQMonitorAPI

struct EarthquakeEntityRestorationTests {
    @Test func resolvesValidIDsInOrderAndOmitsMissingEvents() async throws {
        let source = try EarthquakeIntentDialogTests().earthquake()
        var calls: [String] = []
        let result = try await EarthquakeEntityQuery().resolve(
            identifiers: ["bad", source.event_id, source.event_id, "20260910000000"]
        ) { id in
            calls.append(id)
            return id == source.event_id ? EarthquakeDisplayItem(from: source) : nil
        }
        #expect(calls == [source.event_id, "20260910000000"])
        #expect(result.map(\.id) == [source.event_id])
        #expect(result.first?.regionalIntensity == nil)
    }

    @Test func restorationFailureDoesNotBecomeEmptySuccess() async {
        await #expect(throws: EQIntentError.fetchFailed("通信エラー")) {
            try await EarthquakeEntityQuery().resolve(identifiers: ["20260830001711"]) { _ in
                throw EQIntentError.fetchFailed("通信エラー")
            }
        }
    }

    @Test(arguments: [Components.Schemas.TelegramStatus.TRAINING, .TEST])
    func typedValuesAndStatusSurviveConversion(status: Components.Schemas.TelegramStatus) throws {
        var source = try EarthquakeIntentDialogTests().earthquake()
        source.status = status
        let item = EarthquakeDisplayItem(from: Components.Schemas.IntensityPrefectureSearchItem(
            intensity: ._1, earthquake: source))
        let entity = EarthquakeEntity(item: item)
        #expect(entity.maxIntensity == "4")
        #expect(entity.regionalIntensity == "1")
        #expect(entity.maximumIntensityValue == .four)
        #expect(entity.regionalIntensityValue == .one)
        #expect(entity.magnitudeValue == 4.8)
        #expect(entity.depthValue == 30)
        #expect(entity.originTime == source.origin_time)
        #expect(entity.isTraining == (status == .TRAINING))
        #expect(entity.isTest == (status == .TEST))
        #expect(entity.informationStatus != "通常")
    }

    @Test func unknownAndBoundedValuesAreNotExactNumbers() throws {
        var source = try EarthquakeIntentDialogTests().earthquake()
        source.origin_time = nil
        source.hypocenter?.value1.depth = .init(_type: .SHALLOW, value: 0)
        source.hypocenter?.value1.magnitude = .init(_type: .OVER_M8, value: 8)
        let entity = EarthquakeEntity(item: EarthquakeDisplayItem(from: source))
        #expect(entity.originTime == nil)
        #expect(entity.arrivalTime == nil)
        #expect(entity.depthValue == nil)
        #expect(entity.magnitudeValue == nil)
        #expect(entity.occurredAt == "時刻は不明です。")
    }

    @Test(arguments: [Components.Schemas.CatalogIntensityClass._5, ._6, .R])
    func historicalClassificationIsNotConvertedToModernIntensity(value: Components.Schemas.CatalogIntensityClass) throws {
        var source = try EarthquakeIntentDialogTests().earthquake()
        source.intensity?.value1.max_intensity_class = .init(value1: value)
        let entity = EarthquakeEntity(item: EarthquakeDisplayItem(from: source))
        #expect(entity.maximumIntensityValue?.rawValue == value.rawValue)
    }

    @Test func expiredSnapshotFailsWithoutReFetching() async throws {
        let store = EarthquakeSnippetStore()
        let request = try EarthquakeIntentRequest.resolve(regionID: nil, limit: 3, settings: .init(), areas: [])
        let now = Date()
        let id = await store.save(.init(request: request, items: [], fetchedAt: now, wasRefreshed: false))
        await #expect(throws: EQIntentError.snapshotUnavailable) {
            try await store.get(id, now: now.addingTimeInterval(3600))
        }
    }

    @Test func initialSnippetUsesSavedResultAndRejectsDifferentFilters() async throws {
        let request = try EarthquakeIntentRequest.resolve(regionID: nil, limit: 3, settings: .init(), areas: [])
        let id = await EarthquakeSnippetStore.shared.save(.init(
            request: request, items: [], fetchedAt: Date(), wasRefreshed: false))
        let snippet = EarthquakeSnippetIntent(regionID: nil, minIntensity: nil, limit: 3, snapshotID: id)
        _ = try await snippet.perform()
        let mismatch = EarthquakeSnippetIntent(regionID: nil, minIntensity: .int3, limit: 3, snapshotID: id)
        await #expect(throws: EQIntentError.invalidRegion) { try await mismatch.perform() }
    }
}
