//
//  GetLatestEarthquakesIntent.swift
//  AppIntentExtension
//
//  最新の地震情報を Interactive Snippet（カードUI）で表示するメイン Intent。
//

import AppIntents
import EQMonitorAPI
import SwiftUI

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
        -> some IntentResult & ReturnsValue<[EarthquakeEntity]> & ShowsSnippetIntent {
        if region != nil, !ProStatus.isPro {
            throw EQIntentError.proRequired
        }
        let items = try await EarthquakeFetcher.fetch(
            plan: region?.fetchPlan ?? .nationwide,
            limit: limit,
            minIntensity: minIntensity?.apiValue
        )
        return .result(
            value: items.map(EarthquakeEntity.init),
            snippetIntent: EarthquakeSnippetIntent(
                regionID: region?.id,
                minIntensity: minIntensity,
                limit: limit
            )
        )
    }
}

// MARK: - Snippet Intent

/// カード描画本体。ボタン操作のたびにシステムが perform を再実行するため、
/// 常に最新のデータで再描画される。
struct EarthquakeSnippetIntent: SnippetIntent {
    static let title: LocalizedStringResource = "地震情報カード"

    @Parameter(title: "地域ID")
    var regionID: String?

    @Parameter(title: "最小震度")
    var minIntensity: MinIntensityOption?

    @Parameter(title: "表示件数")
    var limit: Int

    init() {}

    init(regionID: String?, minIntensity: MinIntensityOption?, limit: Int) {
        self.regionID = regionID
        self.minIntensity = minIntensity
        self.limit = limit
    }

    func perform() async throws -> some IntentResult & ShowsSnippetView {
        let items = try await EarthquakeFetcher.fetch(
            plan: Self.plan(fromRegionID: regionID),
            limit: limit,
            minIntensity: minIntensity?.apiValue
        )
        return .result(
            view: EarthquakeSnippetView(
                title: Self.snippetTitle(regionID: regionID, minIntensity: minIntensity),
                items: items,
                reloadIntent: self
            )
        )
    }

    /// `"prefecture:01"` / `"city:0123500"` / `"region:350"` → 取得プラン
    static func plan(fromRegionID id: String?) -> WidgetFetchPlan {
        guard let id else { return .nationwide }
        let parts = id.split(separator: ":", maxSplits: 1)
        guard parts.count == 2 else { return .nationwide }
        let code = String(parts[1])
        switch parts[0] {
        case "prefecture":
            return .prefecture(code: code)
        case "city":
            return .city(code: code)
        case "region":
            return .region(code: code)
        default:
            return .nationwide
        }
    }

    static func snippetTitle(regionID: String?, minIntensity: MinIntensityOption?) -> String {
        let base: String
        if let regionID {
            if regionID.hasPrefix("region:") {
                base = "現在地の地震情報"
            } else {
                let table = JmaCodeTable.shared
                let name = (table.prefectures + table.cities)
                    .first { "\($0.kind.rawValue):\($0.code)" == regionID }?
                    .nameJa
                base = name.map { "\($0)の地震情報" } ?? "地震情報"
            }
        } else {
            base = "全国の地震情報"
        }
        if let minIntensity {
            return base + "（\(MinIntensityOption.caseDisplayRepresentations[minIntensity]?.title ?? "")）"
        }
        return base
    }
}

// MARK: - Pro Status

enum ProStatus {
    /// Flutter アプリが App Group に書き込んだ Pro 加入状態
    static var isPro: Bool {
        UserDefaults(suiteName: "group.net.yumnumm.eqmonitor")?
            .bool(forKey: "isPro") == true
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
