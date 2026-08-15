//
//  WidgetRegionResolver.swift
//  Widget
//
//  ウィジェットの表示範囲設定（AppIntent の RegionType）と、Flutter アプリが
//  App Group に書き込んだ状態（Pro 状態・選択地域・現在地）を突き合わせ、
//  実際に叩く API と表示タイトルを解決する。
//
//  Pro 未加入・地域未設定・現在地未設定のときは全国へフォールバックし、
//  タイトルも「全国の地震履歴」に落として誤情報を正しい情報に見せないようにする。
//

import Foundation

/// 解決後の取得プラン
enum WidgetFetchPlan: Equatable {
    case nationwide
    case region(code: String)
    case prefecture(code: String)
    case city(code: String)
}

/// 解決結果（取得プラン + 表示タイトル）
struct ResolvedWidgetRegion: Equatable {
    let plan: WidgetFetchPlan
    /// medium / large 用のタイトル
    let title: String
    /// small 用の短縮タイトル
    let compactTitle: String
}

/// App Group から読み出したウィジェット表示範囲の設定値。
///
/// `UserDefaults` を直接触ると単体テストから検証できないため、読み出し結果を
/// この値型に落としてから解決ロジックへ渡す。
struct WidgetRegionSettings: Equatable {
    var isPro: Bool
    /// Flutter の `RegionSearchType` の enum 名（`prefecture` / `region` / `city` / `station`）
    var searchType: String?
    var regionCode: String?
    var regionName: String?
    var currentLocationRegionCode: String?
    var currentLocationRegionName: String?

    init(
        isPro: Bool = false,
        searchType: String? = nil,
        regionCode: String? = nil,
        regionName: String? = nil,
        currentLocationRegionCode: String? = nil,
        currentLocationRegionName: String? = nil
    ) {
        self.isPro = isPro
        self.searchType = searchType
        self.regionCode = regionCode
        self.regionName = regionName
        self.currentLocationRegionCode = currentLocationRegionCode
        self.currentLocationRegionName = currentLocationRegionName
    }
}

enum WidgetRegionResolver {
    static let appGroupSuiteName = "group.net.yumnumm.eqmonitor"

    // App Group キー（Flutter 側の AppGroupKeys と共有。名称厳守）
    private enum Key {
        static let isPro = "isPro"
        static let widgetRegionSearchType = "widgetRegionSearchType"
        static let widgetRegionCode = "widgetRegionCode"
        static let widgetRegionName = "widgetRegionName"
        static let currentLocationRegionCode = "currentLocationRegionCode"
        static let currentLocationRegionName = "currentLocationRegionName"
    }

    private static let nationwide = ResolvedWidgetRegion(
        plan: .nationwide,
        title: "全国の地震履歴",
        compactTitle: "地震履歴"
    )

    static func resolve(regionType: RegionType) -> ResolvedWidgetRegion {
        resolve(
            regionType: regionType,
            settings: settings(from: UserDefaults(suiteName: appGroupSuiteName))
        )
    }

    static func resolve(
        regionType: RegionType,
        settings: WidgetRegionSettings
    ) -> ResolvedWidgetRegion {
        switch regionType {
        case .nationwide:
            return nationwide

        case .currentLocation:
            guard let code = nonEmpty(settings.currentLocationRegionCode) else {
                return nationwide
            }
            // 現在地は端末で変わるため、実際に使っている地域名を出して
            // どこの履歴を見ているのか分かるようにする。
            let name = nonEmpty(settings.currentLocationRegionName)
            return ResolvedWidgetRegion(
                plan: .region(code: code),
                title: name.map { "現在地(\($0))の地震履歴" } ?? "現在地の地震履歴",
                compactTitle: name.map(shorten) ?? "現在地"
            )

        case .specificRegion:
            guard settings.isPro,
                  let code = nonEmpty(settings.regionCode),
                  let searchType = nonEmpty(settings.searchType),
                  let plan = plan(forSearchType: searchType, code: code)
            else {
                return nationwide
            }
            let name = nonEmpty(settings.regionName)
            return ResolvedWidgetRegion(
                plan: plan,
                title: name.map { "\($0)の地震履歴" } ?? "地震履歴",
                compactTitle: name.map(shorten) ?? "地震履歴"
            )
        }
    }

    /// Flutter の `RegionSearchType`（`app/lib/feature/earthquake_history/data/model/
    /// earthquake_history_parameter.dart`）と対応させる。
    ///
    /// `station`（観測点）は対応する地震履歴 API が無いため解決できない。
    /// 任意地域ピッカーに新しい種別を追加するときは、ここも必ず更新すること。
    static func plan(forSearchType searchType: String, code: String) -> WidgetFetchPlan? {
        switch searchType {
        case "prefecture":
            return .prefecture(code: code)
        case "city":
            return .city(code: code)
        case "region":
            return .region(code: code)
        case "station":
            return nil
        default:
            return nil
        }
    }

    private static func settings(from defaults: UserDefaults?) -> WidgetRegionSettings {
        WidgetRegionSettings(
            isPro: defaults?.bool(forKey: Key.isPro) == true,
            searchType: defaults?.string(forKey: Key.widgetRegionSearchType),
            regionCode: defaults?.string(forKey: Key.widgetRegionCode),
            regionName: defaults?.string(forKey: Key.widgetRegionName),
            currentLocationRegionCode: defaults?
                .string(forKey: Key.currentLocationRegionCode),
            currentLocationRegionName: defaults?
                .string(forKey: Key.currentLocationRegionName)
        )
    }

    private static func nonEmpty(_ value: String?) -> String? {
        guard let value, !value.isEmpty else { return nil }
        return value
    }

    private static func shorten(_ name: String) -> String {
        name.count > 8 ? String(name.prefix(8)) + "…" : name
    }
}
