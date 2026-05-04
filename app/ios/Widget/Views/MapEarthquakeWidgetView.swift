//
//  MapEarthquakeWidgetView.swift
//  Widget
//

import SwiftUI
import WidgetKit
import MapKit

struct MapEarthquakeWidgetView: View {
    let entry: EarthquakeEntry
    @Environment(\.widgetFamily) var widgetFamily

    var body: some View {
        GeometryReader { geometry in
            if let earthquake = entry.earthquakes.first,
               let latitude = earthquake.latitude,
               let longitude = earthquake.longitude {
                ZStack(alignment: .bottom) {
                    MapSnapshotView(
                        latitude: latitude,
                        longitude: longitude,
                        size: geometry.size
                    )

                    MapInfoOverlay(
                        earthquake: earthquake,
                        compact: widgetFamily == .systemSmall,
                        width: geometry.size.width
                    )
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
            } else if let error = entry.error {
                EQErrorView(error: error)
                    .padding()
                    .frame(width: geometry.size.width, height: geometry.size.height)
            } else {
                EQEmptyView()
                    .frame(width: geometry.size.width, height: geometry.size.height)
            }
        }
    }
}

// MARK: - Overlay

private struct MapInfoOverlay: View {
    let earthquake: EarthquakeDisplayItem
    let compact: Bool
    let width: CGFloat

    var body: some View {
        HStack(alignment: .center, spacing: compact ? 6 : 10) {
            IntensityBadge(
                intensity: earthquake.formattedIntensity,
                backgroundColor: earthquake.intensityBackgroundColor,
                textColor: earthquake.intensityTextColor,
                size: compact ? 36 : 44
            )

            VStack(alignment: .leading, spacing: compact ? 1 : 2) {
                Text(earthquake.hypocenterName)
                    .font(.system(size: compact ? 13 : 16, weight: .bold))
                    .foregroundStyle(Color.eqTextPrimary)
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)
                    .truncationMode(.tail)

                HStack(spacing: 4) {
                    Text(earthquake.magnitude)
                        .font(.system(size: compact ? 10 : 13, weight: .semibold).monospaced())
                        .foregroundStyle(Color.eqTextSecondary)

                    Text("·")
                        .foregroundStyle(Color.eqTextTertiary)

                    Text(earthquake.formattedTime)
                        .font(.system(size: compact ? 10 : 12).monospaced())
                        .foregroundStyle(Color.eqTextTertiary)
                }
                .lineLimit(1)
            }

            Spacer(minLength: 0)
        }
        .padding(.horizontal, compact ? 10 : 14)
        .padding(.vertical, compact ? 8 : 12)
        .frame(width: width)
        .background(
            Color.eqBg.opacity(0.88)
                .background(.ultraThinMaterial.opacity(0.5))
        )
    }
}

// MARK: - Map Snapshot

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
                Color.eqSurface
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
