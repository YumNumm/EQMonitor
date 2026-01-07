//
//  ShakeDetectionLiveActivityView.swift
//  Widget
//
//  揺れ検知用のLive Activity表示
//

import SwiftUI
import WidgetKit

@available(iOS 16.1, *)
struct ShakeDetectionLockScreenView: View {
    let state: LiveActivityContentState
    
    var body: some View {
        VStack(spacing: 8) {
            // ヘッダー
            HStack {
                headerView
                Spacer()
                timeView
            }
            
            // メインコンテンツ
            HStack(alignment: .center, spacing: 12) {
                // 揺れレベル表示
                levelView
                
                // 詳細情報
                VStack(alignment: .leading, spacing: 4) {
                    if let level = state.shakeLevel {
                        Text(level.displayString)
                            .font(.title3)
                            .fontWeight(.bold)
                    }
                    
                    if let location = state.location {
                        Text(location.regionName)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        
                        if let intensity = location.intensity {
                            Text("計測震度: \(String(format: "%.1f", intensity))")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                }
                
                Spacer()
            }
        }
        .padding()
        .background(backgroundGradient)
    }
    
    // MARK: - Header
    
    private var headerView: some View {
        HStack(spacing: 4) {
            Image(systemName: "waveform.path.ecg")
                .foregroundColor(levelColor)
            Text("揺れを検知しました")
                .font(.headline)
                .fontWeight(.bold)
        }
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
                        .font(.caption2)
                        .foregroundColor(.secondary)
                    Text(date, style: .time)
                        .font(.caption)
                        .monospacedDigit()
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
    
    private var backgroundGradient: some ShapeStyle {
        let color = state.shakeLevel?.backgroundColor ?? .orange
        return LinearGradient(
            colors: [
                color.opacity(0.15),
                color.opacity(0.05)
            ],
            startPoint: .top,
            endPoint: .bottom
        )
    }
}

// MARK: - Shake Level Badge

@available(iOS 16.1, *)
struct ShakeLevelBadge: View {
    let level: ShakeDetectionLevel
    
    var body: some View {
        VStack(spacing: 2) {
            Image(systemName: iconName)
                .font(.system(size: 24))
                .foregroundColor(level.textColor)
        }
        .frame(width: 50, height: 50)
        .background(level.backgroundColor)
        .cornerRadius(8)
    }
    
    private var iconName: String {
        switch level {
        case .weaker, .weak:
            return "waveform.path.ecg"
        case .medium:
            return "waveform"
        case .strong:
            return "waveform.badge.exclamationmark"
        case .stronger:
            return "exclamationmark.triangle.fill"
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
    .previewLayout(.sizeThatFits)
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
    .previewLayout(.sizeThatFits)
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
    .previewLayout(.sizeThatFits)
}
