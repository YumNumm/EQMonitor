//
//  LatestEarthquakeSnippetControl.swift
//  Widget
//
//  コントロールセンターから、アプリを開かずに最新の地震情報カード
//  （EarthquakeSnippetIntent / AppIntentExtension と共有）を表示する。
//

import WidgetKit
import SwiftUI
import AppIntents

/// Interactive Snippet（`SnippetIntent`）を表示するため iOS 26 以降。
@available(iOS 26.0, *)
struct LatestEarthquakeSnippetControl: ControlWidget {
    static let kind = "net.yumnumm.eqmonitor.control.latest-earthquake"

    var body: some ControlWidgetConfiguration {
        StaticControlConfiguration(kind: Self.kind) {
            ControlWidgetButton(action: EarthquakeSnippetIntent(
                regionID: nil, minIntensity: nil, limit: 3)) {
                Label("最新の地震", systemImage: "waveform.path.ecg")
            }
        }
        .displayName("最新の地震を確認")
        .description("アプリを開かずに最新の地震情報を表示します")
    }
}
