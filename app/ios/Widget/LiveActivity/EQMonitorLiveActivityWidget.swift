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
            // EEW: 震度アイコン
            if let intensity = state.intensityValue {
                IntensityBadge(intensity: intensity, size: .compact)
            } else {
                Image(systemName: "exclamationmark.triangle.fill")
                    .foregroundColor(.orange)
            }
        } else {
            // 揺れ検知: 波形アイコン
            Image(systemName: "waveform.path.ecg")
                .foregroundColor(.orange)
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
                    .font(.caption2)
                    .fontWeight(.bold)
                    .foregroundColor(.red)
            } else if let serialNo = state.serialNo {
                Text("第\(serialNo)報")
                    .font(.caption2)
            }
        } else {
            // 揺れ検知: レベル表示
            if let level = state.shakeLevel {
                Text(level.displayString)
                    .font(.caption2)
                    .lineLimit(1)
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
            if let intensity = state.intensityValue {
                IntensityBadge(intensity: intensity, size: .minimal)
            } else {
                Image(systemName: "exclamationmark.triangle.fill")
                    .foregroundColor(.orange)
            }
        } else {
            Image(systemName: "waveform.path.ecg")
                .foregroundColor(.orange)
        }
    }
}

// MARK: - Dynamic Island Expanded Views

@available(iOS 16.1, *)
struct ExpandedLeadingView: View {
    let state: LiveActivityContentState
    
    var body: some View {
        if state.isEew {
            if let intensity = state.intensityValue {
                VStack(alignment: .leading, spacing: 2) {
                    Text("最大震度")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                    IntensityBadge(intensity: intensity, size: .expanded)
                }
            }
        } else if let level = state.shakeLevel {
            VStack(alignment: .leading, spacing: 2) {
                Text("揺れ検知")
                    .font(.caption2)
                    .foregroundColor(.secondary)
                Text(level.displayString)
                    .font(.headline)
                    .fontWeight(.bold)
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
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(isWarning ? .red : .orange)
                }
                if let serialNo = state.serialNo {
                    Text("第\(serialNo)報")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }
            }
        } else {
            // 揺れ検知の場合は到達時刻不要
            SwiftUI.EmptyView()
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
                    .font(.headline)
                    .fontWeight(.bold)
                    .lineLimit(1)
            }
        } else {
            Text("揺れを検知しました")
                .font(.headline)
                .fontWeight(.bold)
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
                if let magnitude = state.magnitude {
                    Label("M\(String(format: "%.1f", magnitude))", systemImage: "scalemass")
                        .font(.caption)
                }
                if let depth = state.depth {
                    Label("\(depth)km", systemImage: "arrow.down.to.line")
                        .font(.caption)
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
                        .font(.caption)
                }
                Spacer()
                if let detectedAt = state.detectedAt,
                   let date = ISO8601DateFormatter().date(from: detectedAt) {
                    Text(date, style: .time)
                        .font(.caption)
                        .foregroundColor(.secondary)
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
            if let arrivalDate = location.arrivalDate {
                let isArrived = arrivalDate <= Date()
                if isArrived {
                    Text("到達済")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(.red)
                } else {
                    Text(arrivalDate, style: .relative)
                        .font(.caption)
                        .monospacedDigit()
                }
            }
            if let intensity = location.forecastIntensityValue {
                IntensityBadge(intensity: intensity, size: .minimal)
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
        
        var fontSize: Font {
            switch self {
            case .minimal: return .caption2
            case .compact: return .caption
            case .expanded: return .title3
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
        HStack(spacing: 0) {
            Text(parts.main)
                .font(size.fontSize)
                .fontWeight(.bold)
            if let sub = parts.sub {
                Text(sub)
                    .font(.system(size: size == .minimal ? 6 : 8))
                    .fontWeight(.bold)
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
