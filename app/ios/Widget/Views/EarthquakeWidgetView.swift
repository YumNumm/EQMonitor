//
//  EarthquakeWidgetView.swift
//  Widget

import SwiftUI
import WidgetKit

struct EarthquakeWidgetView: View {
    let entry: EarthquakeEntry
    @Environment(\.widgetFamily) private var widgetFamily
    @Environment(\.widgetRenderingMode) private var renderingMode

    var body: some View {
        EarthquakeWidgetContent(
            entry: entry,
            layout: layout,
            isFullColor: renderingMode == .fullColor
        )
        // 各行は 1 行で幅に収めるため、拡大は件数を保てる範囲に留める
        .dynamicTypeSize(...(layout == .small ? DynamicTypeSize.xLarge : .xxLarge))
        .widgetURL(EarthquakeHistoryURL.list)
    }

    private var layout: WidgetLayoutKind {
        switch widgetFamily {
        case .systemSmall: .small
        case .systemLarge: .large
        default: .medium
        }
    }
}

struct EarthquakeWidgetContent: View {
    let entry: EarthquakeEntry
    let layout: WidgetLayoutKind
    /// false のときはシステムが色を単色へ置き換える（色つき・クリア・夜間の StandBy など）
    let isFullColor: Bool

    private var isCompact: Bool { layout == .small }

    var body: some View {
        VStack(spacing: 0) {
            WidgetHeader(
                title: isCompact ? entry.compactTitle : entry.title,
                status: WidgetHeaderStatus(entry: entry),
                compact: isCompact,
                isFullColor: isFullColor
            )
            content
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        }
    }

    @ViewBuilder
    private var content: some View {
        if !entry.earthquakes.isEmpty {
            rows
        } else if let error = entry.error {
            EQErrorView(error: error)
                .padding(.horizontal, isCompact ? 14 : 16)
                .padding(.top, 4)
        } else {
            EQEmptyView()
        }
    }

    // 行の高さは文字サイズ設定で変わるため、件数は実寸で収まる最大を選ぶ。
    // 同じ件数なら行間の広い並べ方を優先し、下端の空きを減らす。
    private var rows: some View {
        let limit = min(WidgetLayoutPolicy.maxItemCount(layout: layout), entry.earthquakes.count)
        let candidates = (1...limit).reversed().flatMap { count in
            [RowCandidate(count: count, isRelaxed: true), RowCandidate(count: count, isRelaxed: false)]
        }
        return ViewThatFits(in: .vertical) {
            ForEach(candidates, id: \.self) { candidate in
                rowList(candidate)
            }
        }
    }

    private func rowList(_ candidate: RowCandidate) -> some View {
        let items = Array(entry.earthquakes.prefix(candidate.count))
        let gap: CGFloat = (layout == .large ? 6 : 4) + (candidate.isRelaxed ? 2 : 0)
        return VStack(spacing: 0) {
            ForEach(Array(items.enumerated()), id: \.element.id) { index, earthquake in
                if index > 0 {
                    // 色が単色へ置き換わると不透明な線は強く出るため、薄くする
                    Rectangle()
                        .fill(Color.eqOutlineSoft.opacity(isFullColor ? 1 : 0.3))
                        .frame(height: 0.5)
                        .padding(.vertical, gap)
                }
                EarthquakeDetailLink(
                    eventId: earthquake.id,
                    accessibilityLabel: earthquake.widgetAccessibilityLabel
                ) {
                    if isCompact {
                        CompactEarthquakeRow(earthquake: earthquake, now: entry.date, isFullColor: isFullColor)
                    } else {
                        EarthquakeRow(
                            earthquake: earthquake,
                            now: entry.date,
                            isLarge: layout == .large,
                            isFullColor: isFullColor
                        )
                    }
                }
            }
        }
        .padding(.horizontal, isCompact ? 12 : 14)
        .padding(.bottom, 6)
    }
}

private struct RowCandidate: Hashable {
    let count: Int
    let isRelaxed: Bool
}

private struct EarthquakeDetailLink<Content: View>: View {
    let eventId: String
    let accessibilityLabel: String
    @ViewBuilder let content: Content

    var body: some View {
        if let destination = EarthquakeDetailURL.make(eventId: eventId) {
            Link(destination: destination) {
                content
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
            .accessibilityLabel(accessibilityLabel)
        } else {
            content
                .accessibilityElement(children: .ignore)
                .accessibilityLabel(accessibilityLabel)
        }
    }
}

// MARK: - Header

struct WidgetHeaderStatus {
    let text: String
    let isStale: Bool
    let accessibilityLabel: String

    init?(entry: EarthquakeEntry) {
        guard let fetchedAt = entry.fetchedAt else { return nil }
        // 行に並ぶ発生時刻が JST 固定なので、取得時刻も JST に揃える
        let time = JSTDateFormat.isSameDay(fetchedAt, entry.date)
            ? JSTDateFormat.timeShort(fetchedAt)
            : JSTDateFormat.monthDayTime(fetchedAt)
        self.isStale = entry.isStale
        self.text = entry.isStale ? "\(time)時点" : "更新 \(time)"
        self.accessibilityLabel = entry.isStale
            ? "更新に失敗しました。\(time)時点の情報です"
            : "\(time)更新"
    }
}

private struct WidgetHeader: View {
    let title: String
    let status: WidgetHeaderStatus?
    let compact: Bool
    let isFullColor: Bool

    var body: some View {
        HStack(alignment: .firstTextBaseline, spacing: 6) {
            Text(title)
                .font(AppFonts.flex(size: 12, weight: .bold))
                .foregroundStyle(Color.eqTextSecondary)
                .lineLimit(1)
                .minimumScaleFactor(0.8)
                .fixedSize(horizontal: false, vertical: true)

            Spacer(minLength: 0)

            if let status {
                HStack(spacing: 3) {
                    if status.isStale {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .font(.system(size: 9))
                    }
                    Text(status.text)
                        .font(AppFonts.code(size: 11))
                        .lineLimit(1)
                }
                .foregroundStyle(status.isStale && isFullColor ? Color.orange : Color.eqTextTertiary)
                .fixedSize()
                .accessibilityElement(children: .ignore)
                .accessibilityLabel(status.accessibilityLabel)
            }
        }
        .padding(.horizontal, compact ? 14 : 16)
        .padding(.top, 11)
        .padding(.bottom, 5)
    }
}

// MARK: - EarthquakeRow (medium / large)

struct EarthquakeRow: View {
    let earthquake: EarthquakeDisplayItem
    let now: Date
    let isLarge: Bool
    let isFullColor: Bool

    var body: some View {
        HStack(spacing: 10) {
            WidgetIntensityBadge(earthquake: earthquake, size: isLarge ? 36 : 30, isFullColor: isFullColor)

            VStack(alignment: .leading, spacing: isLarge ? 1 : 0) {
                Text(earthquake.hypocenterName)
                    .font(AppFonts.flex(size: 13, weight: .bold))
                    .foregroundStyle(Color.eqTextPrimary)
                    .widgetSingleLine(minimumScaleFactor: 0.8)

                Text(earthquake.widgetSubtitle(now: now))
                    .font(AppFonts.code(size: 11))
                    .foregroundStyle(Color.eqTextSecondary)
                    .widgetSingleLine(minimumScaleFactor: 0.8)
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            MagnitudeText(earthquake: earthquake, size: isLarge ? 21 : 19)
        }
    }
}

// MARK: - CompactEarthquakeRow (small)

struct CompactEarthquakeRow: View {
    let earthquake: EarthquakeDisplayItem
    let now: Date
    let isFullColor: Bool

    var body: some View {
        HStack(spacing: 7) {
            WidgetIntensityBadge(earthquake: earthquake, size: 26, isFullColor: isFullColor)

            VStack(alignment: .leading, spacing: 0) {
                Text(earthquake.hypocenterName)
                    .font(AppFonts.flex(size: 12, weight: .bold))
                    .foregroundStyle(Color.eqTextPrimary)
                    .widgetSingleLine(minimumScaleFactor: 0.8)

                HStack(alignment: .firstTextBaseline, spacing: 2) {
                    Text(earthquake.widgetCompactTime(now: now))
                        .font(AppFonts.code(size: 11))
                        .foregroundStyle(Color.eqTextSecondary)
                        .widgetSingleLine(minimumScaleFactor: 0.75)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    MagnitudeText(earthquake: earthquake, size: 12)
                }
            }
        }
    }
}

// MARK: - Shared Components

private extension View {
    // 縮小できる 1 行の Text は高さが足りないと縦にも縮むため、高さを固定する
    func widgetSingleLine(minimumScaleFactor: CGFloat) -> some View {
        lineLimit(1)
            .minimumScaleFactor(minimumScaleFactor)
            .fixedSize(horizontal: false, vertical: true)
    }
}

private struct WidgetIntensityBadge: View {
    let earthquake: EarthquakeDisplayItem
    let size: CGFloat
    let isFullColor: Bool

    var body: some View {
        IntensityBadge(
            intensity: earthquake.formattedIntensity,
            backgroundColor: earthquake.intensityBackgroundColor,
            textColor: isFullColor ? earthquake.intensityTextColor : Color.eqTextPrimary,
            size: size,
            outlined: !isFullColor
        )
        .widgetAccentable(!isFullColor)
    }
}

// Live Activity の M・深さ表示と同じ比率（ラベルは数値の 0.44 倍、数値は等幅 bold）
private struct MagnitudeText: View {
    let earthquake: EarthquakeDisplayItem
    let size: CGFloat

    var body: some View {
        // 震源要素が未発表のときは「不明」と区別するため何も出さない
        if earthquake.hasHypocenter {
            text
                .foregroundStyle(Color.eqTextPrimary)
                .lineLimit(1)
                .fixedSize()
        }
    }

    private var text: Text {
        let label = Text("M").font(AppFonts.flex(size: max(8, size * 0.44), weight: .medium))
        let valueFont = AppFonts.code(size: size, weight: .bold)
        let parts = earthquake.magnitudeValue.map { String(format: "%.1f", $0).split(separator: ".").map(String.init) }
        guard let parts, parts.count == 2 else {
            let word = Text(String(earthquake.magnitude.dropFirst())).font(AppFonts.flex(size: size * 0.74, weight: .bold))
            return Text("\(label)\(word)")
        }
        // 等幅フォントの小数点は 1 文字分の幅を取るため、前後だけ詰める
        let kerning = size * -0.14
        return Text(
            "\(label)\(Text(parts[0]).font(valueFont).kerning(kerning))\(Text(".").font(valueFont).kerning(kerning))\(Text(parts[1]).font(valueFont))"
        )
    }
}

private extension EarthquakeDisplayItem {
    private var displayTime: (date: Date, isArrival: Bool)? {
        if let sourceOriginTime {
            return (sourceOriginTime, false)
        }
        if let sourceArrivalTime {
            return (sourceArrivalTime, true)
        }
        return nil
    }

    // 地域を絞ると前年以前の地震も並ぶため、年は表示時点と違うときだけ付ける
    func widgetSubtitle(now: Date) -> String {
        var parts: [String] = []
        if let time = displayTime {
            let text = JSTDateFormat.isSameYear(time.date, now)
                ? JSTDateFormat.monthDayTime(time.date)
                : JSTDateFormat.yearMonthDayTime(time.date)
            parts.append(text + (time.isArrival ? "頃検知" : "頃発生"))
        }
        if !depth.isEmpty {
            parts.append("深さ \(depth)")
        }
        return parts.joined(separator: " ")
    }

    func widgetCompactTime(now: Date) -> String {
        guard let time = displayTime else { return "" }
        return JSTDateFormat.isSameYear(time.date, now)
            ? JSTDateFormat.monthDayTime(time.date)
            : JSTDateFormat.yearMonthDay(time.date)
    }

    var widgetAccessibilityLabel: String {
        var parts: [String] = []
        if let maxIntensity {
            parts.append("震度\(maxIntensity.titleText)")
        }
        parts.append(hypocenterName)
        if hasHypocenter {
            parts.append(magnitude.replacingOccurrences(of: "M", with: "マグニチュード"))
        }
        if !depth.isEmpty {
            parts.append("深さ \(depth)")
        }
        parts.append(formattedTime)
        return parts.filter { !$0.isEmpty }.joined(separator: "、")
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

// MARK: - Previews

#Preview("Small", as: .systemSmall) {
    EarthquakeWidget()
} timeline: {
    EarthquakeEntry(
        date: .now,
        configuration: EarthquakeWidgetIntent(regionType: .nationwide),
        earthquakes: EarthquakeDisplayItem.mockData,
        error: nil,
        fetchedAt: .now
    )
}

#Preview("Medium", as: .systemMedium) {
    EarthquakeWidget()
} timeline: {
    EarthquakeEntry(
        date: .now,
        configuration: EarthquakeWidgetIntent(regionType: .nationwide),
        earthquakes: EarthquakeDisplayItem.mockData,
        error: nil,
        fetchedAt: .now
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
        ),
        fetchedAt: .now
    )
}

#Preview("Small - Error", as: .systemSmall) {
    EarthquakeWidget()
} timeline: {
    EarthquakeEntry(
        date: .now,
        configuration: EarthquakeWidgetIntent(regionType: .nationwide),
        earthquakes: [],
        error: "インターネットに接続されていません"
    )
}

#Preview("Small - Empty", as: .systemSmall) {
    EarthquakeWidget()
} timeline: {
    EarthquakeEntry(
        date: .now,
        configuration: EarthquakeWidgetIntent(regionType: .nationwide),
        earthquakes: [],
        error: nil,
        fetchedAt: .now
    )
}

#Preview("Medium - 更新失敗", as: .systemMedium) {
    EarthquakeWidget()
} timeline: {
    EarthquakeEntry(
        date: .now,
        configuration: EarthquakeWidgetIntent(regionType: .nationwide),
        earthquakes: EarthquakeDisplayItem.mockData,
        error: nil,
        fetchedAt: Date().addingTimeInterval(-3 * 3600),
        isStale: true
    )
}

/// 震度速報は震源未確定 + 未入電（「5弱以上」）になりやすい。
/// バッジから文字がはみ出さないか確認するためのプレビュー。
#Preview("Small - 未入電", as: .systemSmall) {
    EarthquakeWidget()
} timeline: {
    EarthquakeEntry(
        date: .now,
        configuration: EarthquakeWidgetIntent(regionType: .nationwide),
        earthquakes: [
            EarthquakeDisplayItem(
                id: "20260106130000",
                hypocenterName: "最大震度5弱以上を観測",
                magnitude: "M不明",
                magnitudeValue: nil,
                maxIntensity: .fiveLowerNoInput,
                depth: "",
                originTime: Date().addingTimeInterval(-120),
                isArrivalTime: true,
                hasHypocenter: false
            ),
            EarthquakeDisplayItem(
                id: "20260106125500",
                hypocenterName: "最大震度6弱以上を観測",
                magnitude: "M不明",
                magnitudeValue: nil,
                maxIntensity: .sixLowerNoInput,
                depth: "",
                originTime: Date().addingTimeInterval(-300),
                isArrivalTime: true,
                hasHypocenter: false
            )
        ],
        error: nil,
        fetchedAt: .now
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
        error: nil,
        fetchedAt: .now
    )
}
