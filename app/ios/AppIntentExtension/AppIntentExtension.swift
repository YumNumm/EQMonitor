//
//  AppIntentExtension.swift
//  AppIntentExtension
//
//  Created by ryotaro.onoue on 2026/07/03.
//

import AppIntents

// スパイク用ダミー（Task 7 で本実装に置き換えて削除）
struct PingIntent: AppIntent {
    static var title: LocalizedStringResource { "EQMonitor 接続確認" }

    func perform() async throws -> some IntentResult & ProvidesDialog {
        .result(dialog: "OK")
    }
}

struct EQMonitorShortcuts: AppShortcutsProvider {
    static var appShortcuts: [AppShortcut] {
        AppShortcut(
            intent: PingIntent(),
            phrases: ["\(.applicationName)で接続確認"],
            shortTitle: "接続確認",
            systemImageName: "waveform.path.ecg"
        )
    }
}
