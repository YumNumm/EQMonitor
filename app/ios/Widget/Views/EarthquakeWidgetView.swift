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
        VStack(alignment: .leading, spacing: 0) {
            // ヘッダー
            VStack(alignment: .leading, spacing: 4) {
                HStack(spacing: 8) {
                    Image(systemName: "circle.fill")
                        .font(.title3)
                        .foregroundStyle(.white)

                    VStack(alignment: .leading, spacing: 2) {
                        Text(headerTitle)
                            .font(.system(size: 18, weight: .bold))
                            .foregroundStyle(.white)

                        Text("最終更新: \(formattedUpdateTime)")
                            .font(.system(size: 11))
                            .foregroundStyle(.white.opacity(0.8))
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
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
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
                        EarthquakeRow(earthquake: earthquake, showDivider: index < displayedEarthquakes.count - 1)
                    }
                }
            }
        }
    }

    // ウィジェットサイズに応じた表示件数
    var displayedEarthquakes: [EarthquakeItem] {
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
                VStack(spacing: 6) {
                    ForEach(Array(entry.earthquakes.prefix(3).enumerated()), id: \.element.id) { index, earthquake in
                        CompactEarthquakeRow(earthquake: earthquake)
                        if index < min(2, entry.earthquakes.count - 1) {
                            Divider()
                                .background(Color.primary.opacity(0.15))
                        }
                    }
                }
                .padding(10)
            }
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
    let earthquake: EarthquakeItem
    let showDivider: Bool

    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .center, spacing: 12) {
                VStack(alignment: .leading, spacing: 2) {
                    Text(earthquake.hypocenterName)
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundStyle(.primary)
                        .lineLimit(1)

                    HStack(spacing: 4) {
                        Text(earthquake.formattedMagnitude)
                            .font(.system(size: 12).monospaced())

                        Text("深さ\(earthquake.formattedDepth)")
                            .font(.system(size: 12))

                        Text("/")
                            .font(.system(size: 12))
                            .foregroundStyle(.secondary)

                        Text(earthquake.formattedTime)
                            .font(.system(size: 12).monospaced())
                    }
                    .foregroundStyle(.secondary)
                }

                Spacer(minLength: 8)

                VStack(alignment: .trailing, spacing: 0) {
                    Text("最大震度")
                        .font(.system(size: 9))
                        .foregroundStyle(.secondary)

                    IntensityView(intensity: earthquake.formattedIntensity)
                }
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
    let earthquake: EarthquakeItem

    var body: some View {
        HStack(alignment: .center, spacing: 6) {
            VStack(alignment: .leading, spacing: 1) {
                Text(earthquake.hypocenterName)
                    .font(.system(size: 11, weight: .semibold))
                    .foregroundStyle(.primary)
                    .lineLimit(1)

                Text("\(earthquake.formattedMagnitude) \(earthquake.formattedDepth)")
                    .font(.system(size: 9).monospaced())
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
            }

            Spacer(minLength: 2)

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

            Text(earthquake.formattedTime)
                .font(.system(size: 9).monospaced())
                .foregroundStyle(.blue)
                .lineLimit(1)
                .frame(width: 60, alignment: .trailing)
        }
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
