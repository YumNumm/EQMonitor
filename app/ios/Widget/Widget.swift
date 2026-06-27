//
//  Widget.swift
//  Widget
//
//  Created by 尾上 遼太朗 on 2025/10/09.
//

import WidgetKit
import SwiftUI

struct EarthquakeEntry: TimelineEntry {
    let date: Date
    let configuration: EarthquakeWidgetIntent
    let earthquakes: [EarthquakeDisplayItem]
    let error: String?
}

struct EarthquakeTimelineProvider: AppIntentTimelineProvider {
    typealias Entry = EarthquakeEntry
    typealias Intent = EarthquakeWidgetIntent

    func placeholder(in context: Context) -> EarthquakeEntry {
        EarthquakeEntry(
            date: Date(),
            configuration: EarthquakeWidgetIntent(),
            earthquakes: EarthquakeDisplayItem.mockData,
            error: nil
        )
    }

    func snapshot(for configuration: EarthquakeWidgetIntent, in context: Context) async -> EarthquakeEntry {
        EarthquakeEntry(
            date: Date(),
            configuration: configuration,
            earthquakes: EarthquakeDisplayItem.mockData,
            error: nil
        )
    }

    func timeline(for configuration: EarthquakeWidgetIntent, in context: Context) async -> Timeline<EarthquakeEntry> {
        let currentDate = Date()

        do {
            let apiService = EarthquakeAPIService.shared

            // 地域コードを決定
            let regionCode: String? = {
                switch configuration.regionType {
                case .nationwide:
                    return nil
                case .currentLocation:
                    // TODO(YumNumm): 位置情報をUserDefaultsから取ってくる
                    return "350"
                case .specificRegion:
                    return configuration.region?.id
                }
            }()

            let earthquakes: [EarthquakeDisplayItem]

            if let code = regionCode {
                earthquakes = try await apiService.fetchEarthquakesByRegion(
                    regionCode: code,
                    limit: 10
                )
            } else {
                earthquakes = try await apiService.fetchEarthquakes(limit: 10)
            }

            let entry = EarthquakeEntry(
                date: currentDate,
                configuration: configuration,
                earthquakes: earthquakes,
                error: nil
            )

            // 15分後に更新
            let nextUpdate = Calendar.current.date(byAdding: .minute, value: 15, to: currentDate)!
            return Timeline(entries: [entry], policy: .after(nextUpdate))

        } catch let error as APIError {
            let entry = EarthquakeEntry(
                date: currentDate,
                configuration: configuration,
                earthquakes: [],
                error: error.errorDescription
            )

            // エラー時は5分後に再試行
            let nextUpdate = Calendar.current.date(byAdding: .minute, value: 5, to: currentDate)!
            return Timeline(entries: [entry], policy: .after(nextUpdate))

        } catch {
            let entry = EarthquakeEntry(
                date: currentDate,
                configuration: configuration,
                earthquakes: [],
                error: "不明なエラー: \(error.localizedDescription)"
            )

            let nextUpdate = Calendar.current.date(byAdding: .minute, value: 5, to: currentDate)!
            return Timeline(entries: [entry], policy: .after(nextUpdate))
        }
    }
}

struct EarthquakeWidget: Widget {
    let kind: String = "EarthquakeWidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(
            kind: kind,
            intent: EarthquakeWidgetIntent.self,
            provider: EarthquakeTimelineProvider()
        ) { entry in
            EarthquakeWidgetView(entry: entry)
                .containerBackground(.eqSurfaceGradient, for: .widget)
        }
        .configurationDisplayName("地震履歴")
        .description("最近の地震情報を表示します")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
        .contentMarginsDisabled()
    }
}

#Preview("Small - 全国", as: .systemSmall) {
    EarthquakeWidget()
} timeline: {
    EarthquakeEntry(
        date: .now,
        configuration: EarthquakeWidgetIntent(regionType: .nationwide),
        earthquakes: EarthquakeDisplayItem.mockData,
        error: nil
    )
}

#Preview("Medium - 全国", as: .systemMedium) {
    EarthquakeWidget()
} timeline: {
    EarthquakeEntry(
        date: .now,
        configuration: EarthquakeWidgetIntent(regionType: .nationwide),
        earthquakes: EarthquakeDisplayItem.mockData,
        error: nil
    )
}

#Preview("Large - 指定地域", as: .systemLarge) {
    EarthquakeWidget()
} timeline: {
    EarthquakeEntry(
        date: .now,
        configuration: EarthquakeWidgetIntent(
            regionType: .specificRegion,
            region: RegionEntity(id: "350", name: "東京都２３区")
        ),
        earthquakes: EarthquakeDisplayItem.mockData,
        error: nil
    )
}

#Preview("Small - エラー", as: .systemSmall) {
    EarthquakeWidget()
} timeline: {
    EarthquakeEntry(
        date: .now,
        configuration: EarthquakeWidgetIntent(regionType: .nationwide),
        earthquakes: [],
        error: "ネットワークエラー: インターネット接続がありません"
    )
}

#Preview("Medium - 6強", as: .systemMedium) {
    EarthquakeWidget()
} timeline: {
    EarthquakeEntry(
        date: .now,
        configuration: EarthquakeWidgetIntent(regionType: .nationwide),
        earthquakes: [
            EarthquakeDisplayItem(
                id: "20260106120000",
                hypocenterName: "能登半島沖",
                magnitude: "M7.2",
                magnitudeValue: 7.2,
                maxIntensity: .sixUpper,
                depth: "15km",
                originTime: Date().addingTimeInterval(-600),
                latitude: 37.5,
                longitude: 137.0
            ),
            EarthquakeDisplayItem(
                id: "20260106110000",
                hypocenterName: "石川県能登地方",
                magnitude: "M5.8",
                magnitudeValue: 5.8,
                maxIntensity: .fiveUpper,
                depth: "12km",
                originTime: Date().addingTimeInterval(-3600),
                latitude: 37.3,
                longitude: 136.8
            )
        ],
        error: nil
    )
}
