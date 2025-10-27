//
//  MapEarthquakeWidget.swift
//  Widget
//
//  Created by Widget Generator
//

import WidgetKit
import SwiftUI

struct MapEarthquakeWidget: Widget {
    let kind: String = "MapEarthquakeWidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(
            kind: kind,
            intent: EarthquakeWidgetIntent.self,
            provider: EarthquakeTimelineProvider()
        ) { entry in
            if #available(iOS 17.0, *) {
                MapEarthquakeWidgetView(entry: entry)
                    .containerBackground(.background, for: .widget)
            } else {
                MapEarthquakeWidgetView(entry: entry)
                    .containerBackground(.background, for: .widget)
            }
        }
        .configurationDisplayName("地震情報マップ")
        .description("最新の地震を地図で表示します")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

#Preview("Small - 地図", as: .systemSmall) {
    MapEarthquakeWidget()
} timeline: {
    EarthquakeEntry(
        date: .now,
        configuration: EarthquakeWidgetIntent(regionType: .nationwide),
        earthquakes: [
            EarthquakeItem(
                id: "preview1",
                magnitude: 6.4,
                magnitudeCondition: nil,
                maxIntensity: "5-",
                hypocenterName: "能登半島沖",
                depth: 10,
                originTime: Date().addingTimeInterval(-1200),
                headline: nil,
                latitude: 37.5,
                longitude: 137.0
            )
        ],
        error: nil
    )
}

#Preview("Medium - 地図", as: .systemMedium) {
    MapEarthquakeWidget()
} timeline: {
    EarthquakeEntry(
        date: .now,
        configuration: EarthquakeWidgetIntent(regionType: .nationwide),
        earthquakes: [
            EarthquakeItem(
                id: "preview1",
                magnitude: 7.2,
                magnitudeCondition: nil,
                maxIntensity: "6+",
                hypocenterName: "石川県能登地方",
                depth: 15,
                originTime: Date().addingTimeInterval(-600),
                headline: nil,
                latitude: 37.3,
                longitude: 136.8
            )
        ],
        error: nil
    )
}
