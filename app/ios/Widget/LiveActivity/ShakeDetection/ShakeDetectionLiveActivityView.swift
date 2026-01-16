//
//  ShakeDetectionLiveActivityView.swift
//  Widget
//

import SwiftUI
import WidgetKit

@available(iOS 16.1, *)
struct ShakeDetectionLockScreenView: View {
    let state: ShakeDetectionContentState

    private let standardMargin: CGFloat = 14

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                headerView
                Spacer()
                timeView
            }
            .padding(.horizontal, standardMargin)
            .padding(.top, standardMargin)
            .padding(.bottom, 10)

            Rectangle()
                .fill(separatorColor)
                .frame(height: 3)
                .padding(.horizontal, standardMargin)

            HStack(alignment: .center, spacing: 14) {
                levelView

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
    }

    private var headerView: some View {
        Text("揺れを検知しました")
            .font(.system(size: 17, weight: .heavy))
            .foregroundColor(headerColor)
    }

    private var headerColor: Color {
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

    private var timeView: some View {
        Group {
            if let date = state.detectedDate {
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

    private var levelView: some View {
        Group {
            if let level = state.shakeLevel {
                ShakeLevelBadge(level: level)
            }
        }
    }
}

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

// MARK: - Preview

@available(iOS 17.0, *)
#Preview("Shake Detection - Strong") {
    ShakeDetectionLockScreenView(state: ShakeDetectionContentState(
        eventId: "shake-event-uuid",
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
    ShakeDetectionLockScreenView(state: ShakeDetectionContentState(
        eventId: "shake-event-uuid",
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
    ShakeDetectionLockScreenView(state: ShakeDetectionContentState(
        eventId: "shake-event-uuid",
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
    ShakeDetectionLockScreenView(state: ShakeDetectionContentState(
        eventId: "shake-event-uuid",
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
