import WidgetKit
import SwiftUI
import AppIntents

/// コントロールセンターのウィジェット。`ControlWidget` は iOS 18 以降。
@available(iOS 18.0, *)
struct OpenEarthquakeHistoryControl: ControlWidget {
    static let kind = "net.yumnumm.eqmonitor.control.open-earthquake-history"

    var body: some ControlWidgetConfiguration {
        StaticControlConfiguration(kind: Self.kind) {
            ControlWidgetButton(action: OpenEarthquakeHistoryIntent()) {
                Label("地震履歴", systemImage: "clock.arrow.circlepath")
            }
        }
        .displayName("地震履歴を開く")
        .description("EQMonitor の地震履歴を開きます")
    }
}

/// `OpenURLIntent` は iOS 18 以降。
@available(iOS 18.0, *)
struct OpenEarthquakeHistoryIntent: AppIntent {
    static let title: LocalizedStringResource = "地震履歴を開く"
    static let openAppWhenRun = true

    func perform() async throws -> some IntentResult & OpensIntent {
        .result(opensIntent: OpenURLIntent(
            URL(string: "eqmonitor:///earthquake-history")!))
    }
}
