//
//  EarthquakeWidgetView.swift
//  Widget

import SwiftUI
import WidgetKit

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
            let layout: WidgetLayoutKind = switch widgetFamily {
            case .systemLarge: .large
            case .systemExtraLarge: .extraLarge
            default: .medium
            }
            let maxCount = WidgetLayoutPolicy.maxItemCount(
                layout: layout,
                availableHeight: Double(geometry.size.height)
            )
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
                    VStack(spacing: 6) {
                        ForEach(Array(entry.earthquakes.prefix(maxCount))) { eq in
                            EarthquakeDetailLink(eventId: eq.id) {
                                EarthquakeRow(earthquake: eq)
                            }
                        }
                    }
                    .padding(.horizontal, 12)
                    .padding(.top, 2)
                }

                Spacer(minLength: 0)
            }
            .frame(width: geometry.size.width, height: geometry.size.height, alignment: .topLeading)
        }
    }

    private var headerTitle: String { entry.title }
}

// MARK: - Small

struct SmallWidgetView: View {
    let entry: EarthquakeEntry

    var body: some View {
        GeometryReader { geometry in
            let maxCount = WidgetLayoutPolicy.maxItemCount(
                layout: .small,
                availableHeight: Double(geometry.size.height)
            )
            VStack(alignment: .leading, spacing: 0) {
                WidgetHeader(
                    title: headerTitle,
                    updateTime: entry.date,
                    width: geometry.size.width,
                    compact: true
                )

                if let error = entry.error {
                    EQErrorView(error: error)
                        .padding(10)
                } else if entry.earthquakes.isEmpty {
                    EQEmptyView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    VStack(spacing: 6) {
                        ForEach(Array(entry.earthquakes.prefix(maxCount)), id: \.id) { eq in
                            EarthquakeDetailLink(eventId: eq.id) {
                                CompactEarthquakeRow(
                                    earthquake: eq,
                                    availableWidth: geometry.size.width - 24,
                                    intensityBadgeSize: 26
                                )
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

private struct EarthquakeDetailLink<Content: View>: View {
    let eventId: String
    let content: Content

    init(eventId: String, @ViewBuilder content: () -> Content) {
        self.eventId = eventId
        self.content = content()
    }

    var body: some View {
        if let destination = EarthquakeDetailURL.make(eventId: eventId) {
            Link(destination: destination) {
                content
            }
            .buttonStyle(.plain)
        } else {
            content
        }
    }
}

// MARK: - Header

private struct WidgetHeader: View {
    let title: String
    let updateTime: Date
    let width: CGFloat
    var compact: Bool = false

    var body: some View {
        HStack(alignment: .center, spacing: 8) {
            VStack(alignment: .leading, spacing: compact ? 1 : 2) {
                Text(title)
                    .font(AppFonts.flex(size: compact ? 12 : 15, weight: .bold))
                    .foregroundStyle(.white)
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)

                // 行に並ぶ発生時刻が JST 固定なので、更新時刻も JST に揃える
                Text("更新 \(JSTDateFormat.timeShort(updateTime))")
                    .font(AppFonts.code(size: compact ? 9 : 10))
                    .foregroundStyle(.white.opacity(0.7))
            }

            Spacer(minLength: 0)
        }
        .padding(.horizontal, compact ? 12 : 16)
        .padding(.vertical, compact ? 8 : 10)
        .frame(width: width, alignment: .leading)
        .background(Color.eqBrand)
    }
}

// MARK: - EarthquakeRow (medium / large)

struct EarthquakeRow: View {
    let earthquake: EarthquakeDisplayItem

    private var subtitle: String {
        var parts = [earthquake.formattedTime]
        if !earthquake.depth.isEmpty {
            parts.append("深さ\(earthquake.depth)")
        }
        return parts.joined(separator: " ")
    }

    var body: some View {
        HStack(spacing: 10) {
            IntensityBadge(
                intensity: earthquake.formattedIntensity,
                backgroundColor: earthquake.intensityBackgroundColor,
                textColor: earthquake.intensityTextColor
            )

            VStack(alignment: .leading, spacing: 2) {
                HStack(spacing: 4) {
                    Text(earthquake.hypocenterName)
                        .font(AppFonts.flex(size: 13, weight: .bold))
                        .foregroundStyle(Color.eqTextPrimary)
                        .lineLimit(1)
                        .minimumScaleFactor(0.8)
                        .truncationMode(.tail)

                    if let badge = earthquake.statusBadge {
                        StatusBadge(text: badge)
                    }
                }

                Text(subtitle)
                    .font(AppFonts.code(size: 10))
                    .foregroundStyle(Color.eqTextSecondary)
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
            }

            Spacer(minLength: 4)

            Text(earthquake.magnitude)
                .font(AppFonts.code(size: 12, weight: .bold))
                .foregroundStyle(Color.eqTextPrimary)
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 6)
        .background(
            RoundedRectangle(cornerRadius: DesignTokens.radiusSm, style: .continuous)
                .fill(earthquake.intensityBackgroundColor.opacity(0.4))
        )
    }
}

// MARK: - CompactEarthquakeRow (small)

struct CompactEarthquakeRow: View {
    let earthquake: EarthquakeDisplayItem
    let availableWidth: CGFloat
    var intensityBadgeSize: CGFloat = 26

    private var subtitle: String {
        var parts = [earthquake.formattedTime]
        if !earthquake.depth.isEmpty {
            parts.append("深さ\(earthquake.depth)")
        }
        return parts.joined(separator: " ")
    }

    var body: some View {
        HStack(spacing: 8) {
            IntensityBadge(
                intensity: earthquake.formattedIntensity,
                backgroundColor: earthquake.intensityBackgroundColor,
                textColor: earthquake.intensityTextColor,
                size: intensityBadgeSize
            )

            VStack(alignment: .leading, spacing: 1) {
                HStack(spacing: 3) {
                    Text(earthquake.hypocenterName)
                        .font(AppFonts.flex(size: 11, weight: .bold))
                        .foregroundStyle(Color.eqTextPrimary)
                        .lineLimit(1)
                        .minimumScaleFactor(0.75)
                        .truncationMode(.tail)

                    if let badge = earthquake.statusBadge {
                        StatusBadge(text: badge, small: true)
                    }
                }

                Text(subtitle)
                    .font(AppFonts.code(size: 9))
                    .foregroundStyle(Color.eqTextTertiary)
                    .lineLimit(1)
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            Spacer(minLength: 2)

            Text(earthquake.magnitude)
                .font(AppFonts.code(size: 10, weight: .bold))
                .foregroundStyle(Color.eqTextPrimary)
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 5)
        .background(
            RoundedRectangle(cornerRadius: DesignTokens.radiusXs, style: .continuous)
                .fill(earthquake.intensityBackgroundColor.opacity(0.4))
        )
        .frame(width: availableWidth)
    }
}

// MARK: - Shared Components

// IntensityBadge は Shared/IntensityBadge.swift へ移動（スニペットと共有するため）

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
                    .font(AppFonts.flex(size: 13, weight: .semibold))
                    .foregroundStyle(Color.eqTextPrimary)
            }

            Text(error)
                .font(AppFonts.flex(size: 11))
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
                .font(AppFonts.flex(size: 12))
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
                .font(AppFonts.code(size: mainSize, weight: .bold))
                .foregroundStyle(Color.eqTextPrimary)

            if let sub = intensity.sub {
                Text(sub)
                    .font(AppFonts.code(size: subSize))
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
