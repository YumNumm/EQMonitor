//
//  EQMonitorLiveActivityWidget.swift
//  Widget
//
//  Live Activity Widget for EEW and Shake Detection
//

import ActivityKit
import WidgetKit
import SwiftUI

@available(iOS 16.1, *)
struct EQMonitorLiveActivityWidget: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: LiveActivitiesAppAttributes.self) { context in
            // Lock Screen / Banner表示
            LockScreenLiveActivityView(context: context)
        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded Region
                DynamicIslandExpandedRegion(.leading) {
                    ExpandedLeadingView(state: context.state)
                }
                DynamicIslandExpandedRegion(.trailing) {
                    ExpandedTrailingView(state: context.state)
                }
                DynamicIslandExpandedRegion(.bottom) {
                    ExpandedBottomView(state: context.state)
                }
                DynamicIslandExpandedRegion(.center) {
                    ExpandedCenterView(state: context.state)
                }
            } compactLeading: {
                CompactLeadingView(state: context.state)
            } compactTrailing: {
                CompactTrailingView(state: context.state)
            } minimal: {
                MinimalView(state: context.state)
            }
        }
    }
}

// MARK: - Lock Screen View

@available(iOS 16.1, *)
struct LockScreenLiveActivityView: View {
    let context: ActivityViewContext<LiveActivitiesAppAttributes>

    var body: some View {
        if context.state.isEew {
            EewLockScreenView(state: context.state)
        } else {
            ShakeDetectionLockScreenView(state: context.state)
        }
    }
}

// MARK: - Dynamic Island Compact Views

@available(iOS 16.1, *)
struct CompactLeadingView: View {
    let state: LiveActivityContentState

    var body: some View {
        if state.isEew {
            // EEW: 予想震度アイコン
            if let location = state.location,
               let intensity = location.forecastIntensityValue {
                IntensityBadge(intensity: intensity, size: .compact)
            } else if let intensity = state.intensityValue {
                IntensityBadge(intensity: intensity, size: .compact)
            } else {
                Text("EEW")
                    .font(.system(size: 10, weight: .bold, design: .monospaced))
                    .foregroundColor(.orange)
            }
        } else {
            // 揺れ検知: レベル表示
            if let level = state.shakeLevel {
                Text(level.shortDisplayString)
                    .font(.system(size: 14, weight: .bold, design: .monospaced))
                    .foregroundColor(level.textColor)
                    .padding(4)
                    .background(level.backgroundColor)
                    .cornerRadius(4)
            }
        }
    }
}

@available(iOS 16.1, *)
struct CompactTrailingView: View {
    let state: LiveActivityContentState

    var body: some View {
        if state.isEew {
            // EEW: 報番号または警報マーク
            if let isWarning = state.isWarning, isWarning {
                Text("警報")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(.red)
            } else if let serialNo = state.serialNo {
                Text("#\(serialNo)")
                    .font(.system(size: 11, weight: .semibold, design: .monospaced))
            }
        } else {
            // 揺れ検知: 時刻表示
            if let detectedAt = state.detectedAt,
               let date = ISO8601DateFormatter().date(from: detectedAt) {
                Text(date, style: .time)
                    .font(.system(size: 10, weight: .medium, design: .monospaced))
            }
        }
    }
}

// MARK: - Dynamic Island Minimal View

@available(iOS 16.1, *)
struct MinimalView: View {
    let state: LiveActivityContentState

    var body: some View {
        if state.isEew {
            if let location = state.location,
               let intensity = location.forecastIntensityValue {
                IntensityBadge(intensity: intensity, size: .minimal)
            } else if let intensity = state.intensityValue {
                IntensityBadge(intensity: intensity, size: .minimal)
            } else {
                Text("!")
                    .font(.system(size: 12, weight: .bold, design: .monospaced))
                    .foregroundColor(.orange)
            }
        } else {
            if let level = state.shakeLevel {
                Text(level.shortDisplayString)
                    .font(.system(size: 12, weight: .bold, design: .monospaced))
                    .foregroundColor(level.textColor)
            }
        }
    }
}

// MARK: - Dynamic Island Expanded Views

@available(iOS 16.1, *)
struct ExpandedLeadingView: View {
    let state: LiveActivityContentState

    var body: some View {
        if state.isEew {
            if let location = state.location,
               let intensity = location.forecastIntensityValue {
                VStack(alignment: .leading, spacing: 2) {
                    Text("予想震度")
                        .font(.system(size: 10, weight: .medium))
                        .foregroundColor(.secondary)
                    IntensityBadge(intensity: intensity, size: .expanded)
                }
            } else if let intensity = state.intensityValue {
                VStack(alignment: .leading, spacing: 2) {
                    Text("最大震度")
                        .font(.system(size: 10, weight: .medium))
                        .foregroundColor(.secondary)
                    IntensityBadge(intensity: intensity, size: .expanded)
                }
            }
        } else if let level = state.shakeLevel {
            VStack(alignment: .leading, spacing: 2) {
                Text("揺れ検知")
                    .font(.system(size: 10, weight: .medium))
                    .foregroundColor(.secondary)
                Text(level.shortDisplayString)
                    .font(.system(size: 22, weight: .bold, design: .monospaced))
                    .foregroundColor(level.textColor)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(level.backgroundColor)
                    .cornerRadius(6)
            }
        }
    }
}

@available(iOS 16.1, *)
struct ExpandedTrailingView: View {
    let state: LiveActivityContentState

    var body: some View {
        if state.isEew {
            VStack(alignment: .trailing, spacing: 2) {
                if let isWarning = state.isWarning {
                    Text(isWarning ? "警報" : "予報")
                        .font(.system(size: 12, weight: .heavy))
                        .foregroundColor(isWarning ? .red : .orange)
                }
                if let serialNo = state.serialNo {
                    HStack(alignment: .firstTextBaseline, spacing: 0) {
                        Text("#")
                            .font(.system(size: 10, weight: .medium, design: .monospaced))
                            .foregroundColor(.secondary)
                        Text("\(serialNo)")
                            .font(.system(size: 13, weight: .bold, design: .monospaced))
                    }
                }
            }
        } else {
            // 揺れ検知の場合は時刻表示
            if let detectedAt = state.detectedAt,
               let date = ISO8601DateFormatter().date(from: detectedAt) {
                VStack(alignment: .trailing, spacing: 2) {
                    Text("検知時刻")
                        .font(.system(size: 9))
                        .foregroundColor(.secondary)
                    Text(date, style: .time)
                        .font(.system(size: 12, weight: .semibold, design: .monospaced))
                }
            }
        }
    }
}

@available(iOS 16.1, *)
struct ExpandedCenterView: View {
    let state: LiveActivityContentState

    var body: some View {
        if state.isEew {
            if let hypocenterName = state.hypocenterName {
                Text(hypocenterName)
                    .font(.system(size: 17, weight: .bold))
                    .lineLimit(1)
            }
        } else {
            if let level = state.shakeLevel {
                Text(level.displayString)
                    .font(.system(size: 15, weight: .bold))
            }
        }
    }
}

@available(iOS 16.1, *)
struct ExpandedBottomView: View {
    let state: LiveActivityContentState

    var body: some View {
        HStack {
            if state.isEew {
                // EEW情報
                HStack(spacing: 10) {
                    if let magnitude = state.magnitude {
                        HStack(alignment: .firstTextBaseline, spacing: 0) {
                            Text("M")
                                .font(.system(size: 10, weight: .semibold))
                                .foregroundColor(.secondary)
                            Text(String(format: "%.1f", magnitude))
                                .font(.system(size: 15, weight: .bold, design: .monospaced))
                        }
                    }
                    if let depth = state.depth {
                        HStack(alignment: .firstTextBaseline, spacing: 0) {
                            Text("\(depth)")
                                .font(.system(size: 15, weight: .bold, design: .monospaced))
                            Text("km")
                                .font(.system(size: 10, weight: .semibold))
                                .foregroundColor(.secondary)
                        }
                    }
                }
                Spacer()
                // 現在地到達情報
                if let location = state.location {
                    ArrivalInfoView(location: location)
                }
            } else {
                // 揺れ検知情報
                if let location = state.location {
                    Text(location.regionName)
                        .font(.system(size: 13, weight: .medium))
                }
                Spacer()
                if let location = state.location,
                   let intensity = location.intensity {
                    HStack(alignment: .firstTextBaseline, spacing: 2) {
                        Text("計測震度")
                            .font(.system(size: 10, weight: .medium))
                            .foregroundColor(.secondary)
                        Text(String(format: "%.1f", intensity))
                            .font(.system(size: 13, weight: .bold, design: .monospaced))
                    }
                }
            }
        }
    }
}

// MARK: - Arrival Info View

@available(iOS 16.1, *)
struct ArrivalInfoView: View {
    let location: LocationInfo

    var body: some View {
        HStack(spacing: 6) {
            Text(location.regionName)
                .font(.system(size: 11, weight: .medium))
                .foregroundColor(.secondary)

            if let arrivalDate = location.arrivalDate {
                let isArrived = arrivalDate <= Date()
                if isArrived {
                    Text("到達済")
                        .font(.system(size: 12, weight: .bold, design: .monospaced))
                        .foregroundColor(.red)
                } else {
                    Text(arrivalDate, style: .relative)
                        .font(.system(size: 12, weight: .semibold, design: .monospaced))
                }
            }
        }
    }
}

// MARK: - Intensity Badge

@available(iOS 16.1, *)
struct IntensityBadge: View {
    let intensity: IntensityValue
    let size: BadgeSize

    enum BadgeSize {
        case minimal
        case compact
        case expanded

        var fontSize: CGFloat {
            switch self {
            case .minimal: return 10
            case .compact: return 12
            case .expanded: return 20
            }
        }

        var subFontSize: CGFloat {
            switch self {
            case .minimal: return 5
            case .compact: return 6
            case .expanded: return 10
            }
        }

        var padding: CGFloat {
            switch self {
            case .minimal: return 2
            case .compact: return 4
            case .expanded: return 6
            }
        }
    }

    var body: some View {
        let parts = intensity.formattedParts
        HStack(alignment: .firstTextBaseline, spacing: 0) {
            Text(parts.main)
                .font(.system(size: size.fontSize, weight: .bold, design: .monospaced))
            if let sub = parts.sub {
                Text(sub)
                    .font(.system(size: size.subFontSize, weight: .bold, design: .monospaced))
            }
        }
        .foregroundColor(intensity.textColor)
        .padding(.horizontal, size.padding)
        .padding(.vertical, size.padding / 2)
        .background(intensity.backgroundColor)
        .cornerRadius(4)
    }
}

// MARK: - Preview

@available(iOS 17.0, *)
#Preview("EEW - Dynamic Island Expanded", as: .dynamicIsland(.expanded), using: LiveActivitiesAppAttributes(eventId: "20240101123456", type: "eew")) {
    EQMonitorLiveActivityWidget()
} contentStates: {
    LiveActivityContentState(
        eventId: "20240101123456",
        type: "eew",
        hypocenterName: "石川県能登地方",
        magnitude: 7.6,
        depth: 16,
        originTime: "2024-01-01T16:10:00+09:00",
        maxIntensity: "7",
        serialNo: 5,
        isFinal: false,
        isWarning: true,
        level: nil,
        detectedAt: nil,
        location: LocationInfo(
            regionName: "東京都23区",
            forecastIntensity: "5-",
            forecastLpgmIntensity: "2",
            arrivalTime: ISO8601DateFormatter().string(from: Date().addingTimeInterval(30)),
            intensity: nil
        )
    )
}

@available(iOS 17.0, *)
#Preview("Shake Detection - Lock Screen", as: .content, using: LiveActivitiesAppAttributes(eventId: "shake-event-uuid", type: "shake_detection")) {
    EQMonitorLiveActivityWidget()
} contentStates: {
    LiveActivityContentState(
        eventId: "shake-event-uuid",
        type: "shake_detection",
        hypocenterName: nil,
        magnitude: nil,
        depth: nil,
        originTime: nil,
        maxIntensity: nil,
        serialNo: nil,
        isFinal: nil,
        isWarning: nil,
        level: "Strong",
        detectedAt: ISO8601DateFormatter().string(from: Date()),
        location: LocationInfo(
            regionName: "東京都23区",
            forecastIntensity: nil,
            forecastLpgmIntensity: nil,
            arrivalTime: nil,
            intensity: 3.2
        )
    )
}

@available(iOS 17.0, *)
#Preview("EEW - Compact", as: .dynamicIsland(.compact), using: LiveActivitiesAppAttributes(eventId: "20240101123456", type: "eew")) {
    EQMonitorLiveActivityWidget()
} contentStates: {
    LiveActivityContentState(
        eventId: "20240101123456",
        type: "eew",
        hypocenterName: "能登半島沖",
        magnitude: 5.2,
        depth: 10,
        originTime: "2024-01-01T16:10:00+09:00",
        maxIntensity: "5+",
        serialNo: 3,
        isFinal: false,
        isWarning: false,
        level: nil,
        detectedAt: nil,
        location: LocationInfo(
            regionName: "石川県加賀",
            forecastIntensity: "4",
            forecastLpgmIntensity: nil,
            arrivalTime: nil,
            intensity: nil
        )
    )
}
