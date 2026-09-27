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
        try await execute(service: .shared)
    }

    func execute(
        service: EarthquakeAPIService, snapshotID: String = UUID().uuidString
    ) async throws -> some IntentResult & ReturnsValue<[EarthquakeEntity]> & ProvidesDialog & ShowsSnippetIntent {
        let request = try EarthquakeIntentRequest.current(regionID: region?.id, limit: limit)
        let items = try await EarthquakeFetcher.fetch(
            plan: request.plan,
            limit: limit,
            minIntensity: minIntensity?.apiValue, service: service
        )
        let summary = EarthquakeIntentDialog.summary(
            items: items, area: request.area, isRegional: region != nil
        )
        let savedSnapshotID = await EarthquakeSnippetStore.shared.save(.init(
            request: request, items: items, fetchedAt: Date(), wasRefreshed: false, minIntensity: minIntensity), id: snapshotID)
        return .result(
            value: items.map(EarthquakeEntity.init),
            dialog: IntentDialog(full: "\(summary)", supporting: "\(items.count)件の地震情報を取得しました。"),
            snippetIntent: EarthquakeSnippetIntent(
                regionID: region?.id,
                minIntensity: minIntensity,
                limit: limit, snapshotID: savedSnapshotID
            )
        )
    }
}

// MARK: - Errors

enum EQIntentError: Error, CustomLocalizedStringResourceConvertible, Equatable {
    case proRequired
    case locationUnavailable
    case invalidRegion
    case invalidLimit
    case snapshotUnavailable
    case fetchFailed(String)

    var localizedStringResource: LocalizedStringResource {
        switch self {
        case .proRequired:
            return "地域指定は EQMonitor Pro の機能です。アプリからご登録ください。"
        case .locationUnavailable:
            return "保存地域が未設定または変更されています。EQMonitorで位置情報を確認し、もう一度実行してください。"
        case .invalidRegion:
            return "対象地域を確認できません。地域を選び直してください。"
        case .invalidLimit:
            return "表示件数は1件から10件で指定してください。"
        case .snapshotUnavailable:
            return "取得結果の表示期限が切れました。地震情報の確認をもう一度実行してください。"
        case .fetchFailed(let message):
            return "\(message)。しばらくしてからもう一度お試しください。"
        }
    }
}
