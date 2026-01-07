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

    // HIG: The standard layout margin for Live Activities on the Lock Screen is 14 points.
    private let standardMargin: CGFloat = 14

    var body: some View {
        VStack(spacing: 0) {
            // ヘッダー
            HStack {
                headerView
                Spacer()
                timeView
            }
            .padding(.horizontal, standardMargin)
            .padding(.top, standardMargin)
            .padding(.bottom, 10)

            // HIG: "When separating a block of content, use a thick line"
            // インセットした区切り線
            Rectangle()
                .fill(separatorColor)
                .frame(height: 3)
                .padding(.horizontal, standardMargin)

            // メインコンテンツ
            HStack(alignment: .center, spacing: 14) {
                // 揺れレベル表示
                levelView

                // 詳細情報
                VStack(alignment: .leading, spacing: 5) {
                    if let level = state.shakeLevel {
                        Text(level.displayString)
                            .font(.system(size: 19, weight: .bold))
                            .foregroundColor(.primary)
                    }

                    if let location = state.location {
                        Text(location.regionName)
                            .font(.system(size: 15, weight: .medium))
                            .foregroundColor(.primary.opacity(0.85))

                        if let intensity = location.intensity {
                            HStack(alignment: .firstTextBaseline, spacing: 2) {
                                Text("計測震度")
                                    .font(.system(size: 12, weight: .semibold))
                                    .foregroundColor(.primary.opacity(0.6))
                                Text(String(format: "%.1f", intensity))
                                    .font(.system(size: 16, weight: .bold, design: .monospaced))
                                    .foregroundColor(.primary)
                            }
                        }
                    }
                }

                Spacer()
            }
            .padding(.horizontal, standardMargin)
            .padding(.top, 10)
            .padding(.bottom, standardMargin)
        }
        .background(backgroundColor)
    }

    // MARK: - Header

    private var headerView: some View {
        Text("揺れを検知しました")
            .font(.system(size: 17, weight: .heavy))
            .foregroundColor(headerColor)
    }

    private var headerColor: Color {
        // レベルに応じた色（背景とのコントラストを確保）
        if let level = state.shakeLevel {
            switch level {
            case .weaker, .weak:
                return .primary
            case .medium:
                return Color(red: 0.7, green: 0.5, blue: 0.0)
            case .strong:
                return Color(red: 0.9, green: 0.3, blue: 0.1)
            case .stronger:
                return Color(red: 0.8, green: 0.1, blue: 0.1)
            }
        }
        return .primary
    }

    private var separatorColor: Color {
        if let level = state.shakeLevel {
            return level.backgroundColor.opacity(0.8)
        }
        return .orange.opacity(0.5)
    }

    // MARK: - Time View

    private var timeView: some View {
        Group {
            if let detectedAt = state.detectedAt,
               let date = ISO8601DateFormatter().date(from: detectedAt) {
                VStack(alignment: .trailing, spacing: 2) {
                    Text("検知時刻")
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundColor(.primary.opacity(0.6))
                    Text(date, style: .time)
                        .font(.system(size: 14, weight: .bold, design: .monospaced))
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
    // HIG: デフォルトの背景色を使用（ダークモードでもライトモードでも適切に表示）

    private var backgroundColor: Color {
        // システムのデフォルト背景色を使用
        // Lock Screenのコンテキストに合わせて自動調整される
        Color.clear
    }
}

// MARK: - Shake Level Badge

@available(iOS 16.1, *)
struct ShakeLevelBadge: View {
    let level: ShakeDetectionLevel

    var body: some View {
        Text(level.shortDisplayString)
            .font(.system(size: 32, weight: .black, design: .monospaced))
            .foregroundColor(level.textColor)
            .frame(width: 60, height: 60)
            .background(level.backgroundColor)
            .cornerRadius(10)
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
