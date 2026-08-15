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
                DynamicIslandExpandedRegion(.leading) {
                    EewExpandedLeadingView(state: context.state)
                }
                DynamicIslandExpandedRegion(.trailing) {
                    EewExpandedTrailingView(state: context.state)
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
    if state.isCanceledReport {
        return .gray
    }
    return state.isWarning == true ? .red : .orange
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
                }
                DynamicIslandExpandedRegion(.trailing) {
                    ShakeExpandedTrailingView(state: context.state)
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
        if let intensity = state.displayIntensity {
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

@available(iOS 16.1, *)
struct EewCompactTrailingView: View {
    let state: EewContentState

    var body: some View {
        EewStatusPill(
            isWarning: state.isWarning ?? false,
            isCanceled: state.isCanceledReport,
            compact: true
        )
    }
}

@available(iOS 16.1, *)
struct EewMinimalView: View {
    let state: EewContentState

    var body: some View {
        if let intensity = state.displayIntensity {
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

@available(iOS 16.1, *)
struct EewExpandedLeadingView: View {
    let state: EewContentState

    var body: some View {
        if let intensity = state.displayIntensity {
            VStack(alignment: .leading, spacing: 4) {
                Text(state.displayIntensityLabel)
                    .font(AppFonts.flex(size: 9, weight: .medium))
                    .foregroundStyle(Color.eqTextSecondary)
                DynamicIslandIntensityBadge(intensity: intensity, size: 36)
            }
            .padding(.leading, 4)
        }
    }
}

@available(iOS 16.1, *)
struct EewExpandedTrailingView: View {
    let state: EewContentState

    var body: some View {
        VStack(alignment: .trailing, spacing: 6) {
            if state.isCanceledReport {
                EewStatusPill(isWarning: false, isCanceled: true)
            } else if let isWarning = state.isWarning {
                EewStatusPill(isWarning: isWarning, isCanceled: false)
            }
            if let serialNo = state.serialNo, serialNo > 0 {
                HStack(alignment: .firstTextBaseline, spacing: 0) {
                    if state.isFinal == true {
                        Text("最終 ")
                            .font(AppFonts.flex(size: 9, weight: .medium))
                            .foregroundStyle(Color.eqTextTertiary)
                    }
                    Text("第")
                        .font(AppFonts.flex(size: 9, weight: .medium))
                        .foregroundStyle(Color.eqTextTertiary)
                    Text("\(serialNo)")
                        .font(AppFonts.code(size: 14, weight: .bold))
                        .monospacedDigit()
                    Text("報")
                        .font(AppFonts.flex(size: 9, weight: .medium))
                        .foregroundStyle(Color.eqTextTertiary)
                }
            }
        }
    }
}

@available(iOS 16.1, *)
struct EewExpandedCenterView: View {
    let state: EewContentState

    var body: some View {
        if state.isCanceledReport {
            Text("緊急地震速報は取り消されました")
                .font(AppFonts.flex(size: 13, weight: .bold))
                .foregroundStyle(Color.eqTextPrimary)
                .lineLimit(2)
                .minimumScaleFactor(0.75)
        } else {
            VStack(alignment: .leading, spacing: 2) {
                Text(state.isPlum == true || state.isLevel == true ? "検知観測点" : "震源地")
                    .font(AppFonts.flex(size: 9, weight: .medium))
                    .foregroundStyle(Color.eqTextSecondary)
                if let hypocenterName = state.hypocenterName {
                    Text(hypocenterName)
                        .font(AppFonts.flex(size: 16, weight: .bold))
                        .foregroundStyle(Color.eqTextPrimary)
                        .lineLimit(1)
                        .minimumScaleFactor(0.75)
                }
            }
        }
    }
}

@available(iOS 16.1, *)
struct EewExpandedBottomView: View {
    let state: EewContentState

    var body: some View {
        // 取消報では震源・規模・到達予想がすべて無効なため、ヘッダーの取消表示に任せる
        if state.isCanceledReport {
            EmptyView()
        } else {
            HStack(alignment: .firstTextBaseline, spacing: 8) {
                if state.isPlum == true {
                    detectionMethodLabel("PLUM法による検知")
                } else if state.isLevel == true {
                    detectionMethodLabel("レベル法による検知")
                } else if state.isOnePoint == true {
                    detectionMethodLabel("低精度の緊急地震速報")
                } else {
                    HStack(spacing: 12) {
                        if let magnitude = state.magnitude {
                            HStack(alignment: .firstTextBaseline, spacing: 1) {
                                Text("M")
                                    .font(AppFonts.flex(size: 11, weight: .semibold))
                                    .foregroundStyle(Color.eqTextSecondary)
                                Text(String(format: "%.1f", magnitude))
                                    .font(AppFonts.code(size: 16, weight: .bold))
                                    .monospacedDigit()
                                    .tracking(-1)
                            }
                        }
                        if let depth = state.depth {
                            HStack(alignment: .firstTextBaseline, spacing: 1) {
                                Text("深さ")
                                    .font(AppFonts.flex(size: 11, weight: .medium))
                                    .foregroundStyle(Color.eqTextSecondary)
                                Text("\(Int(depth))")
                                    .font(AppFonts.code(size: 16, weight: .bold))
                                    .monospacedDigit()
                                Text("km")
                                    .font(AppFonts.flex(size: 11, weight: .medium))
                                    .foregroundStyle(Color.eqTextSecondary)
                            }
                        }
                    }
                }
                Spacer(minLength: 4)
                if let location = state.location {
                    ArrivalInfoView(location: location)
                }
            }
            .padding(.leading, 4)
        }
    }

    private func detectionMethodLabel(_ text: String) -> some View {
        Text(text)
            .font(AppFonts.flex(size: 13, weight: .bold))
            .foregroundStyle(Color.eqTextPrimary)
            .lineLimit(1)
            .minimumScaleFactor(0.75)
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
            Text(date, style: .time)
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
        VStack(alignment: .leading, spacing: 4) {
            Text("揺れ")
                .font(AppFonts.flex(size: 9, weight: .medium))
                .foregroundStyle(Color.eqTextSecondary)
            ShakeLevelBadge(level: state.shakeLevel, size: 36)
        }
        .padding(.leading, 4)
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
                Text(date, style: .time)
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
                Text(date, style: .time)
                    .font(AppFonts.code(size: 13, weight: .bold))
                    .monospacedDigit()
                    .foregroundStyle(Color.eqTextPrimary)
            }
        }
        .padding(.leading, 4)
    }
}

// MARK: - Common Views

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

@available(iOS 16.1, *)
struct ArrivalInfoView: View {
    let location: LocationInfo

    var body: some View {
        HStack(alignment: .firstTextBaseline, spacing: 4) {
            Text(location.regionName)
                .font(AppFonts.flex(size: 11, weight: .medium))
                .foregroundStyle(Color.eqTextSecondary)
                .lineLimit(1)
                .minimumScaleFactor(0.75)

            if let remaining = ArrivalCountdown.remaining(until: location.arrivalDate) {
                // Workaround: timerInterval が横方向に広がるのを防ぐ
                Text("00:00")
                    .font(AppFonts.code(size: 12, weight: .bold))
                    .hidden()
                    .overlay(alignment: .trailing) {
                        Text(timerInterval: remaining, countsDown: true)
                            .font(AppFonts.code(size: 12, weight: .bold))
                            .monospacedDigit()
                            .foregroundStyle(Color.eqTextPrimary)
                            .contentTransition(.numericText(countsDown: true))
                    }
            } else if location.arrivalDate != nil {
                Text("主要動到達済み")
                    .font(AppFonts.flex(size: 12, weight: .bold))
                    .foregroundStyle(Color.eqTextPrimary)
                    .lineLimit(1)
                    .minimumScaleFactor(0.75)
            }
        }
    }
}
