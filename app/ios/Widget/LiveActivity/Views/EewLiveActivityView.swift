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
                : [Color.orange, Color(red: 0.5, green: 0.25, blue: 0.0)]

            Canvas { context, size in
                // 十分な余裕を持って描画
                let totalWidth = size.width * 2
                var x: CGFloat = -size.height * 2

                while x < totalWidth {
                    var path = Path()
                    path.move(to: CGPoint(x: x, y: size.height))
                    path.addLine(to: CGPoint(x: x + stripeWidth, y: size.height))
                    path.addLine(to: CGPoint(x: x + size.height + stripeWidth, y: 0))
                    path.addLine(to: CGPoint(x: x + size.height, y: 0))
                    path.closeSubpath()

                    let colorIndex = Int((x + size.height * 2) / stripeWidth) % 2
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
                // ストライプライン（ヘッダー上部、内側）
                StripeLine(
                    isWarning: state.isWarning ?? false,
                    height: 5
                )
                .padding(.horizontal, standardMargin)
                .padding(.top, standardMargin)

                // ヘッダーコンテンツ
                HStack(alignment: .center) {
                    // タイトル（白色、大きく）
                    Text(headerTitle)
                        .font(.system(size: 17, weight: .heavy))
                        .foregroundColor(.white)

                    Spacer()

                    // Serial Number
                    if let serialNo = state.serialNo {
                        HStack(alignment: .firstTextBaseline, spacing: 0) {
                            Text("#")
                                .font(.system(size: 12, weight: .medium, design: .monospaced))
                                .foregroundColor(.white.opacity(0.7))
                            Text("\(serialNo)")
                                .font(.system(size: 15, weight: .bold, design: .monospaced))
                                .foregroundColor(.white)
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
                .padding(.top, 6)
                .padding(.bottom, 6)
            }
            .background(headerBackgroundColor)

            // メインコンテンツ
            HStack(alignment: .top, spacing: 10) {
                // 現在地予想震度表示（正方形）
                VStack(spacing: 2) {
                    forecastIntensityView
                    // 発生時刻（予想震度の下）
                    if let originTime = state.originTime,
                       let date = ISO8601DateFormatter().date(from: originTime) {
                        Text(date, style: .time)
                            .font(.system(size: 11, weight: .semibold, design: .monospaced))
                            .foregroundColor(.primary.opacity(0.6))
                    }
                }

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

                    // M, 深さ
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

    private var headerBackgroundColor: Color {
        if let isWarning = state.isWarning, isWarning {
            return Color(red: 0.7, green: 0.1, blue: 0.1)
        } else {
            return Color(red: 0.8, green: 0.4, blue: 0.05)
        }
    }

    // MARK: - Forecast Intensity (現在地予想震度)

    private var forecastIntensityView: some View {
        Group {
            if let location = state.location,
               let intensity = location.forecastIntensityValue {
                VStack(spacing: 2) {
                    Text("予想震度")
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundColor(.primary.opacity(0.7))
                    SquareIntensityBadge(intensity: intensity)
                }
            } else if let intensity = state.intensityValue {
                VStack(spacing: 2) {
                    Text("最大震度")
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundColor(.primary.opacity(0.7))
                    SquareIntensityBadge(intensity: intensity)
                }
            }
        }
    }

    // MARK: - Details

    private var detailsView: some View {
        HStack(spacing: 12) {
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
                depthView(depth: depth)
            }
        }
    }

    // 深さ表示
    private func depthView(depth: Int) -> some View {
        HStack(alignment: .firstTextBaseline, spacing: 1) {
            Text("深さ")
                .font(.system(size: 10, weight: .medium))
                .foregroundColor(.primary.opacity(0.5))

            if depth == 0 {
                // ごく浅い
                Text("ごく浅い")
                    .font(.system(size: 15, weight: .bold))
                    .foregroundColor(.primary)
            } else if depth >= 700 {
                // 700km以上
                Text("\(depth)")
                    .font(.system(size: 17, weight: .bold, design: .monospaced))
                    .foregroundColor(.primary)
                Text("km以上")
                    .font(.system(size: 10, weight: .medium))
                    .foregroundColor(.primary.opacity(0.5))
            } else {
                // 通常
                Text("\(depth)")
                    .font(.system(size: 17, weight: .bold, design: .monospaced))
                    .foregroundColor(.primary)
                Text("km")
                    .font(.system(size: 10, weight: .medium))
                    .foregroundColor(.primary.opacity(0.5))
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
                .font(.system(size: 36, weight: .black, design: .monospaced))
            if let sub = parts.sub {
                // 強弱の文字を太く
                Text(sub)
                    .font(.system(size: 15, weight: .heavy))
            }
        }
        .foregroundColor(intensity.textColor)
        .frame(width: 56, height: 56)
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

@available(iOS 17.0, *)
#Preview("EEW Lock Screen - Shallow") {
    EewLockScreenView(state: LiveActivityContentState(
        eventId: "20240101123456",
        type: "eew",
        hypocenterName: "熊本県熊本地方",
        magnitude: 5.0,
        depth: 0,
        originTime: "2024-01-01T12:00:00+09:00",
        maxIntensity: "5+",
        serialNo: 3,
        isFinal: false,
        isWarning: true,
        level: nil,
        detectedAt: nil,
        location: LocationInfo(
            regionName: "熊本県",
            forecastIntensity: "5+",
            forecastLpgmIntensity: nil,
            arrivalTime: nil,
            intensity: nil
        )
    ))
}

@available(iOS 17.0, *)
#Preview("EEW Lock Screen - Deep") {
    EewLockScreenView(state: LiveActivityContentState(
        eventId: "20240101123456",
        type: "eew",
        hypocenterName: "小笠原諸島西方沖",
        magnitude: 8.1,
        depth: 700,
        originTime: "2024-01-01T12:00:00+09:00",
        maxIntensity: "4",
        serialNo: 5,
        isFinal: false,
        isWarning: false,
        level: nil,
        detectedAt: nil,
        location: nil
    ))
}
