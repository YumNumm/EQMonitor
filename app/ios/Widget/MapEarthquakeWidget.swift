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
            MapEarthquakeWidgetView(entry: entry)
                .containerBackground(Color.eqBg, for: .widget)
        }
        .configurationDisplayName("地震情報マップ")
        .description("最新の地震を地図で表示します")
        .supportedFamilies([.systemSmall, .systemMedium])
        .contentMarginsDisabled()
    }
}

#Preview("Small - 地図", as: .systemSmall) {
    MapEarthquakeWidget()
} timeline: {
    EarthquakeEntry(
        date: .now,
        configuration: EarthquakeWidgetIntent(regionType: .nationwide),
        earthquakes: [
            EarthquakeDisplayItem(
                id: "preview1",
                hypocenterName: "能登半島沖",
                magnitude: "M6.4",
                magnitudeValue: 6.4,
                maxIntensity: .fiveLower,
                depth: "10km",
                originTime: Date().addingTimeInterval(-1200),
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
            EarthquakeDisplayItem(
                id: "preview1",
                hypocenterName: "石川県能登地方",
                magnitude: "M7.2",
                magnitudeValue: 7.2,
                maxIntensity: .sixUpper,
                depth: "15km",
                originTime: Date().addingTimeInterval(-600),
                latitude: 37.3,
                longitude: 136.8
            )
        ],
        error: nil
    )
}
