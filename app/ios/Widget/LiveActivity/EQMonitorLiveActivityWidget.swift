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
            .keylineTint(context.state.isWarning == true ? .red : .orange)
        }
    }
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
            .keylineTint(.orange)
        }
    }
}

// MARK: - EEW Dynamic Island Views

@available(iOS 16.1, *)
struct EewCompactLeadingView: View {
    let state: EewContentState

    var body: some View {
        if let location = state.location, let intensity = location.forecastIntensityValue {
            CompactIntensityBadge(intensity: intensity)
        } else if let intensity = state.intensityValue {
            CompactIntensityBadge(intensity: intensity)
        } else {
            Image("AppIconForeground")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 20, height: 20)
                .clipShape(RoundedRectangle(cornerRadius: 4))
        }
    }
}

@available(iOS 16.1, *)
struct EewCompactTrailingView: View {
    let state: EewContentState

    var body: some View {
        if let isWarning = state.isWarning, isWarning {
            Text("警報")
                .font(.system(size: 11, weight: .heavy))
                .foregroundColor(.red)
        } else {
            Text("予報")
                .font(.system(size: 11, weight: .bold))
                .foregroundColor(.orange)
        }
    }
}

@available(iOS 16.1, *)
struct EewMinimalView: View {
    let state: EewContentState

    var body: some View {
        if let location = state.location, let intensity = location.forecastIntensityValue {
            MinimalIntensityBadge(intensity: intensity)
        } else if let intensity = state.intensityValue {
            MinimalIntensityBadge(intensity: intensity)
        } else {
            Image("AppIconForeground")
                .resizable()
                .scaledToFit()
                .frame(width: 18, height: 18)
        }
    }
}

@available(iOS 16.1, *)
struct EewExpandedLeadingView: View {
    let state: EewContentState

    var body: some View {
        if let location = state.location, let intensity = location.forecastIntensityValue {
            VStack(alignment: .leading, spacing: 2) {
                Text("予想震度")
                    .font(.system(size: 9, weight: .medium))
                    .foregroundColor(.secondary)
                ExpandedIntensityBadge(intensity: intensity)
            }
        } else if let intensity = state.intensityValue {
            VStack(alignment: .leading, spacing: 2) {
                Text("最大震度")
                    .font(.system(size: 9, weight: .medium))
                    .foregroundColor(.secondary)
                ExpandedIntensityBadge(intensity: intensity)
            }
        }
    }
}

@available(iOS 16.1, *)
struct EewExpandedTrailingView: View {
    let state: EewContentState

    var body: some View {
        VStack(alignment: .trailing, spacing: 2) {
            if let isWarning = state.isWarning {
                Text(isWarning ? "警報" : "予報")
                    .font(.system(size: 13, weight: .heavy))
                    .foregroundColor(isWarning ? .red : .orange)
            }
            HStack(spacing: 4) {
                if let serialNo = state.serialNo {
                    HStack(alignment: .firstTextBaseline, spacing: 0) {
                        Text("#")
                            .font(.system(size: 10, weight: .medium, design: .monospaced))
                            .foregroundColor(.secondary)
                        Text("\(serialNo)")
                            .font(.system(size: 14, weight: .bold, design: .monospaced))
                    }
                }
                Image("AppIconForeground")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
                    .clipShape(RoundedRectangle(cornerRadius: 4))
            }
        }
    }
}

@available(iOS 16.1, *)
struct EewExpandedCenterView: View {
    let state: EewContentState

    var body: some View {
        VStack(alignment: .leading, spacing: 1) {
            Text("震源地")
                .font(.system(size: 9, weight: .medium))
                .foregroundColor(.secondary)
            if let hypocenterName = state.hypocenterName {
                Text(hypocenterName)
                    .font(.system(size: 16, weight: .bold))
                    .lineLimit(1)
            }
        }
    }
}

@available(iOS 16.1, *)
struct EewExpandedBottomView: View {
    let state: EewContentState

    var body: some View {
        HStack {
            HStack(spacing: 12) {
                if let magnitude = state.magnitude {
                    HStack(alignment: .firstTextBaseline, spacing: 1) {
                        Text("M")
                            .font(.system(size: 11, weight: .semibold))
                            .foregroundColor(.secondary)
                        Text(String(format: "%.1f", magnitude))
                            .font(.system(size: 16, weight: .bold, design: .monospaced))
                            .tracking(-2)
                    }
                }
                if let depth = state.depth {
                    HStack(alignment: .firstTextBaseline, spacing: 1) {
                        Text("深さ")
                            .font(.system(size: 11, weight: .medium))
                            .foregroundColor(.secondary)
                        Text("\(depth)")
                            .font(.system(size: 16, weight: .bold, design: .monospaced))
                        Text("km")
                            .font(.system(size: 11, weight: .medium))
                            .foregroundColor(.secondary)
                    }
                }
            }
            Spacer()
            if let location = state.location {
                ArrivalInfoView(location: location)
            }
        }
    }
}

// MARK: - Shake Detection Dynamic Island Views

@available(iOS 16.1, *)
struct ShakeCompactLeadingView: View {
    let state: ShakeDetectionContentState

    var body: some View {
        if let level = state.shakeLevel {
            Text(level.shortDisplayString)
                .font(.system(size: 16, weight: .black, design: .monospaced))
                .foregroundColor(level.textColor)
                .frame(width: 24, height: 24)
                .background(level.backgroundColor)
                .clipShape(RoundedRectangle(cornerRadius: 6))
        }
    }
}

@available(iOS 16.1, *)
struct ShakeCompactTrailingView: View {
    let state: ShakeDetectionContentState

    var body: some View {
        if let date = state.detectedDate {
            Text(date, style: .time)
                .font(.system(size: 11, weight: .semibold, design: .monospaced))
        }
    }
}

@available(iOS 16.1, *)
struct ShakeMinimalView: View {
    let state: ShakeDetectionContentState

    var body: some View {
        if let level = state.shakeLevel {
            Text(level.shortDisplayString)
                .font(.system(size: 14, weight: .black, design: .monospaced))
                .foregroundColor(level.textColor)
        }
    }
}

@available(iOS 16.1, *)
struct ShakeExpandedLeadingView: View {
    let state: ShakeDetectionContentState

    var body: some View {
        if let level = state.shakeLevel {
            VStack(alignment: .leading, spacing: 2) {
                Text("揺れ")
                    .font(.system(size: 9, weight: .medium))
                    .foregroundColor(.secondary)
                Text(level.shortDisplayString)
                    .font(.system(size: 24, weight: .black, design: .monospaced))
                    .foregroundColor(level.textColor)
                    .frame(width: 36, height: 36)
                    .background(level.backgroundColor)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
        }
    }
}

@available(iOS 16.1, *)
struct ShakeExpandedTrailingView: View {
    let state: ShakeDetectionContentState

    var body: some View {
        if let date = state.detectedDate {
            VStack(alignment: .trailing, spacing: 2) {
                Text("検知")
                    .font(.system(size: 9, weight: .medium))
                    .foregroundColor(.secondary)
                Text(date, style: .time)
                    .font(.system(size: 13, weight: .bold, design: .monospaced))
            }
        }
    }
}

@available(iOS 16.1, *)
struct ShakeExpandedCenterView: View {
    let state: ShakeDetectionContentState

    var body: some View {
        if let level = state.shakeLevel {
            Text(level.displayString)
                .font(.system(size: 14, weight: .bold))
        }
    }
}

@available(iOS 16.1, *)
struct ShakeExpandedBottomView: View {
    let state: ShakeDetectionContentState

    var body: some View {
        HStack {
            if let location = state.location {
                Text(location.regionName)
                    .font(.system(size: 13, weight: .semibold))
            }
            Spacer()
            if let location = state.location, let intensity = location.intensity {
                HStack(alignment: .firstTextBaseline, spacing: 2) {
                    Text("計測震度")
                        .font(.system(size: 9, weight: .medium))
                        .foregroundColor(.secondary)
                    Text(String(format: "%.1f", intensity))
                        .font(.system(size: 14, weight: .bold, design: .monospaced))
                }
            }
        }
    }
}

// MARK: - Common Views

@available(iOS 16.1, *)
struct CompactIntensityBadge: View {
    let intensity: IntensityValue

    var body: some View {
        let parts = intensity.formattedParts
        HStack(alignment: .firstTextBaseline, spacing: 0) {
            Text(parts.main)
                .font(.system(size: 16, weight: .black, design: .monospaced))
            if let sub = parts.sub {
                Text(sub)
                    .font(.system(size: 8, weight: .bold, design: .monospaced))
            }
        }
        .foregroundColor(intensity.textColor)
        .frame(minWidth: 24, minHeight: 24)
        .padding(.horizontal, 2)
        .background(intensity.backgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: 6))
    }
}

@available(iOS 16.1, *)
struct MinimalIntensityBadge: View {
    let intensity: IntensityValue

    var body: some View {
        let parts = intensity.formattedParts
        HStack(alignment: .firstTextBaseline, spacing: 0) {
            Text(parts.main)
                .font(.system(size: 14, weight: .black, design: .monospaced))
            if let sub = parts.sub {
                Text(sub)
                    .font(.system(size: 6, weight: .bold, design: .monospaced))
            }
        }
        .foregroundColor(intensity.textColor)
    }
}

@available(iOS 16.1, *)
struct ExpandedIntensityBadge: View {
    let intensity: IntensityValue

    var body: some View {
        let parts = intensity.formattedParts
        HStack(alignment: .firstTextBaseline, spacing: 0) {
            Text(parts.main)
                .font(.system(size: 28, weight: .heavy, design: .monospaced))
            if let sub = parts.sub {
                Text(sub)
                    .font(.system(size: 12, weight: .bold, design: .monospaced))
            }
        }
        .foregroundColor(intensity.textColor)
        .frame(width: 38, height: 38)
        .background(intensity.backgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

@available(iOS 16.1, *)
struct ArrivalInfoView: View {
    let location: LocationInfo

    var body: some View {
        HStack(spacing: 4) {
            Text(location.regionName)
                .font(.system(size: 11, weight: .medium))
                .foregroundColor(.secondary)
                .lineLimit(1)

            if let arrivalDate = location.arrivalDate {
                Text(arrivalDate, style: .relative)
                    .font(.system(size: 12, weight: .bold, design: .monospaced))
            }
        }
    }
}
