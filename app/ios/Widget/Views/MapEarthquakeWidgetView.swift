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
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        GeometryReader { geometry in
            if let earthquake = entry.earthquakes.first,
               let latitude = earthquake.latitude,
               let longitude = earthquake.longitude {
                let compact = widgetFamily == .systemSmall
                ZStack(alignment: .bottom) {
                    MapSnapshotView(
                        latitude: latitude,
                        longitude: longitude,
                        size: geometry.size,
                        colorScheme: colorScheme
                    )

                    // 震源マーカー（地図中心 = 震源）
                    EpicenterMarker(color: earthquake.intensityBackgroundColor)

                    // 下部の可読性確保スクリム
                    LinearGradient(
                        colors: [.clear, .black.opacity(0.28)],
                        startPoint: .center,
                        endPoint: .bottom
                    )
                    .allowsHitTesting(false)

                    MapInfoOverlay(earthquake: earthquake, compact: compact)
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

// MARK: - Epicenter Marker

private struct EpicenterMarker: View {
    let color: Color

    var body: some View {
        ZStack {
            Circle()
                .fill(color.opacity(0.16))
                .frame(width: 60, height: 60)

            Circle()
                .strokeBorder(color.opacity(0.55), lineWidth: 2)
                .frame(width: 40, height: 40)

            Circle()
                .fill(color)
                .frame(width: 22, height: 22)
                .overlay(
                    Image(systemName: "xmark")
                        .font(.system(size: 12, weight: .heavy))
                        .foregroundStyle(.white)
                )
                .shadow(color: .black.opacity(0.4), radius: 2, y: 1)
        }
    }
}

// MARK: - Overlay

private struct MapInfoOverlay: View {
    let earthquake: EarthquakeDisplayItem
    let compact: Bool

    var body: some View {
        HStack(alignment: .center, spacing: compact ? 8 : 11) {
            IntensityBadge(
                intensity: earthquake.formattedIntensity,
                backgroundColor: earthquake.intensityBackgroundColor,
                textColor: earthquake.intensityTextColor,
                size: compact ? 38 : 46
            )

            VStack(alignment: .leading, spacing: compact ? 1 : 3) {
                HStack(spacing: 4) {
                    Text(earthquake.hypocenterName)
                        .font(.system(size: compact ? 13 : 16, weight: .bold))
                        .foregroundStyle(Color.eqTextPrimary)
                        .lineLimit(1)
                        .minimumScaleFactor(0.7)
                        .truncationMode(.tail)

                    if let badge = earthquake.statusBadge {
                        Text(badge)
                            .font(.system(size: compact ? 8 : 9, weight: .bold))
                            .foregroundStyle(.white)
                            .padding(.horizontal, 4)
                            .padding(.vertical, 1)
                            .background(Color.orange, in: RoundedRectangle(cornerRadius: 3))
                    }
                }

                HStack(spacing: 5) {
                    Text(earthquake.magnitude)
                        .font(.system(size: compact ? 11 : 13, weight: .bold).monospacedDigit())
                        .foregroundStyle(Color.eqBrand)

                    Text("深さ\(earthquake.depth)")
                        .font(.system(size: compact ? 10 : 12))
                        .foregroundStyle(Color.eqTextSecondary)

                    if !compact {
                        Text("·")
                            .foregroundStyle(Color.eqTextTertiary)

                        Text(earthquake.formattedTime)
                            .font(.system(size: 12).monospacedDigit())
                            .foregroundStyle(Color.eqTextTertiary)
                    }
                }
                .lineLimit(1)
                .minimumScaleFactor(0.8)
            }

            Spacer(minLength: 0)
        }
        .padding(.horizontal, compact ? 11 : 14)
        .padding(.vertical, compact ? 9 : 12)
        .frame(maxWidth: .infinity)
        .eqGlass(cornerRadius: compact ? 18 : 20)
        .padding(.horizontal, compact ? 8 : 10)
        .padding(.bottom, compact ? 8 : 10)
    }
}

// MARK: - Map Snapshot

struct MapSnapshotView: View {
    let latitude: Double
    let longitude: Double
    let size: CGSize
    let colorScheme: ColorScheme

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
        .task(id: colorScheme) {
            await generateSnapshot()
        }
    }

    private func generateSnapshot() async {
        let options = MKMapSnapshotter.Options()
        options.region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude),
            span: MKCoordinateSpan(latitudeDelta: 1.8, longitudeDelta: 1.8)
        )
        options.size = size
        options.mapType = .mutedStandard
        options.pointOfInterestFilter = .excludingAll
        options.traitCollection = UITraitCollection(
            userInterfaceStyle: colorScheme == .dark ? .dark : .light
        )

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
