//
//  EewLiveActivityView.swift
//  Widget
//
//  緊急地震速報用のLive Activity表示
//

import SwiftUI
import WidgetKit

// MARK: - Header Container (HIG準拠: インセットコンテナ形状)
// "When separating a block of content, place it in an inset container shape"

@available(iOS 16.1, *)
struct HeaderContainer: View {
    let isWarning: Bool
    let headline: String?

    private let stripeHeight: CGFloat = 8

    var body: some View {
        VStack(spacing: 0) {
            // 上部: ストライプパターン
            StripePattern(isWarning: isWarning)
                .frame(height: stripeHeight)

            // 下部: ヘッダーコンテンツ
            VStack(alignment: .leading, spacing: 2) {
                // 緊急地震速報(予報) or 緊急地震速報(警報)
                Text(eewTypeLabel)
                    .font(.system(size: 11, weight: .semibold))
                    .foregroundColor(.white.opacity(0.85))

                // headline: "XXXで地震" または警報時 "XX YYで強い揺れ"
                if let headline = headline, !headline.isEmpty {
                    Text(headline)
                        .font(.system(size: 15, weight: .heavy))
                        .foregroundColor(.white)
                        .lineLimit(2)
                        .minimumScaleFactor(0.8)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(backgroundColor)
        }
        // HIG: ContainerRelativeShapeで角丸をWidgetに合わせる
        .clipShape(ContainerRelativeShape())
    }

    private var eewTypeLabel: String {
        isWarning ? "緊急地震速報(警報)" : "緊急地震速報(予報)"
    }

    private var backgroundColor: Color {
        if isWarning {
            return Color(red: 0.7, green: 0.1, blue: 0.1)
        } else {
            return Color(red: 0.8, green: 0.4, blue: 0.05)
        }
    }
}

// MARK: - Stripe Pattern

@available(iOS 16.1, *)
struct StripePattern: View {
    let isWarning: Bool

    var body: some View {
        GeometryReader { geometry in
            let stripeWidth: CGFloat = 8
            let colors = isWarning
            ? [Color.red, Color.black]
            : [Color.orange, Color(red: 0.5, green: 0.25, blue: 0.0)]

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

                    let colorIndex = Int((x + size.height) / stripeWidth) % 2
                    context.fill(path, with: .color(colors[abs(colorIndex)]))
                    x += stripeWidth
                }
            }
        }
    }
}

@available(iOS 16.1, *)
struct EewLockScreenView: View {
    let state: LiveActivityContentState

    // HIG: The standard layout margin for Live Activities on the Lock Screen is 14 points.
    private let standardMargin: CGFloat = 14
    // 薄い文字色を統一
    private let secondaryTextColor: Color = .primary.opacity(0.55)

    var body: some View {
        VStack(spacing: 0) {
            HeaderContainer(
                isWarning: state.isWarning ?? false,
                headline: state.headline
            )
            .padding(.horizontal, standardMargin)
            .padding(.top, standardMargin)
            .padding(.bottom, 4)

            // メインコンテンツ
            HStack(alignment: .bottom, spacing: 10) {
                // 左側: 予想最大震度
                maxIntensityView

                // 中央: 震源情報
                VStack(alignment: .leading, spacing: 2) {
                    // 震源地ラベル
                    Text("震源地")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(secondaryTextColor)

                    // 震源地名（大きく）
                    if let name = state.hypocenterName {
                        Text(name)
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.primary)
                            .lineLimit(1)
                    }

                    // M, 深さ, 発生時刻（縦に並べる）
                    detailsView
                }

                Spacer()

                // 右側: 現在地到達情報 + 予想震度
                if let location = state.location {
                    arrivalView(location: location)
                }
            }
            .padding(.horizontal, standardMargin)
            .padding(.bottom, standardMargin)
            .overlay(alignment: .bottomTrailing) {
                // serialNo を右下に表示
                if let serialNo = state.serialNo {
                    HStack(alignment: .firstTextBaseline, spacing: 0) {
                        Text("#")
                            .font(.system(size: 10, weight: .medium, design: .monospaced))
                            .foregroundColor(secondaryTextColor)
                        Text("\(serialNo)")
                            .font(.system(size: 12, weight: .bold, design: .monospaced))
                            .foregroundColor(secondaryTextColor)
                    }
                    .padding(.trailing, standardMargin)
                    .padding(.bottom, 2)
                }
            }
        }
    }

    // MARK: - Date Formatter

    private func formatDateTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd HH:mm:ss"
        formatter.locale = Locale(identifier: "ja_JP")
        return formatter.string(from: date)
    }

    // MARK: - Max Intensity (予想最大震度)

    private var maxIntensityView: some View {
        Group {
            if let intensity = state.intensityValue {
                VStack(spacing: 2) {
                    Text("最大震度")
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundColor(secondaryTextColor)
                    SquareIntensityBadge(intensity: intensity)
                }
            }
        }
    }

    // MARK: - Details (M, 深さ, 発生時刻を縦に)

    private var detailsView: some View {
        VStack(alignment: .leading, spacing: 3) {
            // M, 深さ（横並び）
            HStack(spacing: 14) {
                // マグニチュード（文字間隔を詰める、数値を太く）
                if let magnitude = state.magnitude {
                    HStack(alignment: .firstTextBaseline, spacing: 0) {
                        Text("M")
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundColor(secondaryTextColor)
                        Text(String(format: "%.1f", magnitude))
                            .font(.system(size: 19, weight: .black, design: .monospaced))
                            .tracking(-4) // 文字間隔を詰める
                            .foregroundColor(.primary)
                    }
                }

                // 深さ（数値を大きく）
                if let depth = state.depth {
                    depthView(depth: depth)
                }
            }

            // 発生時刻（M, 深さの下）
            if let originTime = state.originTime,
               let date = ISO8601DateFormatter().date(from: originTime) {
                HStack(spacing: 4) {
                    Text("発生")
                        .font(.system(size: 10, weight: .medium))
                        .foregroundColor(secondaryTextColor)
                    Text(formatDateTime(date))
                        .font(.system(size: 12, weight: .semibold, design: .monospaced))
                        .foregroundColor(secondaryTextColor)
                }
            }
        }
    }

    // 深さ表示（数値を大きく）
    private func depthView(depth: Int) -> some View {
        HStack(alignment: .firstTextBaseline, spacing: 1) {
            Text("深さ")
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(secondaryTextColor)

            if depth == 0 {
                // ごく浅い
                Text("ごく浅い")
                    .font(.system(size: 17, weight: .black))
                    .foregroundColor(.primary)
            } else if depth >= 700 {
                // 700km以上
                Text("\(depth)")
                    .font(.system(size: 19, weight: .black, design: .monospaced))
                    .tracking(-1)
                    .foregroundColor(.primary)
                Text("km以上")
                    .font(.system(size: 10, weight: .medium))
                    .foregroundColor(secondaryTextColor)
            } else {
                // 通常
                Text("\(depth)")
                    .font(.system(size: 19, weight: .black, design: .monospaced))
                    .tracking(-1)
                    .foregroundColor(.primary)
                Text("km")
                    .font(.system(size: 10, weight: .medium))
                    .foregroundColor(secondaryTextColor)
            }
        }
    }

    // MARK: - Arrival Info

    private func arrivalView(location: LocationInfo) -> some View {
        VStack(alignment: .trailing, spacing: 4) {
            // 現在地名
            Text(location.regionName)
                .font(.system(size: 13, weight: .semibold))
                .foregroundColor(.primary.opacity(0.85))

            // カウントダウンと予想震度を横並び
            HStack(alignment: .bottom, spacing: 8) {
                // 到達カウントダウン
                if let arrivalDate = location.arrivalDate {
                    ArrivalCountdownView(arrivalDate: arrivalDate)
                }

                // 現在地予想震度
                if let intensity = location.forecastIntensityValue {
                    VStack(spacing: 2) {
                        Text("予想震度")
                            .font(.system(size: 10, weight: .semibold))
                            .foregroundColor(secondaryTextColor)
                        SquareIntensityBadge(intensity: intensity, size: .small)
                    }
                }
            }
        }
    }
}

// MARK: - Square Intensity Badge

@available(iOS 16.1, *)
struct SquareIntensityBadge: View {
    enum Size {
        case normal
        case small

        var badgeSize: CGFloat {
            switch self {
            case .normal: return 56
            case .small: return 44
            }
        }

        var mainFontSize: CGFloat {
            switch self {
            case .normal: return 36
            case .small: return 28
            }
        }

        var subFontSize: CGFloat {
            switch self {
            case .normal: return 15
            case .small: return 11
            }
        }

        // HIG準拠: 連続的な角丸（continuous corner radius）
        // iOSの標準的なコンポーネントでは、サイズに応じた角丸を使用
        var cornerRadius: CGFloat {
            switch self {
            case .normal: return 12
            case .small: return 10
            }
        }
    }

    let intensity: IntensityValue
    var size: Size = .normal

    var body: some View {
        let parts = intensity.formattedParts
        HStack(alignment: .firstTextBaseline, spacing: 0) {
            Text(parts.main)
                .font(.system(size: size.mainFontSize, weight: .black, design: .monospaced))
            if let sub = parts.sub {
                // 強弱の文字を太く
                Text(sub)
                    .font(.system(size: size.subFontSize, weight: .heavy))
            }
        }
        .foregroundColor(intensity.textColor)
        .frame(width: size.badgeSize, height: size.badgeSize)
        .background(intensity.backgroundColor)
        // HIG準拠: RoundedRectangleのcontinuousスタイルでスムーズな角丸
        .clipShape(RoundedRectangle(cornerRadius: size.cornerRadius, style: .continuous))
    }
}

// MARK: - Arrival Countdown View

@available(iOS 16.1, *)
struct ArrivalCountdownView: View {
    let arrivalDate: Date
    private let secondaryTextColor: Color = .primary.opacity(0.55)

    var body: some View {

        VStack(alignment: .trailing, spacing: 0) {
            Text("到達まで")
                .font(.system(size: 10, weight: .semibold))
                .foregroundColor(secondaryTextColor)
            Text(timerInterval: Date()...arrivalDate, countsDown: true)
                .font(.system(size: 16, weight: .bold, design: .monospaced))
                .foregroundColor(.primary)
                .multilineTextAlignment(.trailing)
        }
        .frame(alignment: .trailing)

    }
}

// MARK: - Preview

@available(iOS 17.0, *)
#Preview("EEW Lock Screen - Warning", as: .content, using: LiveActivitiesAppAttributes(eventId: "20240101123456", type: "eew")) {
    EQMonitorLiveActivityWidget()
} contentStates: {
    LiveActivityContentState(
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
        headline: "石川県能登地方で地震 石川 新潟で強い揺れ",
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
#Preview("EEW Lock Screen - Forecast", as: .content, using: LiveActivitiesAppAttributes(eventId: "20240101123456", type: "eew")) {
    EQMonitorLiveActivityWidget()
} contentStates: {
    LiveActivityContentState(
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
        headline: "茨城県沖で地震",
        level: nil,
        detectedAt: nil,
        location: nil
    )
}

@available(iOS 17.0, *)
#Preview("EEW Lock Screen - Warning Final", as: .content, using: LiveActivitiesAppAttributes(eventId: "20240101123456", type: "eew")) {
    EQMonitorLiveActivityWidget()
} contentStates: {
    LiveActivityContentState(
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
        headline: "能登半島沖で地震 石川県加賀で強い揺れ",
        level: nil,
        detectedAt: nil,
        location: LocationInfo(
            regionName: "石川県加賀",
            forecastIntensity: "6-",
            forecastLpgmIntensity: "3",
            arrivalTime: ISO8601DateFormatter().string(from: Date().addingTimeInterval(-5)),
            intensity: nil
        )
    )
}

@available(iOS 17.0, *)
#Preview("EEW Lock Screen - Shallow", as: .content, using: LiveActivitiesAppAttributes(eventId: "20240101123456", type: "eew")) {
    EQMonitorLiveActivityWidget()
} contentStates: {
    LiveActivityContentState(
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
        headline: "熊本県熊本地方で地震 熊本で強い揺れ",
        level: nil,
        detectedAt: nil,
        location: LocationInfo(
            regionName: "熊本県",
            forecastIntensity: "5+",
            forecastLpgmIntensity: nil,
            arrivalTime: nil,
            intensity: nil
        )
    )
}

@available(iOS 17.0, *)
#Preview("EEW Lock Screen - Deep", as: .content, using: LiveActivitiesAppAttributes(eventId: "20240101123456", type: "eew")) {
    EQMonitorLiveActivityWidget()
} contentStates: {
    LiveActivityContentState(
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
        headline: "小笠原諸島西方沖で地震",
        level: nil,
        detectedAt: nil,
        location: nil
    )
}

@available(iOS 17.0, *)
#Preview("EEW Lock Screen - Long Headline", as: .content, using: LiveActivitiesAppAttributes(eventId: "20240101123456", type: "eew")) {
    EQMonitorLiveActivityWidget()
} contentStates: {
    LiveActivityContentState(
        eventId: "20240101123456",
        type: "eew",
        hypocenterName: "三重県南東沖",
        magnitude: 8.5,
        depth: 30,
        originTime: "2024-01-01T12:00:00+09:00",
        maxIntensity: "6+",
        serialNo: 8,
        isFinal: false,
        isWarning: true,
        headline: "三重県南東沖で地震 北陸 甲信 東海 東北 関東 近畿で強い揺れ",
        level: nil,
        detectedAt: nil,
        location: LocationInfo(
            regionName: "東京都23区",
            forecastIntensity: "5+",
            forecastLpgmIntensity: "3",
            arrivalTime: ISO8601DateFormatter().string(from: Date().addingTimeInterval(60)),
            intensity: nil
        )
    )
}

@available(iOS 17.0, *)
#Preview("EEW Lock Screen - No Headline", as: .content, using: LiveActivitiesAppAttributes(eventId: "20240101123456", type: "eew")) {
    EQMonitorLiveActivityWidget()
} contentStates: {
    LiveActivityContentState(
        eventId: "20240101123456",
        type: "eew",
        hypocenterName: "千葉県東方沖",
        magnitude: 4.0,
        depth: 50,
        originTime: "2024-01-01T12:00:00+09:00",
        maxIntensity: "3",
        serialNo: 1,
        isFinal: false,
        isWarning: false,
        headline: nil,
        level: nil,
        detectedAt: nil,
        location: nil
    )
}
