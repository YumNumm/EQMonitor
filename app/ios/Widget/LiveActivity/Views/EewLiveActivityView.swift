//
//  EewLiveActivityView.swift
//  Widget
//
//  緊急地震速報用のLive Activity表示
//

import SwiftUI
import WidgetKit

// MARK: - Header Stripe Line

@available(iOS 16.1, *)
struct HeaderStripeLine: View {
    let isWarning: Bool
    let height: CGFloat

    var body: some View {
        GeometryReader { geometry in
            let stripeWidth: CGFloat = 8
            let colors = isWarning ? [Color.red, Color.black] : [Color.orange, Color.orange.opacity(0.4)]

            HStack(spacing: 0) {
                ForEach(0..<Int(geometry.size.width / stripeWidth) + 4, id: \.self) { index in
                    Rectangle()
                        .fill(colors[index % 2])
                        .frame(width: stripeWidth)
                }
            }
            .frame(height: height)
            .rotationEffect(.degrees(-45), anchor: .center)
            .offset(x: -geometry.size.width / 4)
        }
        .frame(height: height)
        .clipped()
    }
}

@available(iOS 16.1, *)
struct EewLockScreenView: View {
    let state: LiveActivityContentState

    var body: some View {
        VStack(spacing: 0) {
            // ヘッダー部分
            VStack(spacing: 0) {
                HStack {
                    headerView
                    Spacer()
                    serialInfoView
                }
                .padding(.horizontal, 16)
                .padding(.top, 12)
                .padding(.bottom, 8)

                // ヘッダー下のストライプライン
                HeaderStripeLine(
                    isWarning: state.isWarning ?? false,
                    height: 6
                )
            }

            // メインコンテンツ
            HStack(alignment: .center, spacing: 14) {
                // 現在地予想震度表示
                forecastIntensityView

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
            .padding(.horizontal, 16)
            .padding(.top, 10)
            .padding(.bottom, 12)
        }
        .background(backgroundColor)
    }

    // MARK: - Header

    private var headerView: some View {
        Text(headerTitle)
            .font(.system(size: 16, weight: .heavy))
            .foregroundColor(headerTextColor)
    }

    private var headerTitle: String {
        if let isWarning = state.isWarning, isWarning {
            return "緊急地震速報（警報）"
        } else {
            return "緊急地震速報"
        }
    }

    private var headerTextColor: Color {
        if let isWarning = state.isWarning, isWarning {
            return .white
        } else {
            return .white
        }
    }

    // MARK: - Serial Info

    private var serialInfoView: some View {
        HStack(spacing: 6) {
            if let serialNo = state.serialNo {
                HStack(alignment: .firstTextBaseline, spacing: 0) {
                    Text("#")
                        .font(.system(size: 11, weight: .medium, design: .monospaced))
                        .foregroundColor(.white.opacity(0.8))
                    Text("\(serialNo)")
                        .font(.system(size: 14, weight: .bold, design: .monospaced))
                        .foregroundColor(.white)
                }
            }
            if let isFinal = state.isFinal, isFinal {
                Text("最終")
                    .font(.system(size: 11, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.horizontal, 5)
                    .padding(.vertical, 2)
                    .background(Color.white.opacity(0.25))
                    .cornerRadius(4)
            }
        }
    }

    // MARK: - Forecast Intensity (現在地予想震度)

    private var forecastIntensityView: some View {
        Group {
            if let location = state.location,
               let intensity = location.forecastIntensityValue {
                VStack(spacing: 2) {
                    Text("予想震度")
                        .font(.system(size: 10, weight: .semibold))
                        .foregroundColor(.primary.opacity(0.7))
                    LargeIntensityBadge(intensity: intensity)
                }
            } else if let intensity = state.intensityValue {
                // 現在地情報がない場合は最大震度を表示
                VStack(spacing: 2) {
                    Text("最大震度")
                        .font(.system(size: 10, weight: .semibold))
                        .foregroundColor(.primary.opacity(0.7))
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
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.primary)
                    .lineLimit(1)
            }
        }
    }

    private var detailsView: some View {
        HStack(spacing: 10) {
            if let magnitude = state.magnitude {
                HStack(alignment: .firstTextBaseline, spacing: 0) {
                    Text("M")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(.primary.opacity(0.6))
                    Text(String(format: "%.1f", magnitude))
                        .font(.system(size: 17, weight: .bold, design: .monospaced))
                        .foregroundColor(.primary)
                }
            }
            if let depth = state.depth {
                HStack(alignment: .firstTextBaseline, spacing: 0) {
                    Text("\(depth)")
                        .font(.system(size: 17, weight: .bold, design: .monospaced))
                        .foregroundColor(.primary)
                    Text("km")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(.primary.opacity(0.6))
                }
            }
        }
    }

    // MARK: - Arrival Info

    private func arrivalView(location: LocationInfo) -> some View {
        VStack(alignment: .trailing, spacing: 4) {
            Text(location.regionName)
                .font(.system(size: 13, weight: .semibold))
                .foregroundColor(.primary.opacity(0.85))

            if let arrivalDate = location.arrivalDate {
                ArrivalCountdownView(arrivalDate: arrivalDate)
            }
        }
    }

    // MARK: - Background

    private var backgroundColor: Color {
        if let isWarning = state.isWarning, isWarning {
            // 警報: 目立つ赤色（コントラスト確保のため彩度を調整）
            return Color(red: 0.75, green: 0.15, blue: 0.15)
        } else {
            // 予報: オレンジ色
            return Color(red: 0.85, green: 0.45, blue: 0.1)
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
                .font(.system(size: 40, weight: .black, design: .monospaced))
            if let sub = parts.sub {
                Text(sub)
                    .font(.system(size: 18, weight: .bold, design: .monospaced))
            }
        }
        .foregroundColor(intensity.textColor)
        .frame(minWidth: 54)
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
                .font(.system(size: 17, weight: .black, design: .monospaced))
                .foregroundColor(.red)
        } else {
            VStack(alignment: .trailing, spacing: 0) {
                Text("到達まで")
                    .font(.system(size: 10, weight: .semibold))
                    .foregroundColor(.primary.opacity(0.7))
                Text(arrivalDate, style: .relative)
                    .font(.system(size: 17, weight: .bold, design: .monospaced))
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
}

@available(iOS 17.0, *)
#Preview("EEW Lock Screen - Warning Final") {
    EewLockScreenView(state: LiveActivityContentState(
        eventId: "20240101123456",
        type: "eew",
        hypocenterName: "能登半島沖",
        magnitude: 5.8,
        depth: 10,
        originTime: "2024-01-01T16:10:00+09:00",
        maxIntensity: "6+",
        serialNo: 12,
        isFinal: true,
        isWarning: true,
        level: nil,
        detectedAt: nil,
        location: LocationInfo(
            regionName: "石川県加賀",
            forecastIntensity: "6-",
            forecastLpgmIntensity: "3",
            arrivalTime: ISO8601DateFormatter().string(from: Date().addingTimeInterval(-5)),
            intensity: nil
        )
    ))
}
