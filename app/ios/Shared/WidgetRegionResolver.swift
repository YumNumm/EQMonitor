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

enum WidgetRegionResolver {
    private static let suiteName = "group.net.yumnumm.eqmonitor"

    // App Group キー（Flutter 側と共有。名称厳守）
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
        let defaults = UserDefaults(suiteName: suiteName)

        switch regionType {
        case .nationwide:
            return nationwide

        case .currentLocation:
            guard let code = nonEmptyString(defaults, Key.currentLocationRegionCode) else {
                return nationwide
            }
            return ResolvedWidgetRegion(
                plan: .region(code: code),
                title: "現在地の地震履歴",
                compactTitle: "現在地"
            )

        case .specificRegion:
            guard defaults?.bool(forKey: Key.isPro) == true,
                  let code = nonEmptyString(defaults, Key.widgetRegionCode),
                  let searchType = nonEmptyString(defaults, Key.widgetRegionSearchType),
                  let plan = plan(forSearchType: searchType, code: code)
            else {
                return nationwide
            }
            let name = nonEmptyString(defaults, Key.widgetRegionName)
            let title = name.map { "\($0)の地震履歴" } ?? "地震履歴"
            return ResolvedWidgetRegion(
                plan: plan,
                title: title,
                compactTitle: name.map(shorten) ?? "地震履歴"
            )
        }
    }

    private static func plan(forSearchType searchType: String, code: String) -> WidgetFetchPlan? {
        switch searchType {
        case "prefecture":
            return .prefecture(code: code)
        case "city":
            return .city(code: code)
        default:
            return nil
        }
    }

    private static func nonEmptyString(_ defaults: UserDefaults?, _ key: String) -> String? {
        guard let value = defaults?.string(forKey: key), !value.isEmpty else {
            return nil
        }
        return value
    }

    private static func shorten(_ name: String) -> String {
        name.count > 8 ? String(name.prefix(8)) + "…" : name
    }
}
