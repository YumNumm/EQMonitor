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
        if let earthquake = entry.earthquakes.first {
            GeometryReader { geometry in
                ZStack(alignment: .bottom) {
                    // 背景地図
                    MapSnapshotView(
                        latitude: earthquake.latitude,
                        longitude: earthquake.longitude,
                        size: geometry.size
                    )
                    
                    // 情報オーバーレイ
                    VStack(alignment: .leading, spacing: 4) {
                        Text(earthquake.hypocenterName)
                            .font(.system(size: widgetFamily == .systemSmall ? 14 : 16, weight: .bold))
                            .foregroundStyle(.primary)
                            .lineLimit(1)
                        
                        HStack(spacing: 8) {
                            Text(earthquake.formattedMagnitude)
                                .font(.system(size: widgetFamily == .systemSmall ? 12 : 14, weight: .semibold).monospaced())
                                .foregroundStyle(.secondary)
                            
                            HStack(alignment: .lastTextBaseline, spacing: 2) {
                                Text("最大震度")
                                    .font(.system(size: widgetFamily == .systemSmall ? 10 : 11))
                                    .foregroundStyle(.secondary)
                                
                                IntensityView(
                                    intensity: earthquake.formattedIntensity,
                                    mainSize: widgetFamily == .systemSmall ? 18 : 22,
                                    subSize: widgetFamily == .systemSmall ? 11 : 13
                                )
                            }
                            
                            Spacer()
                        }
                        
                        Text(earthquake.formattedTime)
                            .font(.system(size: widgetFamily == .systemSmall ? 10 : 12).monospaced())
                            .foregroundStyle(.secondary)
                    }
                    .padding(widgetFamily == .systemSmall ? 12 : 16)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(.ultraThinMaterial)
                }
            }
        } else if let error = entry.error {
            ErrorView(error: error)
                .padding()
        } else {
            EmptyView(message: "地震情報が\nありません")
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


