import WidgetKit
import SwiftUI
import AppIntents

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

struct OpenEarthquakeHistoryIntent: AppIntent {
    static let title: LocalizedStringResource = "地震履歴を開く"
    static let openAppWhenRun = true

    func perform() async throws -> some IntentResult & OpensIntent {
        .result(opensIntent: OpenURLIntent(
            URL(string: "eqmonitor:///earthquake-history")!))
    }
}
