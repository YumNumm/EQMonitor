//
//  RegionType.swift
//  Shared (WidgetExtension / AppIntentExtension / WidgetModelsTests)
//
//  地震履歴ウィジェットの表示範囲設定。WidgetRegionResolver が参照するため
//  Widget/AppIntent.swift から共有ソースへ抽出した。
//

import AppIntents

enum RegionType: String, AppEnum {
    case currentLocation
    case specificRegion
    case nationwide

    static var typeDisplayRepresentation: TypeDisplayRepresentation {
        "表示範囲"
    }

    static var caseDisplayRepresentations: [RegionType: DisplayRepresentation] {
        [
            .currentLocation: "現在地",
            .specificRegion: "アプリで選択した地域",
            .nationwide: "全国"
        ]
    }
}
