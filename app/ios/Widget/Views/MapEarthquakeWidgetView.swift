//
//  MapEarthquakeWidgetView.swift
//  Widget
//
//  Created by Widget Generator
//

import SwiftUI
import WidgetKit
import MapKit

// 地図付き地震Widget（直近1件のみ）
struct MapEarthquakeWidgetView: View {
    let entry: EarthquakeEntry
    @Environment(\.widgetFamily) var widgetFamily
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        GeometryReader { geometry in
            if let earthquake = entry.earthquakes.first,
               let latitude = earthquake.latitude,
               let longitude = earthquake.longitude {
                ZStack(alignment: .bottom) {
                    // 背景地図
                    MapSnapshotView(
                        latitude: latitude,
                        longitude: longitude,
                        size: geometry.size
                    )

                    // 情報オーバーレイ
                    VStack(alignment: .leading, spacing: widgetFamily == .systemSmall ? 2 : 4) {
                        Text(earthquake.hypocenterName)
                            .font(.system(size: widgetFamily == .systemSmall ? 13 : 16, weight: .bold))
                            .foregroundStyle(.primary)
                            .lineLimit(1)
                            .minimumScaleFactor(0.7)
                            .truncationMode(.tail)
                            .frame(maxWidth: geometry.size.width - (widgetFamily == .systemSmall ? 20 : 32), alignment: .leading)

                        HStack(spacing: widgetFamily == .systemSmall ? 3 : 6) {
                            Text(earthquake.magnitude)
                                .font(.system(size: widgetFamily == .systemSmall ? 11 : 14, weight: .semibold).monospaced())
                                .foregroundStyle(.secondary)
                                .lineLimit(1)
                                .minimumScaleFactor(0.85)

                            HStack(alignment: .lastTextBaseline, spacing: 2) {
                                Text("最大震度")
                                    .font(.system(size: widgetFamily == .systemSmall ? 9 : 11))
                                    .foregroundStyle(.secondary)

                                IntensityView(
                                    intensity: earthquake.formattedIntensity,
                                    mainSize: widgetFamily == .systemSmall ? 16 : 20,
                                    subSize: widgetFamily == .systemSmall ? 10 : 12
                                )
                            }

                            Spacer(minLength: 0)
                        }

                        Text(earthquake.formattedTime)
                            .font(.system(size: widgetFamily == .systemSmall ? 9 : 12).monospaced())
                            .foregroundStyle(.secondary)
                            .lineLimit(1)
                            .minimumScaleFactor(0.85)
                    }
                    .padding(widgetFamily == .systemSmall ? 8 : 14)
                    .frame(width: geometry.size.width, alignment: .leading)
                    .background(.ultraThinMaterial)
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
            } else if let error = entry.error {
                ErrorView(error: error)
                    .padding()
                    .frame(width: geometry.size.width, height: geometry.size.height)
            } else {
                EmptyView(message: "地震情報が\nありません")
                    .frame(width: geometry.size.width, height: geometry.size.height)
            }
        }
    }
}

// MapKitスナップショット
struct MapSnapshotView: View {
    let latitude: Double
    let longitude: Double
    let size: CGSize

    @State private var snapshotImage: UIImage?

    var body: some View {
        Group {
            if let image = snapshotImage {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } else {
                Color.gray.opacity(0.3)
            }
        }
        .task {
            await generateSnapshot()
        }
    }

    private func generateSnapshot() async {
        let options = MKMapSnapshotter.Options()
        options.region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude),
            span: MKCoordinateSpan(latitudeDelta: 2.0, longitudeDelta: 2.0)
        )
        options.size = size
        options.mapType = .standard

        let snapshotter = MKMapSnapshotter(options: options)

        do {
            let snapshot = try await snapshotter.start()
            self.snapshotImage = snapshot.image
        } catch {
            print("Map snapshot error: \(error)")
        }
    }
}

// MARK: - Previews

#Preview("Map - Small", as: .systemSmall) {
    MapEarthquakeWidget()
} timeline: {
    EarthquakeEntry(
        date: .now,
        configuration: EarthquakeWidgetIntent(regionType: .nationwide),
        earthquakes: [EarthquakeDisplayItem.singleMockData],
        error: nil
    )
}

#Preview("Map - Medium", as: .systemMedium) {
    MapEarthquakeWidget()
} timeline: {
    EarthquakeEntry(
        date: .now,
        configuration: EarthquakeWidgetIntent(regionType: .nationwide),
        earthquakes: [EarthquakeDisplayItem.singleMockData],
        error: nil
    )
}

#Preview("Map - Medium 震度6強", as: .systemMedium) {
    MapEarthquakeWidget()
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
            )
        ],
        error: nil
    )
}

#Preview("Map - Error", as: .systemSmall) {
    MapEarthquakeWidget()
} timeline: {
    EarthquakeEntry(
        date: .now,
        configuration: EarthquakeWidgetIntent(regionType: .nationwide),
        earthquakes: [],
        error: "ネットワークエラー: インターネット接続がありません"
    )
}

#Preview("Map - Empty", as: .systemSmall) {
    MapEarthquakeWidget()
} timeline: {
    EarthquakeEntry(
        date: .now,
        configuration: EarthquakeWidgetIntent(regionType: .nationwide),
        earthquakes: [],
        error: nil
    )
}
