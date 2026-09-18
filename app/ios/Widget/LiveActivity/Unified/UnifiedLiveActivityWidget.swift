//
//  UnifiedLiveActivityWidget.swift
//  Widget
//
//  統合 Live Activity の ActivityConfiguration と Dynamic Island。
//
//  `eew.isFinal` / `eew.isCanceled` を Activity の終了と解釈しない。終了は
//  backend の End に従うため、クライアント側に独立した終了タイマーを持たせない。
//

import ActivityKit
import SwiftUI
import WidgetKit

@available(iOS 16.1, *)
struct EarthquakeLiveActivityWidget: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: EarthquakeLiveActivityAttributes.self) { context in
            UnifiedLockScreenView(state: context.state)
                .activityBackgroundTint(.black)
                .activitySystemActionForegroundColor(.white)
        } dynamicIsland: { context in
            DynamicIsland {
                // カメラ脇と下部で高さの割り当てが異なるため本文は bottom に置く
                DynamicIslandExpandedRegion(.leading) {
                    UnifiedExpandedLeadingView(state: context.state)
                        .dynamicIsland(verticalPlacement: .belowIfTooWide)
                }
                DynamicIslandExpandedRegion(.trailing) {
                    UnifiedExpandedTrailingView(state: context.state)
                        .dynamicIsland(verticalPlacement: .belowIfTooWide)
                }
                DynamicIslandExpandedRegion(.bottom) {
                    UnifiedExpandedBottomView(state: context.state)
                        .padding(.horizontal, 8)
                        .padding(.bottom, 8)
                }
            } compactLeading: {
                UnifiedCompactLeadingView(state: context.state)
            } compactTrailing: {
                UnifiedCompactTrailingView(state: context.state)
            } minimal: {
                UnifiedCompactLeadingView(state: context.state)
            }
            .keylineTint(UnifiedLiveActivityDisplay(context.state).keylineTint)
        }
    }
}

// MARK: - Compact / Minimal

/// compact と minimal は面積が足りないため出所 Chip を重ねない。
/// 情報源は compactTrailing と expanded の種別ラベルで示す。
@available(iOS 16.1, *)
struct UnifiedCompactLeadingView: View {
    let state: UnifiedLiveActivityContentState

    private var display: UnifiedLiveActivityDisplay { UnifiedLiveActivityDisplay(state) }

    var body: some View {
        switch display.primary {
        case .shakeDetection:
            UnifiedShakeLevelBadge(
                level: display.locationShakeLevel ?? display.headerShakeLevel,
                size: 24
            )
        case .eew:
            if display.eew?.display.isCanceled == true {
                EewCanceledSymbol(size: 20)
            } else if let intensity = display.locationIntensity {
                UnifiedIntensityBadge(intensity: intensity, size: 26)
            } else {
                EewMaximumIntensityView(intensity: display.headerIntensity, size: 20)
            }
        case .earthquake:
            if let intensity = display.locationIntensity {
                UnifiedIntensityBadge(intensity: intensity, size: 26)
            } else {
                EewMaximumIntensityView(intensity: display.headerIntensity, size: 20)
            }
        case .empty:
            Image(systemName: "waveform.path.ecg")
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(.white)
        }
    }
}

@available(iOS 16.1, *)
struct UnifiedCompactTrailingView: View {
    let state: UnifiedLiveActivityContentState

    private var display: UnifiedLiveActivityDisplay { UnifiedLiveActivityDisplay(state) }

    var body: some View {
        switch display.primary {
        case .shakeDetection:
            if let date = display.shakeDetection?.detectedDate {
                Text(JSTDateFormat.timeShort(date))
                    .font(AppFonts.code(size: 11, weight: .semibold))
                    .monospacedDigit()
                    .foregroundStyle(.white)
            }
        case .eew:
            if let eew = display.eew {
                if let remaining = ArrivalCountdown.remaining(until: eew.display.countdownArrivalDate) {
                    ArrivalCountdownText(remaining: remaining, size: 14, color: .white)
                } else {
                    EewStatusPill(
                        isWarning: eew.display.isWarning,
                        isCanceled: eew.display.isCanceled,
                        compact: true
                    )
                }
            }
        case .earthquake:
            if let name = display.earthquake?.primaryInformationType?.shortName {
                Text(name)
                    .font(AppFonts.flex(size: 10, weight: .bold))
                    .foregroundStyle(.white)
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)
            }
        case .empty:
            EmptyView()
        }
    }
}

// MARK: - Expanded

@available(iOS 16.1, *)
struct UnifiedExpandedLeadingView: View {
    let state: UnifiedLiveActivityContentState

    private var display: UnifiedLiveActivityDisplay { UnifiedLiveActivityDisplay(state) }

    var body: some View {
        if let level = display.headerShakeLevel {
            VStack(alignment: .leading, spacing: 2) {
                Text("揺れ")
                    .font(AppFonts.flex(size: 9, weight: .medium))
                    .foregroundStyle(.white.opacity(0.7))
                UnifiedShakeLevelBadge(level: level, size: DynamicIslandMetrics.expandedBadgeSize)
            }
        } else if let intensity = display.headerIntensity {
            UnifiedIntensityBadge(
                intensity: intensity,
                size: DynamicIslandMetrics.expandedBadgeSize,
                source: display.intensitySource,
                chipStyle: .topBar,
                isMaximum: true
            )
            .padding(.horizontal, 4)
        }
    }
}

@available(iOS 16.1, *)
struct UnifiedExpandedTrailingView: View {
    let state: UnifiedLiveActivityContentState

    private var display: UnifiedLiveActivityDisplay { UnifiedLiveActivityDisplay(state) }

    var body: some View {
        switch display.primary {
        case .shakeDetection:
            if let date = display.shakeDetection?.detectedDate {
                VStack(alignment: .trailing, spacing: 2) {
                    Text("検知")
                        .font(AppFonts.flex(size: 9, weight: .medium))
                        .foregroundStyle(.white.opacity(0.7))
                    Text(JSTDateFormat.timeShort(date))
                        .font(AppFonts.code(size: 13, weight: .bold))
                        .monospacedDigit()
                        .foregroundStyle(.white)
                }
            }
        case .eew:
            if let eew = display.eew {
                if eew.display.isCanceled {
                    if let serialLabel = eew.display.serialLabel {
                        Text(serialLabel)
                            .font(.system(size: 11, weight: .bold))
                            .foregroundStyle(.white.opacity(0.75))
                            .fixedSize()
                            .padding(4)
                    }
                } else {
                    UnifiedMetricsRow(
                        magnitudeText: eew.magnitude.map { "M" + String(format: "%.1f", $0) },
                        depth: eew.depth,
                        lowAccuracyLabel: eew.display.isLowAccuracyDetection
                            ? (eew.isPlum == true ? "PLUM法" : eew.isLevel == true ? "レベル法" : "低精度")
                            : nil,
                        size: 21
                    )
                }
            }
        case .earthquake:
            if let earthquake = display.earthquake, earthquake.isCanceled != true {
                UnifiedMetricsRow(
                    magnitudeText: earthquake.magnitude?.displayText,
                    depth: earthquake.depth,
                    emphasizeMagnitude: earthquake.magnitude?.isOverM8 == true,
                    size: 21
                )
            }
        case .empty:
            EmptyView()
        }
    }
}

@available(iOS 16.1, *)
struct UnifiedExpandedBottomView: View {
    let state: UnifiedLiveActivityContentState

    private var display: UnifiedLiveActivityDisplay { UnifiedLiveActivityDisplay(state) }

    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            Text(display.typeLabel)
                .font(.system(size: 11, weight: .medium))
                .foregroundStyle(.white.opacity(0.8))
                .fixedSize(horizontal: true, vertical: true)

            if let headline = display.headline, !headline.isEmpty {
                Text(headline)
                    .font(AppFonts.flex(size: 16, weight: .heavy))
                    .foregroundStyle(.white)
                    .lineLimit(2)
            }

            if let date = eventDate {
                Text("\(eventLabel)  \(JSTDateFormat.monthDay(date)) \(JSTDateFormat.timeWithSeconds(date))")
                    .font(.system(size: 11, weight: .medium))
                    .foregroundStyle(.white.opacity(0.75))
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
            }

            if display.showsLocation {
                UnifiedLocationPanel(display: display, chipStyle: .topBar, badgeSize: 44)
                    .padding(.top, 2)
            }

            if let eew = display.eewStrip {
                UnifiedEewStrip(eew: eew).padding(.top, 2)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var eventDate: Date? {
        switch display.primary {
        case .eew: return display.eew?.timeDate
        case .earthquake: return display.earthquake?.originDate
        case .shakeDetection: return display.shakeDetection?.detectedDate
        case .empty: return nil
        }
    }

    private var eventLabel: String {
        switch display.primary {
        case .eew: return display.eew?.timeLabel ?? "地震発生"
        case .earthquake: return "地震発生"
        case .shakeDetection: return "検知"
        case .empty: return ""
        }
    }
}
