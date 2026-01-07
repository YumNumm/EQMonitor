//
//  EarthquakeWidgetView.swift
//  Widget
//
//  Created by Widget Generator
//

import SwiftUI
import WidgetKit
import AppIntents

struct EarthquakeWidgetView: View {
    let entry: EarthquakeEntry
    @Environment(\.widgetFamily) var widgetFamily

    var body: some View {
        switch widgetFamily {
        case .systemSmall:
            SmallWidgetView(entry: entry)
        case .systemMedium, .systemLarge:
            LargeWidgetView(entry: entry)
        default:
            LargeWidgetView(entry: entry)
        }
    }
}

// 大きいサイズ用（ヘッダー付き）
struct LargeWidgetView: View {
    let entry: EarthquakeEntry
    @Environment(\.widgetFamily) var widgetFamily

    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading, spacing: 0) {
                // ヘッダー
                HStack(spacing: 8) {
                    Image(systemName: "circle.fill")
                        .font(.title3)
                        .foregroundStyle(.white)

                    VStack(alignment: .leading, spacing: 2) {
                        Text(headerTitle)
                            .font(.system(size: 18, weight: .bold))
                            .foregroundStyle(.white)
                            .lineLimit(1)
                            .minimumScaleFactor(0.8)

                        Text("最終更新: \(formattedUpdateTime)")
                            .font(.system(size: 11))
                            .foregroundStyle(.white.opacity(0.8))
                            .lineLimit(1)
                    }

                    Spacer()

                    // 再読み込みボタン
                    Button(intent: RefreshWidgetIntent()) {
                        Image(systemName: "arrow.clockwise")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(.white)
                            .padding(8)
                            .background(Color.white.opacity(0.2))
                            .clipShape(Circle())
                    }
                    .buttonStyle(.plain)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .frame(width: geometry.size.width)
                .background(
                    LinearGradient(
                        stops: [
                            Gradient.Stop(color: Color(red: 0.23, green: 0.38, blue: 0.9), location: 0.00),
                            Gradient.Stop(color: Color(red: 0.05, green: 0.26, blue: 0.66), location: 1.00),
                        ],
                        startPoint: UnitPoint(x: 0.5, y: 0),
                        endPoint: UnitPoint(x: 0.5, y: 1)
                    )
                )

                // エラー表示
                if let error = entry.error {
                    ErrorView(error: error)
                        .padding()
                } else if entry.earthquakes.isEmpty {
                    EmptyView(message: "地震情報がありません")
                        .padding()
                } else {
                    // 地震リスト（サイズに応じて件数制限）
                    VStack(spacing: 0) {
                        ForEach(Array(displayedEarthquakes.enumerated()), id: \.element.id) { index, earthquake in
                            EarthquakeRow(
                                earthquake: earthquake,
                                showDivider: index < displayedEarthquakes.count - 1,
                                availableWidth: geometry.size.width
                            )
                        }
                    }
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height, alignment: .topLeading)
        }
    }

    // ウィジェットサイズに応じた表示件数
    var displayedEarthquakes: [EarthquakeDisplayItem] {
        let maxCount: Int
        switch widgetFamily {
        case .systemMedium:
            maxCount = 3
        case .systemLarge:
            maxCount = 5
        case .systemExtraLarge:
            maxCount = 8
        default:
            maxCount = 3
        }
        return Array(entry.earthquakes.prefix(maxCount))
    }

    var headerTitle: String {
        switch entry.configuration.regionType {
        case .nationwide:
            return "全国の地震履歴"
        case .currentLocation:
            return "現在地の地震履歴"
        case .specificRegion:
            if let region = entry.configuration.region {
                return "\(region.name)の地震履歴"
            }
            return "地震履歴"
        }
    }

    var formattedUpdateTime: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.locale = Locale(identifier: "ja_JP")
        formatter.timeZone = TimeZone.current
        return formatter.string(from: entry.date)
    }
}

// 小さいサイズ用（ヘッダーなし）
struct SmallWidgetView: View {
    let entry: EarthquakeEntry

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                // コンパクトヘッダー（再読み込みボタン付き）
                HStack(spacing: 4) {
                    Text(headerTitle)
                        .font(.system(size: 11, weight: .bold))
                        .foregroundStyle(.primary)

                    Spacer()

                    // 再読み込みボタン
                    Button(intent: RefreshWidgetIntent()) {
                        Image(systemName: "arrow.clockwise")
                            .font(.system(size: 10, weight: .semibold))
                            .foregroundStyle(.blue)
                    }
                    .buttonStyle(.plain)
                }
                .padding(.horizontal, 10)
                .padding(.top, 8)
                .padding(.bottom, 4)

                Divider()
                    .padding(.horizontal, 10)

                // コンテンツ
                if let error = entry.error {
                    ErrorView(error: error)
                        .padding(8)
                } else if entry.earthquakes.isEmpty {
                    EmptyView(message: "地震情報が\nありません")
                        .padding(8)
                } else {
                    VStack(spacing: 4) {
                        ForEach(Array(entry.earthquakes.prefix(3).enumerated()), id: \.element.id) { index, earthquake in
                            CompactEarthquakeRow(
                                earthquake: earthquake,
                                availableWidth: geometry.size.width - 20
                            )
                            if index < min(2, entry.earthquakes.count - 1) {
                                Divider()
                                    .background(Color.primary.opacity(0.15))
                            }
                        }
                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                }

                Spacer(minLength: 0)
            }
            .frame(width: geometry.size.width, height: geometry.size.height, alignment: .topLeading)
        }
    }

    var headerTitle: String {
        switch entry.configuration.regionType {
        case .nationwide:
            return "地震履歴"
        case .currentLocation:
            return "現在地"
        case .specificRegion:
            if let region = entry.configuration.region {
                // 長い地域名を短縮
                let name = region.name
                if name.count > 8 {
                    return String(name.prefix(8)) + "..."
                }
                return name
            }
            return "地震履歴"
        }
    }
}

// 地震行（大きいサイズ用）
struct EarthquakeRow: View {
    let earthquake: EarthquakeDisplayItem
    let showDivider: Bool
    let availableWidth: CGFloat

    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .center, spacing: 12) {
                VStack(alignment: .leading, spacing: 2) {
                    HStack(spacing: 4) {
                        Text(earthquake.hypocenterName)
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundStyle(.primary)
                            .lineLimit(1)
                            .minimumScaleFactor(0.8)
                            .truncationMode(.tail)

                        // テスト・訓練バッジ
                        if let badge = earthquake.statusBadge {
                            Text(badge)
                                .font(.system(size: 9, weight: .bold))
                                .foregroundStyle(.white)
                                .padding(.horizontal, 4)
                                .padding(.vertical, 2)
                                .background(Color.orange)
                                .clipShape(RoundedRectangle(cornerRadius: 3))
                        }
                    }
                    .frame(maxWidth: availableWidth - 120, alignment: .leading)

                    HStack(spacing: 4) {
                        Text(earthquake.magnitude)
                            .font(.system(size: 12).monospaced())

                        Text("深さ\(earthquake.depth)")
                            .font(.system(size: 12))

                        Text("/")
                            .font(.system(size: 12))
                            .foregroundStyle(.secondary)

                        Text(earthquake.formattedTime)
                            .font(.system(size: 12).monospaced())
                    }
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
                    .minimumScaleFactor(0.85)
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                Spacer(minLength: 4)

                VStack(alignment: .trailing, spacing: 0) {
                    Text("最大震度")
                        .font(.system(size: 9))
                        .foregroundStyle(.secondary)

                    IntensityView(intensity: earthquake.formattedIntensity)
                }
                .frame(width: 60, alignment: .trailing)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 10)

            if showDivider {
                Divider()
                    .background(Color.primary.opacity(0.1))
                    .padding(.leading, 16)
            }
        }
    }
}

// コンパクト地震行（小さいサイズ用）
struct CompactEarthquakeRow: View {
    let earthquake: EarthquakeDisplayItem
    let availableWidth: CGFloat

    var body: some View {
        HStack(alignment: .center, spacing: 4) {
            VStack(alignment: .leading, spacing: 1) {
                HStack(spacing: 2) {
                    Text(earthquake.hypocenterName)
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundStyle(.primary)
                        .lineLimit(1)
                        .minimumScaleFactor(0.7)
                        .truncationMode(.tail)

                    // テスト・訓練バッジ（コンパクト）
                    if let badge = earthquake.statusBadge {
                        Text(badge)
                            .font(.system(size: 7, weight: .bold))
                            .foregroundStyle(.white)
                            .padding(.horizontal, 2)
                            .padding(.vertical, 1)
                            .background(Color.orange)
                            .clipShape(RoundedRectangle(cornerRadius: 2))
                    }
                }
                .frame(maxWidth: availableWidth * 0.5, alignment: .leading)

                Text("\(earthquake.magnitude) \(earthquake.depth)")
                    .font(.system(size: 9).monospaced())
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            Spacer(minLength: 0)

            HStack(spacing: 4) {
                VStack(alignment: .trailing, spacing: 0) {
                    Text("震度")
                        .font(.system(size: 7))
                        .foregroundStyle(.secondary)

                    IntensityView(
                        intensity: earthquake.formattedIntensity,
                        mainSize: 16,
                        subSize: 10
                    )
                }
                .frame(width: 32)

                Text(earthquake.formattedTime)
                    .font(.system(size: 8).monospaced())
                    .foregroundStyle(.blue)
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
                    .frame(width: 45, alignment: .trailing)
            }
        }
        .frame(width: availableWidth)
    }
}

// 震度表示（強弱を下付きに）
struct IntensityView: View {
    let intensity: (main: String, sub: String?)
    var mainSize: CGFloat = 22
    var subSize: CGFloat = 12

    var body: some View {
        HStack(alignment: .lastTextBaseline, spacing: 1) {
            Text(intensity.main)
                .font(.system(size: mainSize, weight: .bold).monospaced())
                .foregroundStyle(.primary)

            if let sub = intensity.sub {
                Text(sub)
                    .font(.system(size: subSize))
                    .foregroundStyle(.primary)
                    .baselineOffset(-2)
            }
        }
    }
}

// エラー表示
struct ErrorView: View {
    let error: String

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack(spacing: 4) {
                Image(systemName: "exclamationmark.triangle.fill")
                    .font(.system(size: 13))
                    .foregroundStyle(.orange)
                Text("取得時にエラーが発生しました")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundStyle(.primary)
            }

            Text(error)
                .font(.system(size: 11))
                .foregroundStyle(.secondary)
                .lineLimit(4)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
}

// 空表示
struct EmptyView: View {
    let message: String

    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: "info.circle")
                .font(.system(size: 24))
                .foregroundStyle(.secondary)

            Text(message)
                .font(.system(size: 13))
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

// MARK: - Previews

#Preview("Small", as: .systemSmall) {
    EarthquakeWidget()
} timeline: {
    EarthquakeEntry(
        date: .now,
        configuration: EarthquakeWidgetIntent(regionType: .nationwide),
        earthquakes: EarthquakeDisplayItem.mockData,
        error: nil
    )
}

#Preview("Medium", as: .systemMedium) {
    EarthquakeWidget()
} timeline: {
    EarthquakeEntry(
        date: .now,
        configuration: EarthquakeWidgetIntent(regionType: .nationwide),
        earthquakes: EarthquakeDisplayItem.mockData,
        error: nil
    )
}

#Preview("Large", as: .systemLarge) {
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

#Preview("Small - Error", as: .systemSmall) {
    EarthquakeWidget()
} timeline: {
    EarthquakeEntry(
        date: .now,
        configuration: EarthquakeWidgetIntent(regionType: .nationwide),
        earthquakes: [],
        error: "ネットワークエラー: インターネット接続がありません"
    )
}

#Preview("Small - Empty", as: .systemSmall) {
    EarthquakeWidget()
} timeline: {
    EarthquakeEntry(
        date: .now,
        configuration: EarthquakeWidgetIntent(regionType: .nationwide),
        earthquakes: [],
        error: nil
    )
}

#Preview("Large - 震度6強", as: .systemLarge) {
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
