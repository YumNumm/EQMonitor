//
//  EarthquakeWidgetView.swift
//  Widget
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

// MARK: - Large / Medium

struct LargeWidgetView: View {
    let entry: EarthquakeEntry
    @Environment(\.widgetFamily) var widgetFamily

    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading, spacing: 0) {
                WidgetHeader(
                    title: headerTitle,
                    updateTime: entry.date,
                    width: geometry.size.width
                )

                if let error = entry.error {
                    EQErrorView(error: error)
                        .padding(.horizontal, 16)
                        .padding(.top, 12)
                } else if entry.earthquakes.isEmpty {
                    EQEmptyView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    VStack(spacing: 0) {
                        ForEach(Array(displayedEarthquakes.enumerated()), id: \.element.id) { index, eq in
                            EarthquakeRow(
                                earthquake: eq,
                                showDivider: index < displayedEarthquakes.count - 1,
                                availableWidth: geometry.size.width
                            )
                        }
                    }
                    .padding(.vertical, 4)
                    .background(
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .fill(Color.eqSurface.opacity(0.6))
                    )
                    .padding(.horizontal, 12)
                    .padding(.top, 2)
                }

                Spacer(minLength: 0)
            }
            .frame(width: geometry.size.width, height: geometry.size.height, alignment: .topLeading)
        }
    }

    private var displayedEarthquakes: [EarthquakeDisplayItem] {
        let maxCount: Int
        switch widgetFamily {
        case .systemMedium: maxCount = 3
        case .systemLarge: maxCount = 5
        case .systemExtraLarge: maxCount = 8
        default: maxCount = 3
        }
        return Array(entry.earthquakes.prefix(maxCount))
    }

    private var headerTitle: String { entry.title }
}

// MARK: - Small

struct SmallWidgetView: View {
    let entry: EarthquakeEntry

    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading, spacing: 0) {
                HStack(spacing: 6) {
                    Image(systemName: "waveform.path.ecg")
                        .font(.system(size: 11, weight: .bold))
                        .foregroundStyle(Color.eqBrand)
                        .widgetAccentable()

                    Text(headerTitle)
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundStyle(Color.eqTextSecondary)
                        .lineLimit(1)

                    Spacer()

                    Button(intent: RefreshWidgetIntent()) {
                        Image(systemName: "arrow.clockwise")
                            .font(.system(size: 10, weight: .semibold))
                            .foregroundStyle(Color.eqBrand)
                    }
                    .buttonStyle(.plain)
                }
                .padding(.horizontal, 12)
                .padding(.top, 10)
                .padding(.bottom, 6)

                Rectangle()
                    .fill(Color.eqOutlineSoft)
                    .frame(height: 0.5)
                    .padding(.horizontal, 12)

                if let error = entry.error {
                    EQErrorView(error: error)
                        .padding(10)
                } else if entry.earthquakes.isEmpty {
                    EQEmptyView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    VStack(spacing: 0) {
                        ForEach(Array(entry.earthquakes.prefix(3).enumerated()), id: \.element.id) { index, eq in
                            CompactEarthquakeRow(
                                earthquake: eq,
                                availableWidth: geometry.size.width - 24
                            )
                            if index < min(2, entry.earthquakes.count - 1) {
                                Rectangle()
                                    .fill(Color.eqOutlineSoft.opacity(0.5))
                                    .frame(height: 0.5)
                                    .padding(.horizontal, 12)
                            }
                        }
                    }
                    .padding(.top, 6)
                    .padding(.horizontal, 12)
                }

                Spacer(minLength: 0)
            }
            .frame(width: geometry.size.width, height: geometry.size.height, alignment: .topLeading)
        }
    }

    private var headerTitle: String { entry.compactTitle }
}

// MARK: - Header

private struct WidgetHeader: View {
    let title: String
    let updateTime: Date
    let width: CGFloat

    var body: some View {
        HStack(spacing: 8) {
            ZStack {
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [Color.eqBrand, Color.eqBrand.opacity(0.7)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 30, height: 30)

                Image(systemName: "waveform.path.ecg")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundStyle(.white)
            }
            .widgetAccentable()

            VStack(alignment: .leading, spacing: 1) {
                Text(title)
                    .font(.system(size: 15, weight: .bold))
                    .foregroundStyle(Color.eqTextPrimary)
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)

                Text("更新 \(formattedTime)")
                    .font(.system(size: 10))
                    .foregroundStyle(Color.eqTextTertiary)
            }

            Spacer()

            Button(intent: RefreshWidgetIntent()) {
                Image(systemName: "arrow.clockwise")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundStyle(Color.eqBrand)
                    .frame(width: 30, height: 30)
                    .eqGlass(cornerRadius: 15)
            }
            .buttonStyle(.plain)
        }
        .padding(.horizontal, 16)
        .padding(.top, 12)
        .padding(.bottom, 10)
        .frame(width: width)
    }

    private var formattedTime: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.locale = Locale(identifier: "ja_JP")
        formatter.timeZone = TimeZone.current
        return formatter.string(from: updateTime)
    }
}

// MARK: - EarthquakeRow (medium / large)

struct EarthquakeRow: View {
    let earthquake: EarthquakeDisplayItem
    let showDivider: Bool
    let availableWidth: CGFloat

    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .center, spacing: 10) {
                IntensityBadge(
                    intensity: earthquake.formattedIntensity,
                    backgroundColor: earthquake.intensityBackgroundColor,
                    textColor: earthquake.intensityTextColor
                )

                VStack(alignment: .leading, spacing: 2) {
                    HStack(spacing: 4) {
                        Text(earthquake.hypocenterName)
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundStyle(Color.eqTextPrimary)
                            .lineLimit(1)
                            .minimumScaleFactor(0.8)
                            .truncationMode(.tail)

                        if let badge = earthquake.statusBadge {
                            StatusBadge(text: badge)
                        }
                    }

                    HStack(spacing: 6) {
                        Text(earthquake.magnitude)
                            .font(.system(size: 11).monospaced())
                            .foregroundStyle(Color.eqTextSecondary)

                        Text("深さ\(earthquake.depth)")
                            .font(.system(size: 11))
                            .foregroundStyle(Color.eqTextTertiary)

                        Spacer()

                        Text(earthquake.formattedTime)
                            .font(.system(size: 11).monospaced())
                            .foregroundStyle(Color.eqTextTertiary)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 9)

            if showDivider {
                Rectangle()
                    .fill(Color.eqOutlineSoft.opacity(0.5))
                    .frame(height: 0.5)
                    .padding(.leading, 56)
            }
        }
    }
}

// MARK: - CompactEarthquakeRow (small)

struct CompactEarthquakeRow: View {
    let earthquake: EarthquakeDisplayItem
    let availableWidth: CGFloat

    var body: some View {
        HStack(alignment: .center, spacing: 6) {
            IntensityBadge(
                intensity: earthquake.formattedIntensity,
                backgroundColor: earthquake.intensityBackgroundColor,
                textColor: earthquake.intensityTextColor,
                size: 32
            )

            VStack(alignment: .leading, spacing: 1) {
                HStack(spacing: 3) {
                    Text(earthquake.hypocenterName)
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundStyle(Color.eqTextPrimary)
                        .lineLimit(1)
                        .minimumScaleFactor(0.75)
                        .truncationMode(.tail)

                    if let badge = earthquake.statusBadge {
                        StatusBadge(text: badge, small: true)
                    }
                }

                Text("\(earthquake.magnitude) · \(earthquake.formattedTime)")
                    .font(.system(size: 9).monospaced())
                    .foregroundStyle(Color.eqTextTertiary)
                    .lineLimit(1)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.vertical, 5)
        .frame(width: availableWidth)
    }
}

// MARK: - Shared Components

struct IntensityBadge: View {
    let intensity: (main: String, sub: String?)
    let backgroundColor: Color
    let textColor: Color
    var size: CGFloat = 40

    /// サブ表示が「弱以上」など2文字以上なら小さめ＆縮小許可でバッジ内に収める
    private var isLongSub: Bool { (intensity.sub?.count ?? 0) >= 2 }

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: size * 0.22, style: .continuous)
                .fill(backgroundColor)
                .frame(width: size, height: size)

            HStack(alignment: .lastTextBaseline, spacing: 1) {
                Text(intensity.main)
                    .font(.system(size: size * 0.5, weight: .heavy).monospacedDigit())
                    .foregroundStyle(textColor)

                if let sub = intensity.sub {
                    Text(sub)
                        .font(.system(size: isLongSub ? size * 0.18 : size * 0.27, weight: .bold))
                        .foregroundStyle(textColor)
                        .baselineOffset(-1)
                        .lineLimit(1)
                        .minimumScaleFactor(0.6)
                }
            }
            .padding(.horizontal, 2)
            .frame(width: size, height: size)
        }
    }
}

private struct StatusBadge: View {
    let text: String
    var small: Bool = false

    var body: some View {
        Text(text)
            .font(.system(size: small ? 7 : 9, weight: .bold))
            .foregroundStyle(.white)
            .padding(.horizontal, small ? 3 : 4)
            .padding(.vertical, small ? 1 : 2)
            .background(Color.orange)
            .clipShape(RoundedRectangle(cornerRadius: 3))
    }
}

// MARK: - Error / Empty

struct EQErrorView: View {
    let error: String

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack(spacing: 4) {
                Image(systemName: "exclamationmark.triangle.fill")
                    .font(.system(size: 13))
                    .foregroundStyle(.orange)

                Text("取得エラー")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundStyle(Color.eqTextPrimary)
            }

            Text(error)
                .font(.system(size: 11))
                .foregroundStyle(Color.eqTextSecondary)
                .lineLimit(4)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
}

struct EQEmptyView: View {
    var body: some View {
        VStack(spacing: 6) {
            Image(systemName: "waveform.path.ecg")
                .font(.system(size: 20))
                .foregroundStyle(Color.eqTextTertiary)

            Text("地震情報なし")
                .font(.system(size: 12))
                .foregroundStyle(Color.eqTextTertiary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

// MARK: - IntensityView (互換性維持)

struct IntensityView: View {
    let intensity: (main: String, sub: String?)
    var mainSize: CGFloat = 22
    var subSize: CGFloat = 12

    var body: some View {
        HStack(alignment: .lastTextBaseline, spacing: 1) {
            Text(intensity.main)
                .font(.system(size: mainSize, weight: .bold).monospaced())
                .foregroundStyle(Color.eqTextPrimary)

            if let sub = intensity.sub {
                Text(sub)
                    .font(.system(size: subSize))
                    .foregroundStyle(Color.eqTextPrimary)
                    .baselineOffset(-2)
            }
        }
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
        configuration: EarthquakeWidgetIntent(regionType: .specificRegion),
        earthquakes: EarthquakeDisplayItem.mockData,
        error: nil,
        resolved: ResolvedWidgetRegion(
            plan: .prefecture(code: "13"),
            title: "東京都の地震履歴",
            compactTitle: "東京都"
        )
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
