//
//  LiveActivityExtension.swift
//  LiveActivityExtension
//
//  Created by 尾上 遼太朗 on 2024/09/02.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> EarthquakeEntry {
        EarthquakeEntry(date: Date(), earthquakeInfo: EarthquakeInfo.placeholder)
    }

    func getSnapshot(in context: Context, completion: @escaping (EarthquakeEntry) -> ()) {
        let entry = EarthquakeEntry(date: Date(), earthquakeInfo: EarthquakeInfo.placeholder)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let currentDate = Date()
        let entry = EarthquakeEntry(date: currentDate, earthquakeInfo: EarthquakeInfo.placeholder)
        let timeline = Timeline(entries: [entry], policy: .never)
        completion(timeline)
    }
}

struct EarthquakeInfo {
    let intensity: String
    let color: Color
    let hypoName: String
    let magnitude: Double
    let depth: Double
    let estimatedMaxIntensity: String

    static let placeholder = EarthquakeInfo(
        intensity: "5弱",
        color: .orange,
        hypoName: "東京湾",
        magnitude: 6.5,
        depth: 40.0,
        estimatedMaxIntensity: "6強"
    )
}

struct EarthquakeEntry: TimelineEntry {
    let date: Date
    let earthquakeInfo: EarthquakeInfo
}

struct LiveActivityExtensionEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack(spacing: 8) {
            Text("緊急地震速報")
                .font(.headline)
                .foregroundColor(.white)

            Text("\(entry.earthquakeInfo.intensity)程度")
                .font(.largeTitle)
                .fontWeight(.bold)

            Text("震源地: \(entry.earthquakeInfo.hypoName)")
                .font(.caption)
                .lineLimit(1)

            HStack {
                Text("予想最大震度: \(entry.earthquakeInfo.estimatedMaxIntensity)")
                Spacer()
                Text("M\(String(format: "%.1f", entry.earthquakeInfo.magnitude))")
            }
            .font(.caption)
        }
        .padding()
        .background(entry.earthquakeInfo.color)
    }
}

struct LiveActivityExtension: Widget {
    let kind: String = "LiveActivityExtension"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                LiveActivityExtensionEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                LiveActivityExtensionEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("地震情報")
        .description("最新の地震情報を表示します。")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

/*
 #Preview(as: .systemSmall) {
 LiveActivityExtension()
 } timeline: {
 EarthquakeEntry(date: .now, earthquakeInfo: EarthquakeInfo.placeholder)
 }
 */
