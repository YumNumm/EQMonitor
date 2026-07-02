//
//  AppIntentExtension.swift
//  AppIntentExtension
//
//  Created by ryotaro.onoue on 2026/07/03.
//

import AppIntents

struct EQMonitorShortcuts: AppShortcutsProvider {
    static var appShortcuts: [AppShortcut] {
        AppShortcut(
            intent: GetLatestEarthquakesIntent(),
            phrases: [
                "\(.applicationName)で最新の地震を確認",
                "\(.applicationName)で地震情報を見る",
            ],
            shortTitle: "最新の地震",
            systemImageName: "waveform.path.ecg"
        )
        AppShortcut(
            intent: GetEarthquakesNearMeIntent(),
            phrases: [
                "\(.applicationName)で現在地の地震を確認",
                "\(.applicationName)で近くの地震を見る",
            ],
            shortTitle: "現在地の地震",
            systemImageName: "location"
        )
    }
}
