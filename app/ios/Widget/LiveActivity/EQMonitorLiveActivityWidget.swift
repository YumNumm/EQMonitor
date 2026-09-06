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
                .activityBackgroundTint(.black)
                .activitySystemActionForegroundColor(.white)
        } dynamicIsland: { context in
            DynamicIsland {
                // カメラ脇と下部で高さの割り当てが異なるため本文はbottomに置く。
                DynamicIslandExpandedRegion(.leading) {
                    EewExpandedLeadingView(state: context.state)
                        .dynamicIsland(verticalPlacement: .belowIfTooWide)
                }
                DynamicIslandExpandedRegion(.trailing) {
                    EewExpandedTrailingView(state: context.state)
                        .dynamicIsland(verticalPlacement: .belowIfTooWide)
                }
                DynamicIslandExpandedRegion(.bottom) {
                    ViewThatFits(in: .vertical) {
                        EewExpandedBottomView(state: context.state)
                            .fixedSize(horizontal: false, vertical: true)
                        EewExpandedBottomView(state: context.state, compact: true)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .padding(.horizontal, 8)
                    .padding(.bottom, 8)
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
        } else if let intensity = state.display.localIntensity {
            EewLocalIntensityView(intensity: intensity, size: 26)
        } else {
            EewMaximumIntensityView(intensity: state.display.maxIntensity, size: 20)
        }
    }
}

@available(iOS 16.1, *)
struct EewCompactTrailingView: View {
    let state: EewContentState

    var body: some View {
        if let remaining = ArrivalCountdown.remaining(until: state.display.countdownArrivalDate) {
            ArrivalCountdownText(remaining: remaining, size: 14, color: .white)
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
        } else if let intensity = state.display.localIntensity {
            EewLocalIntensityView(intensity: intensity, size: 24)
        } else {
            EewMaximumIntensityView(intensity: state.display.maxIntensity, size: 19)
        }
    }
}

@available(iOS 16.1, *)
struct EewExpandedLeadingView: View {
    let state: EewContentState

    var body: some View {
        if state.display.isCanceled {
            EewCanceledSymbol(size: 30)
        } else {
            EewMaximumIntensityView(intensity: state.display.maxIntensity, size: 38)
        }
    }
}

@available(iOS 16.1, *)
struct EewExpandedTrailingView: View {
    let state: EewContentState

    var body: some View {
        if state.display.isCanceled {
            if let serialLabel = state.display.serialLabel {
                Text(serialLabel)
                    .font(AppFonts.code(size: 11, weight: .bold))
                    .foregroundStyle(.white.opacity(0.75))
            }
        } else {
            EewSourceMetricsView(state: state, vertical: true, size: 21)
                .foregroundStyle(.white)
        }
    }
}

@available(iOS 16.1, *)
struct EewExpandedBottomView: View {
    let state: EewContentState
    var compact = false

    var body: some View {
        VStack(alignment: .leading, spacing: 1) {
            if state.display.isCanceled {
                Text(EewDisplay.canceledTitle)
                    .font(AppFonts.flex(size: 15, weight: .bold))
                Text(EewDisplay.canceledDescription)
                    .font(AppFonts.flex(size: 12))
                    .foregroundStyle(.white.opacity(0.75))
            } else {
                Text(state.display.typeLabel)
                    .font(.system(size: 11, weight: .medium))
                    .foregroundStyle(.white.opacity(0.8))
                    .fixedSize(horizontal: true, vertical: true)
                if let headline = state.display.headline(from: state.headline) {
                    Text(headline)
                        .font(AppFonts.flex(size: 16, weight: .heavy))
                        .lineLimit(compact ? 1 : 2)
                } else {
                    EewHypocenterSummaryView(state: state, size: 16)
                }

                if state.display.usesLocalIntensity || state.display.locationNotice != nil {
                    EewExpandedLocationView(state: state, intensitySize: compact ? 44 : 56)
                }
            }
        }
        .foregroundStyle(.white)
    }
}

@available(iOS 16.1, *)
private struct EewExpandedLocationView: View {
    let state: EewContentState
    let intensitySize: CGFloat

    var body: some View {
        HStack(alignment: .bottom, spacing: 8) {
            if let notice = state.display.locationNotice {
                EewLocationNoticeView(notice: notice, intensity: state.display.localIntensity)
            } else {
                VStack(alignment: .leading, spacing: 2) {
                    Text("現在地")
                        .font(AppFonts.flex(size: 10, weight: .medium))
                        .foregroundStyle(.white.opacity(0.75))
                    if let regionName = state.location?.regionName, !regionName.isEmpty {
                        Text(regionName)
                            .font(AppFonts.flex(size: 12, weight: .bold))
                            .lineLimit(2)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            if let arrivalDate = state.display.countdownArrivalDate {
                EewArrivalView(arrivalDate: arrivalDate)
                    .fixedSize()
            }
            if let intensity = state.display.localIntensity {
                EewLocalIntensityView(intensity: intensity, size: intensitySize)
                    .fixedSize()
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
                .foregroundStyle(.white)
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
