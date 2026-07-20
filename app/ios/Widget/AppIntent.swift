//
//  AppIntent.swift
//  Widget
//
//  Created by 尾上 遼太朗 on 2025/10/09.
//

import WidgetKit
import AppIntents

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
