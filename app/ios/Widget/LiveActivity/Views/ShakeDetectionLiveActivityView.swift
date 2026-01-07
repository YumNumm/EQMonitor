//
//  ShakeDetectionLiveActivityView.swift
//  Widget
//
//  揺れ検知用のLive Activity表示
//

import SwiftUI
import WidgetKit

// MARK: - Shake Detection Top Line

@available(iOS 16.1, *)
struct ShakeDetectionTopLine: View {
    let level: ShakeDetectionLevel
    let height: CGFloat
    
    var body: some View {
        Rectangle()
            .fill(level.backgroundColor)
            .frame(height: height)
    }
}

@available(iOS 16.1, *)
struct ShakeDetectionLockScreenView: View {
    let state: LiveActivityContentState
    
    var body: some View {
        VStack(spacing: 0) {
            // 上部のライン
            if let level = state.shakeLevel {
                ShakeDetectionTopLine(level: level, height: 8)
            }
            
            VStack(spacing: 10) {
                // ヘッダー
                HStack {
                    headerView
                    Spacer()
                    timeView
                }
                
                // メインコンテンツ
                HStack(alignment: .center, spacing: 16) {
                    // 揺れレベル表示
                    levelView
                    
                    // 詳細情報
                    VStack(alignment: .leading, spacing: 6) {
                        if let level = state.shakeLevel {
                            Text(level.displayString)
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(.primary)
                        }
                        
                        if let location = state.location {
                            Text(location.regionName)
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.primary.opacity(0.8))
                            
                            if let intensity = location.intensity {
                                HStack(alignment: .firstTextBaseline, spacing: 2) {
                                    Text("計測震度")
                                        .font(.system(size: 11, weight: .medium))
                                        .foregroundColor(.primary.opacity(0.7))
                                    Text(String(format: "%.1f", intensity))
                                        .font(.system(size: 14, weight: .bold, design: .monospaced))
                                        .foregroundColor(.primary)
                                }
                            }
                        }
                    }
                    
                    Spacer()
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
        }
        .background(backgroundColor)
    }
    
    // MARK: - Header
    
    private var headerView: some View {
        Text("揺れを検知しました")
            .font(.system(size: 15, weight: .bold))
            .foregroundColor(levelColor)
    }
    
    private var levelColor: Color {
        state.shakeLevel?.backgroundColor ?? .orange
    }
    
    // MARK: - Time View
    
    private var timeView: some View {
        Group {
            if let detectedAt = state.detectedAt,
               let date = ISO8601DateFormatter().date(from: detectedAt) {
                VStack(alignment: .trailing, spacing: 2) {
                    Text("検知時刻")
                        .font(.system(size: 10, weight: .medium))
                        .foregroundColor(.primary.opacity(0.7))
                    Text(date, style: .time)
                        .font(.system(size: 13, weight: .semibold, design: .monospaced))
                        .foregroundColor(.primary)
                }
            }
        }
    }
    
    // MARK: - Level View
    
    private var levelView: some View {
        Group {
            if let level = state.shakeLevel {
                ShakeLevelBadge(level: level)
            }
        }
    }
    
    // MARK: - Background
    
    private var backgroundColor: Color {
        let color = state.shakeLevel?.backgroundColor ?? .orange
        return color.opacity(0.1)
    }
}

// MARK: - Shake Level Badge

@available(iOS 16.1, *)
struct ShakeLevelBadge: View {
    let level: ShakeDetectionLevel
    
    var body: some View {
        Text(level.shortDisplayString)
            .font(.system(size: 28, weight: .bold, design: .monospaced))
            .foregroundColor(level.textColor)
            .frame(width: 56, height: 56)
            .background(level.backgroundColor)
            .cornerRadius(8)
    }
}

// MARK: - ShakeDetectionLevel Extension

extension ShakeDetectionLevel {
    var shortDisplayString: String {
        switch self {
        case .weaker: return "微"
        case .weak: return "弱"
        case .medium: return "中"
        case .strong: return "強"
        case .stronger: return "激"
        }
    }
}

// MARK: - Preview

@available(iOS 17.0, *)
#Preview("Shake Detection - Strong") {
    ShakeDetectionLockScreenView(state: LiveActivityContentState(
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
    ))
}

@available(iOS 17.0, *)
#Preview("Shake Detection - Weak") {
    ShakeDetectionLockScreenView(state: LiveActivityContentState(
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
        level: "Weak",
        detectedAt: ISO8601DateFormatter().string(from: Date()),
        location: LocationInfo(
            regionName: "神奈川県東部",
            forecastIntensity: nil,
            forecastLpgmIntensity: nil,
            arrivalTime: nil,
            intensity: 0.8
        )
    ))
}

@available(iOS 17.0, *)
#Preview("Shake Detection - Stronger") {
    ShakeDetectionLockScreenView(state: LiveActivityContentState(
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
        level: "Stronger",
        detectedAt: ISO8601DateFormatter().string(from: Date()),
        location: LocationInfo(
            regionName: "石川県能登",
            forecastIntensity: nil,
            forecastLpgmIntensity: nil,
            arrivalTime: nil,
            intensity: 5.2
        )
    ))
}

@available(iOS 17.0, *)
#Preview("Shake Detection - Medium") {
    ShakeDetectionLockScreenView(state: LiveActivityContentState(
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
        level: "Medium",
        detectedAt: ISO8601DateFormatter().string(from: Date()),
        location: LocationInfo(
            regionName: "千葉県北西部",
            forecastIntensity: nil,
            forecastLpgmIntensity: nil,
            arrivalTime: nil,
            intensity: 2.1
        )
    ))
}
