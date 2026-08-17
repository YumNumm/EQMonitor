//
//  ShakeDetectionLiveActivityView.swift
//  Widget
//
//  揺れ検知用のLive Activity表示（EEWスタイル統一版）
//

import SwiftUI
import WidgetKit

// MARK: - Header Container

@available(iOS 16.1, *)
struct ShakeDetectionHeaderContainer: View {
    let level: ShakeDetectionLevel?
    let detectedDate: Date?

    private let stripeHeight: CGFloat = 8

    private static let unknownLevelStripeColors: [Color] = [
        Color(red: 0.5, green: 0.5, blue: 0.5),
        Color(red: 0.3, green: 0.3, blue: 0.3),
    ]

    var body: some View {
        VStack(spacing: 0) {
            // ストライプパターン。level 不明でもヘッダーの高さを変えないため常に描く
            StripePattern(colors: level?.stripeColors ?? Self.unknownLevelStripeColors)
                .frame(height: stripeHeight)

            HStack(alignment: .center, spacing: 8) {
                // 左側: 「揺れ検知」ラベル + 揺れレベル説明
                VStack(alignment: .leading, spacing: 2) {
                    Text("揺れ検知")
                        .font(
                            .system(
                                size: 12,
                                weight: .semibold,
                                design: .monospaced
                            )
                        )
                        .foregroundColor(liveActivityHeaderSecondaryTextColor)

                    if let level = level {
                        Text(level.displayString)
                            .font(.system(size: 15, weight: .heavy))
                            .foregroundColor(.white)
                            .lineLimit(1)
                            .minimumScaleFactor(0.5)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                // 右側: 検知時刻
                if let detectedDate = detectedDate {
                    VStack(alignment: .trailing, spacing: 0) {
                        Text("検知時刻")
                            .liveActivityLabelStyle(.header)
                        Text(JSTDateFormat.timeWithSeconds(detectedDate))
                            .font(
                                .system(
                                    size: 14,
                                    weight: .bold,
                                    design: .monospaced
                                )
                            )
                            .foregroundColor(.white)
                    }
                }
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(backgroundColor)
        }
        .clipShape(ContainerRelativeShape())
    }

    private var backgroundColor: Color {
        level?.headerBackgroundColor ?? Color(red: 0.5, green: 0.5, blue: 0.5)
    }
}

// MARK: - Shake Level Chip

@available(iOS 16.1, *)
struct ShakeLevelChip: View {
    let level: ShakeDetectionLevel

    var body: some View {
        Text(level.displayString)
            .font(.system(size: 14, weight: .bold))
            .foregroundColor(level.textColor)
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(level.backgroundColor)
            .clipShape(Capsule())
    }
}

// MARK: - Location Summary

@available(iOS 16.1, *)
struct ShakeDetectionLocationSummaryView: View {
    let location: LocationInfo?

    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            // ロック画面の Live Activity はライト/ダーク両方で描画されるため、
            // 白固定にすると明るい背景で不可視になる。
            Image(systemName: "location.fill")
                .font(.system(size: 14, weight: .bold))
                .foregroundColor(.primary.opacity(0.86))
                .frame(width: 28, height: 28)
                .background(Color.primary.opacity(0.08))
                .clipShape(Circle())

            VStack(alignment: .leading, spacing: 2) {
                Text("観測地点")
                    .liveActivityLabelStyle()
                Text(locationText)
                    .font(.system(size: 19, weight: .heavy))
                    .foregroundColor(.primary)
                    .lineLimit(1)
                    .minimumScaleFactor(0.72)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }

    private var locationText: String {
        guard let regionName = location?.regionName, !regionName.isEmpty else {
            return "観測地点情報なし"
        }
        return "\(regionName)で検知"
    }
}

@available(iOS 16.1, *)
struct ShakeObservedIntensityPill: View {
    let intensity: Double

    var body: some View {
        VStack(alignment: .trailing, spacing: 2) {
            Text("計測震度")
                .liveActivityLabelStyle()
            Text(String(format: "%.1f", intensity))
                .font(.system(size: 18, weight: .black, design: .monospaced))
                .foregroundColor(.primary)
                .monospacedDigit()
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 7)
        .background(Color.primary.opacity(0.08))
        .clipShape(Capsule())
    }
}

// MARK: - Lock Screen View

@available(iOS 16.1, *)
struct ShakeDetectionLockScreenView: View {
    let state: ShakeDetectionContentState

    // HIG: The standard layout margin for Live Activities on the Lock Screen is 14 points.
    private let standardMargin: CGFloat = 14

    var body: some View {
        VStack(spacing: 0) {
            // ヘッダー
            ShakeDetectionHeaderContainer(
                level: state.shakeLevel,
                detectedDate: state.detectedDate
            )
            .padding(.horizontal, standardMargin)
            .padding(.top, standardMargin)
            .padding(.bottom, 8)

            // メインコンテンツ
            VStack(alignment: .leading, spacing: 10) {
                ShakeDetectionLocationSummaryView(location: state.location)

                HStack(alignment: .center, spacing: 8) {
                    if let level = state.shakeLevel {
                        ShakeLevelChip(level: level)
                    }

                    Text("端末周辺で揺れを検知しました")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(liveActivitySecondaryTextColor)
                        .lineLimit(1)
                        .minimumScaleFactor(0.75)

                    Spacer(minLength: 0)

                    if let intensity = state.location?.intensity {
                        ShakeObservedIntensityPill(intensity: intensity)
                    }
                }
            }
            .padding(.horizontal, standardMargin)
            .padding(.bottom, standardMargin)
        }
    }
}

// MARK: - Preview

@available(iOS 17.0, *)
#Preview("Shake Detection - Stronger") {
    ShakeDetectionLockScreenView(state: ShakeDetectionContentState(
        eventId: "shake-event-uuid",
        type: "shake_detection",
        level: "Stronger",
        detectedAt: ISO8601DateFormatter().string(from: Date()),
        location: LocationInfo(
            regionName: "石川県能登",
            forecastIntensity: nil,
            forecastLpgmIntensity: nil,
            arrivalTime: nil,
            intensity: nil
        )
    ))
}

@available(iOS 17.0, *)
#Preview("Shake Detection - Strong") {
    ShakeDetectionLockScreenView(state: ShakeDetectionContentState(
        eventId: "shake-event-uuid",
        type: "shake_detection",
        level: "Strong",
        detectedAt: ISO8601DateFormatter().string(from: Date()),
        location: LocationInfo(
            regionName: "東京都23区",
            forecastIntensity: nil,
            forecastLpgmIntensity: nil,
            arrivalTime: nil,
            intensity: nil
        )
    ))
}

@available(iOS 17.0, *)
#Preview("Shake Detection - Medium") {
    ShakeDetectionLockScreenView(state: ShakeDetectionContentState(
        eventId: "shake-event-uuid",
        type: "shake_detection",
        level: "Medium",
        detectedAt: ISO8601DateFormatter().string(from: Date()),
        location: LocationInfo(
            regionName: "千葉県北西部",
            forecastIntensity: nil,
            forecastLpgmIntensity: nil,
            arrivalTime: nil,
            intensity: nil
        )
    ))
}

@available(iOS 17.0, *)
#Preview("Shake Detection - Weak") {
    ShakeDetectionLockScreenView(state: ShakeDetectionContentState(
        eventId: "shake-event-uuid",
        type: "shake_detection",
        level: "Weak",
        detectedAt: ISO8601DateFormatter().string(from: Date()),
        location: LocationInfo(
            regionName: "神奈川県東部",
            forecastIntensity: nil,
            forecastLpgmIntensity: nil,
            arrivalTime: nil,
            intensity: nil
        )
    ))
}

@available(iOS 17.0, *)
#Preview("Shake Detection - Weaker") {
    ShakeDetectionLockScreenView(state: ShakeDetectionContentState(
        eventId: "shake-event-uuid",
        type: "shake_detection",
        level: "Weaker",
        detectedAt: ISO8601DateFormatter().string(from: Date()),
        location: LocationInfo(
            regionName: "埼玉県南部",
            forecastIntensity: nil,
            forecastLpgmIntensity: nil,
            arrivalTime: nil,
            intensity: nil
        )
    ))
}
