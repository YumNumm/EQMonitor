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
            // HIG: Tint your Live Activity's key line color
            .keylineTint(context.state.isWarning == true ? .red : .orange)
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
// HIG: "Keep content as narrow as possible and ensure it's snug against the TrueDepth camera"
// HIG: "Use the compact presentation to show dynamic, up-to-date information that's essential"

@available(iOS 16.1, *)
struct CompactLeadingView: View {
    let state: LiveActivityContentState

    var body: some View {
        if state.isEew {
            // EEW: 予想震度（コンパクトに）
            if let location = state.location,
               let intensity = location.forecastIntensityValue {
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
        } else {
            // 揺れ検知: レベル表示
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
}

@available(iOS 16.1, *)
struct CompactTrailingView: View {
    let state: LiveActivityContentState

    var body: some View {
        if state.isEew {
            // EEW: 警報/予報
            if let isWarning = state.isWarning, isWarning {
                Text("警報")
                    .font(.system(size: 11, weight: .heavy))
                    .foregroundColor(.red)
            } else {
                Text("予報")
                    .font(.system(size: 11, weight: .bold))
                    .foregroundColor(.orange)
            }
        } else {
            // 揺れ検知: 時刻表示
            if let detectedAt = state.detectedAt,
               let date = ISO8601DateFormatter().date(from: detectedAt) {
                Text(date, style: .time)
                    .font(.system(size: 11, weight: .semibold, design: .monospaced))
            }
        }
    }
}

// MARK: - Compact Intensity Badge

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

// MARK: - Dynamic Island Minimal View
// HIG: "Ensure that your Live Activity is recognizable in the minimal presentation"
// HIG: "If possible, display updated information rather than just a logo"

@available(iOS 16.1, *)
struct MinimalView: View {
    let state: LiveActivityContentState

    var body: some View {
        if state.isEew {
            if let location = state.location,
               let intensity = location.forecastIntensityValue {
                MinimalIntensityBadge(intensity: intensity)
            } else if let intensity = state.intensityValue {
                MinimalIntensityBadge(intensity: intensity)
            } else {
                Image("AppIconForeground")
                    .resizable()
                    .scaledToFit()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 18, height: 18)
            }
        } else {
            if let level = state.shakeLevel {
                Text(level.shortDisplayString)
                    .font(.system(size: 14, weight: .black, design: .monospaced))
                    .foregroundColor(level.textColor)
            }
        }
    }
}

// MARK: - Minimal Intensity Badge

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

// MARK: - Dynamic Island Expanded Views
// HIG: "Maintain the relative placement of elements to create a coherent layout between presentations"

@available(iOS 16.1, *)
struct ExpandedLeadingView: View {
    let state: LiveActivityContentState

    var body: some View {
        if state.isEew {
            if let location = state.location,
               let intensity = location.forecastIntensityValue {
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
        } else if let level = state.shakeLevel {
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

// MARK: - Expanded Intensity Badge

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
struct ExpandedTrailingView: View {
    let state: LiveActivityContentState

    var body: some View {
        if state.isEew {
            VStack(alignment: .trailing, spacing: 2) {
                // 警報/予報
                if let isWarning = state.isWarning {
                    Text(isWarning ? "警報" : "予報")

                        .font(.system(size: 13, weight: .heavy))
                        .foregroundColor(isWarning ? .red : .orange)
                }
                // Serial Number + アイコン
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
        } else {
            // 揺れ検知
            if let detectedAt = state.detectedAt,
               let date = ISO8601DateFormatter().date(from: detectedAt) {
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
}

@available(iOS 16.1, *)
struct ExpandedCenterView: View {
    let state: LiveActivityContentState

    var body: some View {
        if state.isEew {
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
        } else {
            if let level = state.shakeLevel {
                Text(level.displayString)
                    .font(.system(size: 14, weight: .bold))
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
                HStack(spacing: 12) {
                    // マグニチュード
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
                    // 深さ
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
                // 現在地到達情報
                if let location = state.location {
                    ArrivalInfoView(location: location)
                }
            } else {
                // 揺れ検知情報
                if let location = state.location {
                    Text(location.regionName)
                        .font(.system(size: 13, weight: .semibold))
                }
                Spacer()
                if let location = state.location,
                   let intensity = location.intensity {
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
}

// MARK: - Arrival Info View

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

// MARK: - Preview

@available(iOS 17.0, *)
#Preview("EEW - Content", as: .content, using: LiveActivitiesAppAttributes(eventId: "20240101123456", type: "eew")) {
    EQMonitorLiveActivityWidget()
} contentStates: {
    LiveActivityContentState(
        eventId: "20240101123456",
        type: "eew",
        hypocenterName: "石川県能登地方",
        magnitude: 6.3,
        depth: 70,
        time: "2024-01-01T16:10:00+09:00",
        isOriginTime: true,
        maxIntensity: "6+",
        serialNo: 32,
        isFinal: false,
        isWarning: true,
        isCanceled: false,
        headline: "釧路沖で地震 北海道で強い揺れ",
        isPlum: false,
        isLevel: false,
        isOnePoint: false,
        level: nil,
        detectedAt: nil,
        location: LocationInfo(
            regionName: "根室地方南部",
            forecastIntensity: "4",
            forecastLpgmIntensity: "2",
            arrivalTime: ISO8601DateFormatter().string(from: Date().addingTimeInterval(30)),
            intensity: nil
        )
    )
}

@available(iOS 17.0, *)
#Preview("EEW - Compact Warning", as: .dynamicIsland(.compact), using: LiveActivitiesAppAttributes(eventId: "20240101123456", type: "eew")) {
    EQMonitorLiveActivityWidget()
} contentStates: {
    LiveActivityContentState(
        eventId: "20240101123456",
        type: "eew",
        hypocenterName: "能登半島沖",
        magnitude: 6.2,
        depth: 10,
        time: "2024-01-01T16:10:00+09:00",
        isOriginTime: true,
        maxIntensity: "6+",
        serialNo: 3,
        isFinal: false,
        isWarning: true,
        isCanceled: false,
        headline: "能登半島沖で地震 石川県加賀で強い揺れ",
        isPlum: false,
        isLevel: false,
        isOnePoint: false,
        level: nil,
        detectedAt: nil,
        location: LocationInfo(
            regionName: "石川県加賀",
            forecastIntensity: "5+",
            forecastLpgmIntensity: nil,
            arrivalTime: nil,
            intensity: nil
        )
    )
}

@available(iOS 17.0, *)
#Preview("EEW - Compact Forecast", as: .dynamicIsland(.compact), using: LiveActivitiesAppAttributes(eventId: "20240101123456", type: "eew")) {
    EQMonitorLiveActivityWidget()
} contentStates: {
    LiveActivityContentState(
        eventId: "20240101123456",
        type: "eew",
        hypocenterName: "茨城県沖",
        magnitude: 4.2,
        depth: 40,
        time: "2024-01-01T16:10:00+09:00",
        isOriginTime: true,
        maxIntensity: "3",
        serialNo: 1,
        isFinal: false,
        isWarning: false,
        isCanceled: false,
        headline: "茨城県沖で地震",
        isPlum: false,
        isLevel: false,
        isOnePoint: false,
        level: nil,
        detectedAt: nil,
        location: nil
    )
}

@available(iOS 17.0, *)
#Preview("EEW - Minimal", as: .dynamicIsland(.minimal), using: LiveActivitiesAppAttributes(eventId: "20240101123456", type: "eew")) {
    EQMonitorLiveActivityWidget()
} contentStates: {
    LiveActivityContentState(
        eventId: "20240101123456",
        type: "eew",
        hypocenterName: "石川県能登地方",
        magnitude: 7.6,
        depth: 16,
        time: "2024-01-01T16:10:00+09:00",
        isOriginTime: true,
        maxIntensity: "7",
        serialNo: 5,
        isFinal: false,
        isWarning: true,
        isCanceled: false,
        headline: "石川県能登地方で地震 石川 新潟で強い揺れ",
        isPlum: false,
        isLevel: false,
        isOnePoint: false,
        level: nil,
        detectedAt: nil,
        location: LocationInfo(
            regionName: "東京都23区",
            forecastIntensity: "5-",
            forecastLpgmIntensity: "2",
            arrivalTime: nil,
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
        time: nil,
        isOriginTime: nil,
        maxIntensity: nil,
        serialNo: nil,
        isFinal: nil,
        isWarning: nil,
        isCanceled: nil,
        headline: nil,
        isPlum: nil,
        isLevel: nil,
        isOnePoint: nil,
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
