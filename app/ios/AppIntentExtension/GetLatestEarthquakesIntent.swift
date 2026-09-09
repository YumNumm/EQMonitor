//
//  GetLatestEarthquakesIntent.swift
//  AppIntentExtension
//
//  最新の地震情報を Interactive Snippet（カードUI）で表示するメイン Intent。
//

import AppIntents
import EQMonitorAPI
import SwiftUI

/// `ShowsSnippetIntent` は iOS 26 以降。
@available(iOS 26.0, *)
struct GetLatestEarthquakesIntent: AppIntent {
    static let title: LocalizedStringResource = "最新の地震情報を確認"
    static let description = IntentDescription(
        "最新の地震情報をカードで表示します。地域指定は EQMonitor Pro の機能です。"
    )

    @Parameter(title: "対象地域", description: "未指定の場合は全国")
    var region: RegionEntity?

    @Parameter(title: "最小震度")
    var minIntensity: MinIntensityOption?

    @Parameter(title: "表示件数", default: 3, controlStyle: .stepper, inclusiveRange: (1, 10))
    var limit: Int

    func perform() async throws
        -> some IntentResult & ReturnsValue<[EarthquakeEntity]> & ProvidesDialog & ShowsSnippetIntent {
        if region != nil, !ProStatus.isPro {
            throw EQIntentError.proRequired
        }
        let items = try await EarthquakeFetcher.fetch(
            plan: region?.fetchPlan ?? .nationwide,
            limit: limit,
            minIntensity: minIntensity?.apiValue
        )
        let summary = EarthquakeIntentDialog.summary(
            items: items, area: region?.name ?? "全国", isRegional: region != nil
        )
        return .result(
            value: items.map(EarthquakeEntity.init),
            dialog: IntentDialog(full: "\(summary)", supporting: "\(items.count)件の地震情報を取得しました。"),
            snippetIntent: EarthquakeSnippetIntent(
                regionID: region?.id,
                minIntensity: minIntensity,
                limit: limit
            )
        )
    }
}

// MARK: - Errors

enum EQIntentError: Error, CustomLocalizedStringResourceConvertible {
    case proRequired
    case locationUnavailable

    var localizedStringResource: LocalizedStringResource {
        switch self {
        case .proRequired:
            return "地域指定は EQMonitor Pro の機能です。アプリからご登録ください。"
        case .locationUnavailable:
            return "現在地が未取得です。EQMonitor アプリを起動して位置情報を有効にしてください。"
        }
    }
}
