//
//  GetEarthquakesNearMeIntent.swift
//  AppIntentExtension
//
//  現在地（App Group 経由で本体アプリが書き込んだ地域）の地震情報を表示する。
//

import AppIntents

struct GetEarthquakesNearMeIntent: AppIntent {
    static let title: LocalizedStringResource = "現在地の地震情報を確認"
    static let description = IntentDescription(
        "現在地周辺の最新の地震情報をカードで表示します。"
    )

    @Parameter(title: "最小震度")
    var minIntensity: MinIntensityOption?

    @Parameter(title: "表示件数", default: 3, controlStyle: .stepper, inclusiveRange: (1, 10))
    var limit: Int

    func perform() async throws
        -> some IntentResult & ReturnsValue<[EarthquakeEntity]> & ShowsSnippetIntent {
        // 現在地未設定時の全国フォールバックは「現在地の情報」としては誤りに
        // なるため、明示エラーで案内する
        let resolved = WidgetRegionResolver.resolve(regionType: .currentLocation)
        guard case .region(let code) = resolved.plan else {
            throw EQIntentError.locationUnavailable
        }
        let items = try await EarthquakeFetcher.fetch(
            plan: .region(code: code),
            limit: limit,
            minIntensity: minIntensity?.apiValue
        )
        return .result(
            value: items.map(EarthquakeEntity.init),
            snippetIntent: EarthquakeSnippetIntent(
                regionID: "region:\(code)",
                minIntensity: minIntensity,
                limit: limit
            )
        )
    }
}
