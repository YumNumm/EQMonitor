//
//  EewLiveActivityView.swift
//  Widget
//
//  緊急地震速報用のLive Activity表示
//

import SwiftUI
import WidgetKit

// MARK: - Stripe Line

@available(iOS 16.1, *)
struct StripeLine: View {
    let isWarning: Bool
    let height: CGFloat

    var body: some View {
        GeometryReader { geometry in
            let stripeWidth: CGFloat = 8
            let colors = isWarning
                ? [Color.red, Color.black]
                : [Color.orange, Color(red: 0.6, green: 0.35, blue: 0.0)]

            Canvas { context, size in
                let totalWidth = size.width + size.height * 2
                var x: CGFloat = -size.height

                while x < totalWidth {
                    var path = Path()
                    path.move(to: CGPoint(x: x, y: size.height))
                    path.addLine(to: CGPoint(x: x + stripeWidth, y: size.height))
                    path.addLine(to: CGPoint(x: x + size.height + stripeWidth, y: 0))
                    path.addLine(to: CGPoint(x: x + size.height, y: 0))
                    path.closeSubpath()

                    let colorIndex = Int(x / stripeWidth) % 2
                    context.fill(path, with: .color(colors[abs(colorIndex)]))
                    x += stripeWidth
                }
            }
        }
        .frame(height: height)
    }
}

@available(iOS 16.1, *)
struct EewLockScreenView: View {
    let state: LiveActivityContentState

    // HIG: The standard layout margin for Live Activities on the Lock Screen is 14 points.
    private let standardMargin: CGFloat = 14

    var body: some View {
        VStack(spacing: 0) {
            // ヘッダー部分
            VStack(spacing: 0) {
                // 上部のストライプライン（ヘッダー内側）
                StripeLine(
                    isWarning: state.isWarning ?? false,
                    height: 5
                )
                .padding(.horizontal, standardMargin)
                .padding(.top, standardMargin)

                // ヘッダーコンテンツ
                HStack(alignment: .center) {
                    // タイトル
                    Text(headerTitle)
                        .font(.system(size: 15, weight: .heavy))
                        .foregroundColor(headerTextColor)

                    Spacer()

                    // Serial Number
                    if let serialNo = state.serialNo {
                        HStack(alignment: .firstTextBaseline, spacing: 0) {
                            Text("#")
                                .font(.system(size: 11, weight: .medium, design: .monospaced))
                                .foregroundColor(.primary.opacity(0.5))
                            Text("\(serialNo)")
                                .font(.system(size: 14, weight: .bold, design: .monospaced))
                                .foregroundColor(.primary)
                        }
                    }

                    // アプリアイコン
                    Image("AppIconForeground")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24, height: 24)
                        .clipShape(RoundedRectangle(cornerRadius: 6))
                }
                .padding(.horizontal, standardMargin)
                .padding(.top, 8)
                .padding(.bottom, 10)
            }

            // メインコンテンツ
            HStack(alignment: .top, spacing: 12) {
                // 現在地予想震度表示（正方形、余白小さく）
                forecastIntensityView

                // 震源情報
                VStack(alignment: .leading, spacing: 2) {
                    // 震源地ラベル
                    Text("震源地")
                        .font(.system(size: 10, weight: .medium))
                        .foregroundColor(.primary.opacity(0.5))

                    // 震源地名
                    if let name = state.hypocenterName {
                        Text(name)
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.primary)
                            .lineLimit(1)
                    }

                    // 詳細情報
                    detailsView
                }

                Spacer()

                // 現在地到達情報
                if let location = state.location {
                    arrivalView(location: location)
                }
            }
            .padding(.horizontal, standardMargin)
            .padding(.top, 8)
            .padding(.bottom, standardMargin)
        }
    }

    // MARK: - Header

    private var headerTitle: String {
        if let isWarning = state.isWarning, isWarning {
            return "緊急地震速報（警報）"
        } else {
            return "緊急地震速報"
        }
    }

    private var headerTextColor: Color {
        if let isWarning = state.isWarning, isWarning {
            return .red
        } else {
            return .orange
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
                        .foregroundColor(.primary.opacity(0.6))
                    SquareIntensityBadge(intensity: intensity)
                }
            } else if let intensity = state.intensityValue {
                VStack(spacing: 2) {
                    Text("最大震度")
                        .font(.system(size: 10, weight: .semibold))
                        .foregroundColor(.primary.opacity(0.6))
                    SquareIntensityBadge(intensity: intensity)
                }
            }
        }
    }

    // MARK: - Details

    private var detailsView: some View {
        HStack(spacing: 14) {
            // マグニチュード
            if let magnitude = state.magnitude {
                HStack(alignment: .firstTextBaseline, spacing: 1) {
                    Text("M")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(.primary.opacity(0.5))
                    Text(String(format: "%.1f", magnitude))
                        .font(.system(size: 17, weight: .bold, design: .monospaced))
                        .foregroundColor(.primary)
                }
            }

            // 深さ
            if let depth = state.depth {
                HStack(alignment: .firstTextBaseline, spacing: 1) {
                    Text("深さ")
                        .font(.system(size: 10, weight: .medium))
                        .foregroundColor(.primary.opacity(0.5))
                    Text("\(depth)")
                        .font(.system(size: 17, weight: .bold, design: .monospaced))
                        .foregroundColor(.primary)
                    Text("km")
                        .font(.system(size: 10, weight: .medium))
                        .foregroundColor(.primary.opacity(0.5))
                }
            }

            // 発生時刻
            if let originTime = state.originTime,
               let date = ISO8601DateFormatter().date(from: originTime) {
                HStack(alignment: .firstTextBaseline, spacing: 2) {
                    Text(date, style: .time)
                        .font(.system(size: 13, weight: .semibold, design: .monospaced))
                        .foregroundColor(.primary.opacity(0.7))
                }
            }
        }
    }

    // MARK: - Arrival Info

    private func arrivalView(location: LocationInfo) -> some View {
        VStack(alignment: .trailing, spacing: 3) {
            Text(location.regionName)
                .font(.system(size: 13, weight: .semibold))
                .foregroundColor(.primary.opacity(0.8))

            if let arrivalDate = location.arrivalDate {
                ArrivalCountdownView(arrivalDate: arrivalDate)
            }
        }
    }
}

// MARK: - Square Intensity Badge

@available(iOS 16.1, *)
struct SquareIntensityBadge: View {
    let intensity: IntensityValue

    var body: some View {
        let parts = intensity.formattedParts
        HStack(alignment: .firstTextBaseline, spacing: 0) {
            Text(parts.main)
                .font(.system(size: 38, weight: .black, design: .monospaced))
            if let sub = parts.sub {
                Text(sub)
                    .font(.system(size: 16, weight: .bold, design: .monospaced))
            }
        }
        .foregroundColor(intensity.textColor)
        .frame(width: 58, height: 58)
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
                .font(.system(size: 16, weight: .black, design: .monospaced))
                .foregroundColor(.red)
        } else {
            VStack(alignment: .trailing, spacing: 0) {
                Text("到達まで")
                    .font(.system(size: 10, weight: .semibold))
                    .foregroundColor(.primary.opacity(0.6))
                Text(arrivalDate, style: .relative)
                    .font(.system(size: 16, weight: .bold, design: .monospaced))
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
        originTime: "2024-01-01T07:10:09+09:00",
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
        originTime: "2024-01-01T12:34:56+09:00",
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
