//
//  LatestEarthquakeSnippetControl.swift
//  Widget
//
//  コントロールセンターからアプリ本体の地震履歴を開く。
//

import WidgetKit
import SwiftUI
import AppIntents

/// 既存コントロールの配置を維持するためkindは変更しない。
@available(iOS 26.0, *)
struct LatestEarthquakeSnippetControl: ControlWidget {
    static let kind = "net.yumnumm.eqmonitor.control.latest-earthquake"

    var body: some ControlWidgetConfiguration {
        StaticControlConfiguration(kind: Self.kind) {
            ControlWidgetButton(action: OpenEarthquakeHistoryIntent()) {
                Label("最新の地震", systemImage: "waveform.path.ecg")
            }
        }
        .displayName("最新の地震を確認")
        .description("EQMonitorを開いて地震履歴を表示します")
    }
}
