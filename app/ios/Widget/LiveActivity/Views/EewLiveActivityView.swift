//
//  EewLiveActivityView.swift
//  Widget
//
//  緊急地震速報用のLive Activity表示
//

import SwiftUI
import WidgetKit

@available(iOS 16.1, *)
struct EewLockScreenView: View {
    let state: LiveActivityContentState

    var body: some View {
        VStack(spacing: 8) {
            // ヘッダー
            HStack {
                headerView
                Spacer()
                serialInfoView
            }

            // メインコンテンツ
            HStack(alignment: .center, spacing: 12) {
                // 震度表示
                intensityView

                // 震源情報
                VStack(alignment: .leading, spacing: 4) {
                    hypocenterNameView
                    detailsView
                }

                Spacer()

                // 現在地到達情報
                if let location = state.location {
                    arrivalView(location: location)
                }
            }
        }
        .padding()
        .background(backgroundGradient)
    }

    // MARK: - Header

    private var headerView: some View {
        HStack(spacing: 4) {
            Image(systemName: "exclamationmark.triangle.fill")
                .foregroundColor(warningColor)
            Text(headerTitle)
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(warningColor)
        }
    }

    private var headerTitle: String {
        if let isWarning = state.isWarning, isWarning {
            return "緊急地震速報（警報）"
        } else {
            return "緊急地震速報"
        }
    }

    private var warningColor: Color {
        if let isWarning = state.isWarning, isWarning {
            return .red
        } else {
            return .orange
        }
    }

    // MARK: - Serial Info

    private var serialInfoView: some View {
        VStack(alignment: .trailing, spacing: 2) {
            if let serialNo = state.serialNo {
                Text("第\(serialNo)報")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            if let isFinal = state.isFinal, isFinal {
                Text("最終報")
                    .font(.caption2)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
            }
        }
    }

    // MARK: - Intensity

    private var intensityView: some View {
        Group {
            if let intensity = state.intensityValue {
                VStack(spacing: 2) {
                    Text("最大震度")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                    LargeIntensityBadge(intensity: intensity)
                }
            }
        }
    }

    // MARK: - Hypocenter

    private var hypocenterNameView: some View {
        Group {
            if let name = state.hypocenterName {
                Text(name)
                    .font(.title3)
                    .fontWeight(.bold)
                    .lineLimit(1)
            }
        }
    }

    private var detailsView: some View {
        HStack(spacing: 8) {
            if let magnitude = state.magnitude {
                Label {
                    Text("M\(String(format: "%.1f", magnitude))")
                        .font(.subheadline)
                } icon: {
                    Image(systemName: "scalemass")
                        .font(.caption)
                }
            }
            if let depth = state.depth {
                Label {
                    Text("\(depth)km")
                        .font(.subheadline)
                } icon: {
                    Image(systemName: "arrow.down.to.line")
                        .font(.caption)
                }
            }
        }
        .foregroundColor(.secondary)
    }

    // MARK: - Arrival Info

    private func arrivalView(location: LocationInfo) -> some View {
        VStack(alignment: .trailing, spacing: 4) {
            Text(location.regionName)
                .font(.caption)
                .foregroundColor(.secondary)

            if let intensity = location.forecastIntensityValue {
                HStack(spacing: 4) {
                    Text("予想")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                    IntensityBadge(intensity: intensity, size: .compact)
                }
            }

            if let arrivalDate = location.arrivalDate {
                ArrivalCountdownView(arrivalDate: arrivalDate)
            }
        }
    }

    // MARK: - Background

    private var backgroundGradient: some ShapeStyle {
        if let isWarning = state.isWarning, isWarning {
            return LinearGradient(
                colors: [
                    Color.red.opacity(0.15),
                    Color.red.opacity(0.05)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
        } else {
            return LinearGradient(
                colors: [
                    Color.orange.opacity(0.15),
                    Color.orange.opacity(0.05)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
        }
    }
}

// MARK: - Large Intensity Badge

@available(iOS 16.1, *)
struct LargeIntensityBadge: View {
    let intensity: IntensityValue

    var body: some View {
        let parts = intensity.formattedParts
        HStack(alignment: .firstTextBaseline, spacing: 0) {
            Text(parts.main)
                .font(.system(size: 36, weight: .bold))
            if let sub = parts.sub {
                Text(sub)
                    .font(.system(size: 14, weight: .bold))
            }
        }
        .foregroundColor(intensity.textColor)
        .frame(minWidth: 50)
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(intensity.backgroundColor)
        .cornerRadius(8)
    }
}

// MARK: - Arrival Countdown View

@available(iOS 16.1, *)
struct ArrivalCountdownView: View {
    let arrivalDate: Date

    var body: some View {
        let isArrived = arrivalDate <= Date()

        if isArrived {
            Text("到達済")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.red)
        } else {
            VStack(alignment: .trailing, spacing: 0) {
                Text("到達まで")
                    .font(.caption2)
                    .foregroundColor(.secondary)
                Text(arrivalDate, style: .relative)
                    .font(.headline)
                    .fontWeight(.bold)
                    .monospacedDigit()
                    .foregroundColor(.primary)
            }
        }
    }
}

// MARK: - Preview

@available(iOS 17.0, *)
#Preview("EEW Lock Screen - Warning") {
    EewLockScreenView(state: LiveActivityContentState(
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
    ))
    .previewLayout(.sizeThatFits)
}

@available(iOS 17.0, *)
#Preview("EEW Lock Screen - Forecast") {
    EewLockScreenView(state: LiveActivityContentState(
        eventId: "20240101123456",
        type: "eew",
        hypocenterName: "茨城県沖",
        magnitude: 4.2,
        depth: 40,
        originTime: "2024-01-01T16:10:00+09:00",
        maxIntensity: "3",
        serialNo: 1,
        isFinal: false,
        isWarning: false,
        level: nil,
        detectedAt: nil,
        location: nil
    ))
    .previewLayout(.sizeThatFits)
}
