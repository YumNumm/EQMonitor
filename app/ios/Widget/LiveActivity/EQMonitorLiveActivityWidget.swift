//
//  EQMonitorLiveActivityWidget.swift
//  Widget
//

import ActivityKit
import SwiftUI
import WidgetKit

// MARK: - EEW Live Activity Widget

@available(iOS 16.1, *)
struct EewLiveActivityWidget: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: EewLiveActivityAttributes.self) { context in
            EewLockScreenView(state: context.state)
        } dynamicIsland: { context in
            DynamicIsland {
                // leading / trailing は TrueDepth カメラ脇の細い L 字領域で、
                // 収まらないと切り取られる。belowIfTooWide でカメラ下へ回り込ませる。
                DynamicIslandExpandedRegion(.leading) {
                    EewExpandedLeadingView(state: context.state)
                        .dynamicIsland(verticalPlacement: .belowIfTooWide)
                }
                DynamicIslandExpandedRegion(.trailing) {
                    EewExpandedTrailingView(state: context.state)
                        .dynamicIsland(verticalPlacement: .belowIfTooWide)
                }
                DynamicIslandExpandedRegion(.bottom) {
                    EewExpandedBottomView(state: context.state)
                }
                DynamicIslandExpandedRegion(.center) {
                    EewExpandedCenterView(state: context.state)
                }
            } compactLeading: {
                EewCompactLeadingView(state: context.state)
            } compactTrailing: {
                EewCompactTrailingView(state: context.state)
            } minimal: {
                EewMinimalView(state: context.state)
            }
            .keylineTint(eewKeylineTint(for: context.state))
        }
    }
}

@available(iOS 16.1, *)
private func eewKeylineTint(for state: EewContentState) -> Color {
    if state.display.isCanceled {
        return .gray
    }
    return state.display.isWarning ? .red : .orange
}

// MARK: - Shake Detection Live Activity Widget

@available(iOS 16.1, *)
struct ShakeDetectionLiveActivityWidget: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: ShakeDetectionLiveActivityAttributes.self) { context in
            ShakeDetectionLockScreenView(state: context.state)
        } dynamicIsland: { context in
            DynamicIsland {
                DynamicIslandExpandedRegion(.leading) {
                    ShakeExpandedLeadingView(state: context.state)
                        .dynamicIsland(verticalPlacement: .belowIfTooWide)
                }
                DynamicIslandExpandedRegion(.trailing) {
                    ShakeExpandedTrailingView(state: context.state)
                        .dynamicIsland(verticalPlacement: .belowIfTooWide)
                }
                DynamicIslandExpandedRegion(.bottom) {
                    ShakeExpandedBottomView(state: context.state)
                }
                DynamicIslandExpandedRegion(.center) {
                    ShakeExpandedCenterView(state: context.state)
                }
            } compactLeading: {
                ShakeCompactLeadingView(state: context.state)
            } compactTrailing: {
                ShakeCompactTrailingView(state: context.state)
            } minimal: {
                ShakeMinimalView(state: context.state)
            }
            .keylineTint(context.state.shakeLevel?.backgroundColor ?? .orange)
        }
    }
}

// MARK: - EEW Dynamic Island Views

@available(iOS 16.1, *)
struct EewCompactLeadingView: View {
    let state: EewContentState

    var body: some View {
        if state.display.isCanceled {
            EewCanceledSymbol(size: 20)
        } else if let intensity = state.display.intensity {
            DynamicIslandIntensityBadge(intensity: intensity, size: 24)
        } else {
            Image("AppIconForeground")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 20, height: 20)
                .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
        }
    }
}

/// compact では主要動到達までの残り時間を最優先で出す。
/// Apple のタイマーと同じく、畳んだ状態で知りたいのは「あと何秒か」だけ。
@available(iOS 16.1, *)
struct EewCompactTrailingView: View {
    let state: EewContentState

    var body: some View {
        if let remaining = ArrivalCountdown.remaining(
            until: state.display.countdownArrivalDate
        ) {
            ArrivalCountdownText(remaining: remaining, size: 14)
        } else {
            EewStatusPill(
                isWarning: state.display.isWarning,
                isCanceled: state.display.isCanceled,
                compact: true
            )
        }
    }
}

@available(iOS 16.1, *)
struct EewMinimalView: View {
    let state: EewContentState

    var body: some View {
        if state.display.isCanceled {
            EewCanceledSymbol(size: 18)
        } else if let intensity = state.display.intensity {
            DynamicIslandIntensityBadge(intensity: intensity, size: 22)
        } else {
            Image("AppIconForeground")
                .resizable()
                .scaledToFit()
                .frame(width: 18, height: 18)
                .clipShape(RoundedRectangle(cornerRadius: 4.5, style: .continuous))
        }
    }
}

/// 展開時の leading。細い L 字領域では要素を積むと角で切り取られるため、
/// ラベルは center 行へ回して常に 1 要素だけ置く。
@available(iOS 16.1, *)
struct EewExpandedLeadingView: View {
    let state: EewContentState

    var body: some View {
        switch state.display.dynamicIslandLayout {
        case .canceled:
            EewCanceledSymbol(size: DynamicIslandMetrics.expandedBadgeSize * 0.75)
        case .countdown, .summary:
            if let intensity = state.display.intensity {
                DynamicIslandIntensityBadge(
                    intensity: intensity,
                    size: DynamicIslandMetrics.expandedBadgeSize
                )
            }
        }
    }
}

@available(iOS 16.1, *)
struct EewExpandedTrailingView: View {
    let state: EewContentState

    var body: some View {
        switch state.display.dynamicIslandLayout {
        case .canceled:
            // center の主文と重ならないよう、取消バッジではなく報番号だけを添える
            if let serialLabel = state.display.serialLabel {
                Text(serialLabel)
                    .font(AppFonts.code(size: 11, weight: .bold))
                    .monospacedDigit()
                    .foregroundStyle(Color.eqTextTertiary)
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)
            }
        case .countdown:
            if let remaining = ArrivalCountdown.remaining(
                until: state.display.countdownArrivalDate
            ) {
                ArrivalCountdownText(remaining: remaining, size: 26)
            }
        case .summary:
            EewStatusPill(
                isWarning: state.display.isWarning,
                isCanceled: state.display.isCanceled
            )
        }
    }
}

/// leading / trailing の値に対する説明ラベル行。
/// カメラ下の全幅領域なので、左右端に寄せれば上の値の真下に並ぶ。
@available(iOS 16.1, *)
struct EewExpandedCenterView: View {
    let state: EewContentState

    var body: some View {
        switch state.display.dynamicIslandLayout {
        case .canceled:
            Text(EewDisplay.canceledTitle)
                .font(AppFonts.flex(size: 14, weight: .bold))
                .foregroundStyle(Color.eqTextPrimary)
                .lineLimit(1)
                .minimumScaleFactor(0.7)
        case .countdown:
            HStack(spacing: 6) {
                intensityCaption
                Spacer(minLength: 4)
                captionText("主要動到達まで")
            }
        case .summary:
            HStack(spacing: 6) {
                intensityCaption
                Spacer(minLength: 4)
                if let serialLabel = state.display.serialLabel {
                    captionText(serialLabel)
                }
            }
        }
    }

    /// leading のバッジがどの震度かを示すラベル。
    /// 現在地の予想震度を出しているときだけ地名を添える。全国の最大震度に
    /// フォールバックしている場合に地名を出すと誤読を招く。
    @ViewBuilder
    private var intensityCaption: some View {
        if state.display.forecastIntensity != nil,
           let regionName = state.location?.regionName,
           !regionName.isEmpty {
            HStack(spacing: 2) {
                // SF Symbol はカスタムフォントのメトリクスに引っ張られるためシステムフォントで描く
                Image(systemName: "location.fill")
                    .font(.system(size: 9, weight: .semibold))
                Text(regionName)
                    .font(AppFonts.flex(size: 11, weight: .semibold))
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)
            }
            .foregroundStyle(Color.eqTextSecondary)
        } else if state.display.intensity != nil {
            captionText(state.display.intensityLabel)
        }
    }

    private func captionText(_ text: String) -> some View {
        Text(text)
            .font(AppFonts.flex(size: 11, weight: .medium))
            .foregroundStyle(Color.eqTextSecondary)
            .lineLimit(1)
            .minimumScaleFactor(0.7)
    }
}

@available(iOS 16.1, *)
struct EewExpandedBottomView: View {
    let state: EewContentState

    var body: some View {
        switch state.display.dynamicIslandLayout {
        case .canceled:
            Text(EewDisplay.canceledDescription)
                .font(AppFonts.flex(size: 12, weight: .medium))
                .foregroundStyle(Color.eqTextSecondary)
                .lineLimit(1)
                .minimumScaleFactor(0.7)
        case .countdown:
            // カウントダウンを主役にするため、震源要素は 1 行に抑える
            HStack(alignment: .firstTextBaseline, spacing: 6) {
                EewStatusPill(
                    isWarning: state.display.isWarning,
                    isCanceled: state.display.isCanceled,
                    compact: true
                )
                EewHypocenterSummaryView(state: state, size: 13)
                Spacer(minLength: 4)
                EewHypocenterDetailView(state: state, size: 14)
            }
        case .summary:
            HStack(alignment: .firstTextBaseline, spacing: 8) {
                EewHypocenterSummaryView(state: state, size: 15)
                Spacer(minLength: 4)
                EewHypocenterDetailView(state: state, size: 16)
            }
        }
    }
}

/// 震源地（PLUM法・レベル法では検知観測点）を 1 行で示す。
/// 細い領域で Text を分割すると折り返し・切り取りが起きるため 1 つにまとめる。
@available(iOS 16.1, *)
struct EewHypocenterSummaryView: View {
    let state: EewContentState
    let size: CGFloat

    var body: some View {
        if let text = text {
            Text(text)
                .font(AppFonts.flex(size: size, weight: .bold))
                .foregroundStyle(Color.eqTextPrimary)
                .lineLimit(1)
                .minimumScaleFactor(0.7)
        }
    }

    private var text: String? {
        guard let hypocenterName = state.hypocenterName, !hypocenterName.isEmpty else {
            return nil
        }
        // 仮定震源要素を使う検知では震源地ではなく検知観測点。混同させない
        if state.isPlum == true || state.isLevel == true {
            return "検知観測点 \(hypocenterName)"
        }
        return hypocenterName
    }
}

/// M・深さ。精度の低い検知（PLUM法・レベル法・1点検知）では
/// 数値を出さず検知方法を示す（Lock Screen と同じ判断）。
@available(iOS 16.1, *)
struct EewHypocenterDetailView: View {
    let state: EewContentState
    let size: CGFloat

    var body: some View {
        if let detectionMethod = detectionMethod {
            Text(detectionMethod)
                .font(AppFonts.flex(size: size * 0.8, weight: .semibold))
                .foregroundStyle(Color.eqTextSecondary)
                .lineLimit(1)
                .minimumScaleFactor(0.7)
        } else {
            HStack(alignment: .firstTextBaseline, spacing: 10) {
                if let magnitude = state.magnitude {
                    HStack(alignment: .firstTextBaseline, spacing: 1) {
                        Text("M")
                            .font(AppFonts.flex(size: size * 0.7, weight: .semibold))
                            .foregroundStyle(Color.eqTextSecondary)
                        Text(String(format: "%.1f", magnitude))
                            .font(AppFonts.code(size: size, weight: .bold))
                            .monospacedDigit()
                            .foregroundStyle(Color.eqTextPrimary)
                    }
                }
                if let depth = state.depth {
                    HStack(alignment: .firstTextBaseline, spacing: 1) {
                        Text("深さ")
                            .font(AppFonts.flex(size: size * 0.7, weight: .medium))
                            .foregroundStyle(Color.eqTextSecondary)
                        Text("\(Int(depth))")
                            .font(AppFonts.code(size: size, weight: .bold))
                            .monospacedDigit()
                            .foregroundStyle(Color.eqTextPrimary)
                        Text("km")
                            .font(AppFonts.flex(size: size * 0.7, weight: .medium))
                            .foregroundStyle(Color.eqTextSecondary)
                    }
                }
            }
        }
    }

    private var detectionMethod: String? {
        if state.isPlum == true {
            return "PLUM法"
        }
        if state.isLevel == true {
            return "レベル法"
        }
        if state.isOnePoint == true {
            return "1点検知(低精度)"
        }
        return nil
    }
}

// MARK: - Shake Detection Dynamic Island Views

@available(iOS 16.1, *)
struct ShakeCompactLeadingView: View {
    let state: ShakeDetectionContentState

    var body: some View {
        ShakeLevelBadge(level: state.shakeLevel, size: 24)
    }
}

@available(iOS 16.1, *)
struct ShakeCompactTrailingView: View {
    let state: ShakeDetectionContentState

    var body: some View {
        if let date = state.detectedDate {
            Text(JSTDateFormat.timeShort(date))
                .font(AppFonts.code(size: 11, weight: .semibold))
                .monospacedDigit()
                .foregroundStyle(Color.eqTextPrimary)
        }
    }
}

@available(iOS 16.1, *)
struct ShakeMinimalView: View {
    let state: ShakeDetectionContentState

    var body: some View {
        ShakeLevelBadge(level: state.shakeLevel, size: 22)
    }
}

@available(iOS 16.1, *)
struct ShakeExpandedLeadingView: View {
    let state: ShakeDetectionContentState

    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text("揺れ")
                .font(AppFonts.flex(size: 9, weight: .medium))
                .foregroundStyle(Color.eqTextSecondary)
                .lineLimit(1)
            ShakeLevelBadge(
                level: state.shakeLevel,
                size: DynamicIslandMetrics.expandedBadgeSize
            )
        }
    }
}

/// 揺れの強さバッジ。未知の level が届いても Dynamic Island が空になら
/// ないよう、判別できない場合はグレーの「?」で「揺れ検知中だが強さ不明」を示す。
@available(iOS 16.1, *)
struct ShakeLevelBadge: View {
    let level: ShakeDetectionLevel?
    let size: CGFloat

    var body: some View {
        Text(level?.shortDisplayString ?? "?")
            .font(AppFonts.code(size: size * 0.58, weight: .bold))
            .lineLimit(1)
            .minimumScaleFactor(0.6)
            .foregroundStyle(level?.textColor ?? .white)
            .frame(width: size, height: size)
            .background(
                RoundedRectangle(cornerRadius: size * 0.25, style: .continuous)
                    .fill(level?.backgroundColor ?? Color.gray)
            )
    }
}

@available(iOS 16.1, *)
struct ShakeExpandedTrailingView: View {
    let state: ShakeDetectionContentState

    var body: some View {
        if let date = state.detectedDate {
            VStack(alignment: .trailing, spacing: 2) {
                Text("検知")
                    .font(AppFonts.flex(size: 9, weight: .medium))
                    .foregroundStyle(Color.eqTextSecondary)
                Text(JSTDateFormat.timeShort(date))
                    .font(AppFonts.code(size: 13, weight: .bold))
                    .monospacedDigit()
                    .foregroundStyle(Color.eqTextPrimary)
            }
        }
    }
}

@available(iOS 16.1, *)
struct ShakeExpandedCenterView: View {
    let state: ShakeDetectionContentState

    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text("観測地点")
                .font(AppFonts.flex(size: 9, weight: .medium))
                .foregroundStyle(Color.eqTextSecondary)
            Text(locationText)
                .font(AppFonts.flex(size: 15, weight: .bold))
                .foregroundStyle(Color.eqTextPrimary)
                .lineLimit(1)
                .minimumScaleFactor(0.75)
        }
    }

    private var locationText: String {
        guard let regionName = state.location?.regionName, !regionName.isEmpty else {
            return "地点情報なし"
        }
        return regionName
    }
}

@available(iOS 16.1, *)
struct ShakeExpandedBottomView: View {
    let state: ShakeDetectionContentState

    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            if let level = state.shakeLevel {
                Text(level.displayString)
                    .font(AppFonts.flex(size: 13, weight: .bold))
                    .foregroundStyle(Color.eqTextPrimary)
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
            }

            Spacer(minLength: 4)

            if let intensity = state.location?.intensity {
                HStack(alignment: .firstTextBaseline, spacing: 2) {
                    Text("計測震度")
                        .font(AppFonts.flex(size: 11, weight: .medium))
                        .foregroundStyle(Color.eqTextSecondary)
                    Text(String(format: "%.1f", intensity))
                        .font(AppFonts.code(size: 14, weight: .bold))
                        .monospacedDigit()
                        .foregroundStyle(Color.eqTextPrimary)
                }
            } else if let date = state.detectedDate {
                Text(JSTDateFormat.timeShort(date))
                    .font(AppFonts.code(size: 13, weight: .bold))
                    .monospacedDigit()
                    .foregroundStyle(Color.eqTextPrimary)
            }
        }
    }
}

// MARK: - Common Views

/// Dynamic Island の寸法。
///
/// 展開時の leading / trailing は TrueDepth カメラ脇の細い L 字領域で、
/// 領域側に独自の余白を足すと内容がその分だけ切り取られる。ここで一括管理し、
/// 各 View では `padding` を足さない。
enum DynamicIslandMetrics {
    /// 展開時のバッジ寸法。leading 領域の幅に収まる大きさに抑える。
    static let expandedBadgeSize: CGFloat = 32
}

@available(iOS 16.1, *)
struct DynamicIslandIntensityBadge: View {
    let intensity: IntensityValue
    var size: CGFloat = 24

    var body: some View {
        IntensityBadge(
            intensity: intensity.formattedParts,
            backgroundColor: intensity.backgroundColor,
            textColor: intensity.textColor,
            size: size
        )
    }
}

@available(iOS 16.1, *)
struct EewStatusPill: View {
    let isWarning: Bool
    let isCanceled: Bool
    var compact: Bool = false

    var body: some View {
        Text(label)
            .font(AppFonts.flex(size: compact ? 10 : 11, weight: .bold))
            .foregroundStyle(.white)
            .padding(.horizontal, compact ? 6 : 8)
            .padding(.vertical, compact ? 2 : 3)
            .background(Capsule().fill(backgroundColor))
    }

    private var label: String {
        if isCanceled {
            return "取消"
        }
        return isWarning ? "警報" : "予報"
    }

    private var backgroundColor: Color {
        if isCanceled {
            return Color.gray
        }
        return isWarning ? Color.red : Color.orange
    }
}

/// 取消報を一目で伝えるシンボル。震度バッジの代わりに置く。
@available(iOS 16.1, *)
struct EewCanceledSymbol: View {
    let size: CGFloat

    var body: some View {
        Image(systemName: "slash.circle.fill")
            .font(.system(size: size, weight: .semibold))
            .foregroundStyle(Color.eqTextSecondary)
    }
}
