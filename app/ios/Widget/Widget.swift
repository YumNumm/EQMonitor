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
    let earthquakes: [EarthquakeItem]
    let error: String?
}

struct EarthquakeTimelineProvider: AppIntentTimelineProvider {
    typealias Entry = EarthquakeEntry
    typealias Intent = EarthquakeWidgetIntent

    func placeholder(in context: Context) -> EarthquakeEntry {
        EarthquakeEntry(
            date: Date(),
            configuration: EarthquakeWidgetIntent(),
            earthquakes: mockEarthquakes(),
            error: nil
        )
    }

    func snapshot(for configuration: EarthquakeWidgetIntent, in context: Context) async -> EarthquakeEntry {
        EarthquakeEntry(
            date: Date(),
            configuration: configuration,
            earthquakes: mockEarthquakes(),
            error: nil
        )
    }

    func timeline(for configuration: EarthquakeWidgetIntent, in context: Context) async -> Timeline<EarthquakeEntry> {
        let currentDate = Date()

        // APIクライアント初期化
        let baseURL = ConfigReader.getAPIBaseURL()

        do {
            let apiService = try EarthquakeAPIService(baseURL: baseURL)

            // 地域コードを決定
            let regionId: String? = {
                switch configuration.regionType {
                case .nationwide:
                    return nil
                case .currentLocation:
                    // モック: 東京都23区
                    return "350"
                case .specificRegion:
                    return configuration.region?.id
                }
            }()

            let earthquakes = try await apiService.fetchEarthquakes(
                limit: 10,
                regionId: regionId
            )

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

    // モックデータ（プレビュー用）
    private func mockEarthquakes() -> [EarthquakeItem] {
        [
            EarthquakeItem(
                id: mock1,
                magnitude: 6.4,
                magnitudeCondition: nil,
                maxIntensity: "5-",
                hypocenterName: "XXX県沖",
                depth: 10,
                originTime: Date().addingTimeInterval(-1200),
                headline: nil,
                latitude: 35.0,
                longitude: 139.0
            ,
                latitude: 35.6762,
                longitude: 139.6503
            ),
            EarthquakeItem(
                id: mock2,
                magnitude: nil,
                magnitudeCondition: "不明",
                maxIntensity: "4",
                hypocenterName: "YY地方西部",
                depth: nil,
                originTime: Date().addingTimeInterval(-14400),
                headline: nil,
                latitude: 35.5,
                longitude: 139.5
            ,
                latitude: 35.6762,
                longitude: 139.6503
            ),
            EarthquakeItem(
                id: mock3,
                magnitude: 8.0,
                magnitudeCondition: nil,
                maxIntensity: "5-",
                hypocenterName: "ZZZZ",
                depth: 700,
                originTime: Date().addingTimeInterval(-86400),
                headline: nil,
                latitude: 36.0,
                longitude: 140.0
            ,
                latitude: 35.6762,
                longitude: 139.6503
            )
        ]
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
            if #available(iOS 17.0, *) {
                EarthquakeWidgetView(entry: entry)
                    .containerBackground(.background, for: .widget)
            } else {
                EarthquakeWidgetView(entry: entry)
                    .containerBackground(.background, for: .widget)
            }
        }
        .configurationDisplayName("地震履歴")
        .description("最近の地震情報を表示します")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}

#Preview("Small - 全国", as: .systemSmall) {
    EarthquakeWidget()
} timeline: {
    EarthquakeEntry(
        date: .now,
        configuration: EarthquakeWidgetIntent(regionType: .nationwide),
        earthquakes: [
            EarthquakeItem(
                id: preview1,
                magnitude: 6.4,
                magnitudeCondition: nil,
                maxIntensity: "5-",
                hypocenterName: "XXX県沖",
                depth: 10,
                originTime: Date().addingTimeInterval(-1200),
                headline: nil
            ,
                latitude: 35.6762,
                longitude: 139.6503
            ),
            EarthquakeItem(
                id: preview2,
                magnitude: nil,
                magnitudeCondition: "不明",
                maxIntensity: "4",
                hypocenterName: "YY地方西部",
                depth: nil,
                originTime: Date().addingTimeInterval(-14400),
                headline: nil
            ,
                latitude: 35.6762,
                longitude: 139.6503
            ),
            EarthquakeItem(
                id: preview3,
                magnitude: 8.0,
                magnitudeCondition: nil,
                maxIntensity: "5-",
                hypocenterName: "ZZZZ",
                depth: 700,
                originTime: Date().addingTimeInterval(-86400),
                headline: nil
            ,
                latitude: 35.6762,
                longitude: 139.6503
            )
        ],
        error: nil
    )
}

#Preview("Medium - 全国", as: .systemMedium) {
    EarthquakeWidget()
} timeline: {
    EarthquakeEntry(
        date: .now,
        configuration: EarthquakeWidgetIntent(regionType: .nationwide),
        earthquakes: [
            EarthquakeItem(
                id: preview1,
                magnitude: 6.4,
                magnitudeCondition: nil,
                maxIntensity: "5-",
                hypocenterName: "XXX県沖",
                depth: 10,
                originTime: Date().addingTimeInterval(-1200),
                headline: nil
            ,
                latitude: 35.6762,
                longitude: 139.6503
            ),
            EarthquakeItem(
                id: preview2,
                magnitude: nil,
                magnitudeCondition: "不明",
                maxIntensity: "4",
                hypocenterName: "YY地方西部",
                depth: nil,
                originTime: Date().addingTimeInterval(-14400),
                headline: nil
            ,
                latitude: 35.6762,
                longitude: 139.6503
            ),
            EarthquakeItem(
                id: preview3,
                magnitude: 8.0,
                magnitudeCondition: nil,
                maxIntensity: "5+",
                hypocenterName: "ZZZZ",
                depth: 700,
                originTime: Date().addingTimeInterval(-86400),
                headline: nil
            ,
                latitude: 35.6762,
                longitude: 139.6503
            )
        ],
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
        earthquakes: [
            EarthquakeItem(
                id: preview1,
                magnitude: 6.4,
                magnitudeCondition: nil,
                maxIntensity: "5-",
                hypocenterName: "東京都２３区",
                depth: 10,
                originTime: Date().addingTimeInterval(-1200),
                headline: nil
            ,
                latitude: 35.6762,
                longitude: 139.6503
            ),
            EarthquakeItem(
                id: preview2,
                magnitude: 5.2,
                magnitudeCondition: nil,
                maxIntensity: "4",
                hypocenterName: "東京都多摩東部",
                depth: 20,
                originTime: Date().addingTimeInterval(-14400),
                headline: nil
            ,
                latitude: 35.6762,
                longitude: 139.6503
            ),
            EarthquakeItem(
                id: preview3,
                magnitude: 4.8,
                magnitudeCondition: nil,
                maxIntensity: "3",
                hypocenterName: "神奈川県東部",
                depth: 30,
                originTime: Date().addingTimeInterval(-28800),
                headline: nil
            ,
                latitude: 35.6762,
                longitude: 139.6503
            )
        ],
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
            EarthquakeItem(
                id: preview1,
                magnitude: 7.2,
                magnitudeCondition: nil,
                maxIntensity: "6+",
                hypocenterName: "能登半島沖",
                depth: 15,
                originTime: Date().addingTimeInterval(-600),
                headline: nil
            ,
                latitude: 35.6762,
                longitude: 139.6503
            ),
            EarthquakeItem(
                id: preview2,
                magnitude: 5.8,
                magnitudeCondition: nil,
                maxIntensity: "5+",
                hypocenterName: "石川県能登地方",
                depth: 12,
                originTime: Date().addingTimeInterval(-3600),
                headline: nil
            ,
                latitude: 35.6762,
                longitude: 139.6503
            )
        ],
        error: nil
    )
}
