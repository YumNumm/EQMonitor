import AppIntents
import Foundation
import SwiftUI
import EQMonitorAPI

@available(iOS 26.0, *)
struct EarthquakeSnippetIntent: SnippetIntent {
    static let title: LocalizedStringResource = "地震情報カード"

    @Parameter(title: "地域ID") var regionID: String?
    @Parameter(title: "最小震度") var minIntensity: MinIntensityOption?
    @Parameter(title: "表示件数", default: 3) var limit: Int
    @Parameter(title: "取得結果ID") var snapshotID: String?

    init() {}
    init(regionID: String?, minIntensity: MinIntensityOption?, limit: Int, snapshotID: String? = nil) {
        self.regionID = regionID
        self.minIntensity = minIntensity
        self.limit = limit
        self.snapshotID = snapshotID
    }

    func perform() async throws -> some IntentResult & ShowsSnippetView {
        try await execute(service: .shared)
    }

    func execute(service: EarthquakeAPIService) async throws -> some IntentResult & ShowsSnippetView {
        let request = try EarthquakeIntentRequest.current(regionID: regionID, limit: limit)
        let id: String
        if let snapshotID {
            id = snapshotID
        } else {
            let items = try await EarthquakeFetcher.fetch(
                plan: request.plan, limit: limit, minIntensity: minIntensity?.apiValue, service: service)
            id = await EarthquakeSnippetStore.shared.save(.init(
                request: request, items: items, fetchedAt: Date(), wasRefreshed: false, minIntensity: minIntensity))
        }
        let snapshot = try await EarthquakeSnippetStore.shared.get(id)
        guard snapshot.request.plan == request.plan, snapshot.request.limit == limit,
              snapshot.minIntensity == minIntensity else { throw EQIntentError.invalidRegion }
        return .result(view: EarthquakeSnippetView(
            title: snapshot.request.area + "の地震情報"
                + (minIntensity.map { "（\(MinIntensityOption.caseDisplayRepresentations[$0]?.title ?? "")）" } ?? ""),
            items: snapshot.items,
            fetchedAt: snapshot.fetchedAt,
            notice: snapshot.request.locationNotice,
            wasRefreshed: snapshot.wasRefreshed,
            reloadIntent: RefreshEarthquakeSnippetIntent(
                regionID: regionID, minIntensity: minIntensity, limit: limit, snapshotID: id)
        ))
    }
}

/// 更新は同じ地域のカードだけを更新する。後続アクションへ渡した値は書き換えない。
@available(iOS 26.0, *)
struct RefreshEarthquakeSnippetIntent: AppIntent {
    static let title: LocalizedStringResource = "同じ地域のカードを更新"
    static let isDiscoverable = false
    @Parameter(title: "地域ID") var regionID: String?
    @Parameter(title: "最小震度") var minIntensity: MinIntensityOption?
    @Parameter(title: "表示件数", default: 3) var limit: Int
    @Parameter(title: "取得結果ID") var snapshotID: String

    init() {}
    init(regionID: String?, minIntensity: MinIntensityOption?, limit: Int, snapshotID: String) {
        self.regionID = regionID
        self.minIntensity = minIntensity
        self.limit = limit
        self.snapshotID = snapshotID
    }

    func perform() async throws -> some IntentResult & ShowsSnippetIntent {
        try await execute(service: .shared)
    }

    func execute(service: EarthquakeAPIService) async throws -> some IntentResult & ShowsSnippetIntent {
        let request = try EarthquakeIntentRequest.current(regionID: regionID, limit: limit)
        let previous = try await EarthquakeSnippetStore.shared.get(snapshotID)
        guard previous.request.plan == request.plan, previous.request.limit == limit,
              previous.minIntensity == minIntensity else { throw EQIntentError.invalidRegion }
        let items = try await EarthquakeFetcher.fetch(
            plan: request.plan, limit: limit, minIntensity: minIntensity?.apiValue, service: service)
        _ = await EarthquakeSnippetStore.shared.save(.init(
            request: request, items: items, fetchedAt: Date(), wasRefreshed: true, minIntensity: minIntensity), id: snapshotID)
        return .result(snippetIntent: EarthquakeSnippetIntent(
            regionID: regionID, minIntensity: minIntensity, limit: limit, snapshotID: snapshotID))
    }
}
