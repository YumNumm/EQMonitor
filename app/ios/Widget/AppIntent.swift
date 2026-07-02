//
//  AppIntent.swift
//  Widget
//
//  Created by 尾上 遼太朗 on 2025/10/09.
//

import WidgetKit
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

struct EarthquakeWidgetIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource { "地震履歴設定" }
    static var description: IntentDescription {
        "表示する範囲を選択してください。「アプリで選択した地域」はEQMonitor Proで、アプリの設定画面から地域を指定できます。"
    }

    @Parameter(title: "表示範囲", default: .nationwide)
    var regionType: RegionType

    init() {}

    init(regionType: RegionType) {
        self.regionType = regionType
    }
}

// ウィジェット再読み込み用Intent
struct RefreshWidgetIntent: AppIntent {
    static var title: LocalizedStringResource { "ウィジェットを更新" }
    static var description: IntentDescription { "地震情報を最新の状態に更新します" }

    func perform() async throws -> some IntentResult {
        // すべてのウィジェットを再読み込み
        WidgetCenter.shared.reloadAllTimelines()

        // 通知を表示
        return .result(dialog: "地震情報を更新しました")
    }
}
