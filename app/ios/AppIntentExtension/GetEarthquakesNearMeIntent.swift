//
//  GetEarthquakesNearMeIntent.swift
//  AppIntentExtension
//
//  現在地（App Group 経由で本体アプリが書き込んだ地域）の地震情報を表示する。
//

import AppIntents
import Foundation
import EQMonitorAPI

/// `ShowsSnippetIntent` は iOS 26 以降。
@available(iOS 26.0, *)
struct GetEarthquakesNearMeIntent: AppIntent {
    static let title: LocalizedStringResource = "保存地域の地震情報を確認"
    static let description = IntentDescription(
        "アプリに保存された地域の地震情報を表示します。GPSは取得しません。保存位置の取得時刻は不明で、現在地とは限りません。"
    )

    @Parameter(title: "最小震度")
    var minIntensity: MinIntensityOption?

    @Parameter(title: "表示件数", default: 3, controlStyle: .stepper, inclusiveRange: (1, 10))
    var limit: Int

    func perform() async throws
        -> some IntentResult & ReturnsValue<[EarthquakeEntity]> & ProvidesDialog & ShowsSnippetIntent {
        try await execute(service: .shared)
    }

    func execute(
        service: EarthquakeAPIService, snapshotID: String = UUID().uuidString
    ) async throws -> some IntentResult & ReturnsValue<[EarthquakeEntity]> & ProvidesDialog & ShowsSnippetIntent {
        // 現在地未設定時の全国フォールバックは「現在地の情報」としては誤りに
        // なるため、明示エラーで案内する
        let resolved = WidgetRegionResolver.resolve(regionType: .currentLocation)
        guard case .region(let code) = resolved.plan else {
            throw EQIntentError.locationUnavailable
        }
        let request = try EarthquakeIntentRequest.current(regionID: "region:\(code)", limit: limit)
        let items = try await EarthquakeFetcher.fetch(
            plan: .region(code: code),
            limit: limit,
            minIntensity: minIntensity?.apiValue, service: service
        )
        let summary = EarthquakeIntentDialog.summary(
            items: items, area: request.area, isRegional: true
        )
        let savedSnapshotID = await EarthquakeSnippetStore.shared.save(.init(
            request: request, items: items, fetchedAt: Date(), wasRefreshed: false, minIntensity: minIntensity), id: snapshotID)
        return .result(
            value: items.map(EarthquakeEntity.init),
            dialog: IntentDialog(full: "\(request.locationNotice)\(summary)", supporting: "保存された地域の地震情報を\(items.count)件取得しました。"),
            snippetIntent: EarthquakeSnippetIntent(
                regionID: "region:\(code)",
                minIntensity: minIntensity,
                limit: limit, snapshotID: savedSnapshotID
            )
        )
    }
}
