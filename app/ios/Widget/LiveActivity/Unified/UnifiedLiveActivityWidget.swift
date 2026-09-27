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
                if UnifiedLiveActivityDisplay(context.state).primary == .eew,
                   let eew = context.state.eew {
                    EewMinimalView(state: eew.eewContentState)
                } else {
                    UnifiedCompactLeadingView(state: context.state)
                }
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
            if let eew = display.eew {
                EewCompactLeadingView(state: eew.eewContentState)
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
                EewCompactTrailingView(state: eew.eewContentState)
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
        if display.primary == .eew, let eew = display.eew {
            EewExpandedLeadingView(state: eew.eewContentState)
        } else if let level = display.headerShakeLevel {
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
                EewExpandedTrailingView(state: eew.eewContentState)
            }
        case .earthquake:
            if let earthquake = display.earthquake {
                SourceMetricsView(
                    magnitude: earthquake.magnitude?.displayValue,
                    depth: earthquake.depth,
                    vertical: true,
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
        if display.primary == .eew, let eew = display.eew {
            ViewThatFits(in: .vertical) {
                EewExpandedBottomView(state: eew.eewContentState)
                    .fixedSize(horizontal: false, vertical: true)
                EewExpandedBottomView(state: eew.eewContentState, compact: true)
                    .fixedSize(horizontal: false, vertical: true)
            }
        } else {
            summary
        }
    }

    private var summary: some View {
        VStack(alignment: .leading, spacing: 3) {
            Text(display.typeLabel)
                .font(.system(size: 11, weight: .medium))
                .foregroundStyle(.white.opacity(0.8))
                .lineLimit(1)
                .minimumScaleFactor(0.7)

            if let headline = display.headline, !headline.isEmpty {
                Text(headline)
                    .font(AppFonts.flex(size: 16, weight: .heavy))
                    .foregroundStyle(.white)
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)
            }

            if display.showsLocation {
                HStack(spacing: 4) {
                    Text("現在地")
                    if let name = display.locationName {
                        Text(name)
                    }
                    if let intensity = display.locationIntensity {
                        Text("観測震度 \(intensity.displayString)")
                            .fontWeight(.bold)
                    } else if let level = display.locationShakeLevel {
                        Text(level.displayString).fontWeight(.bold)
                    }
                }
                .font(AppFonts.flex(size: 11, weight: .medium))
                .foregroundStyle(.white.opacity(0.85))
                .lineLimit(1)
                .minimumScaleFactor(0.7)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

}
