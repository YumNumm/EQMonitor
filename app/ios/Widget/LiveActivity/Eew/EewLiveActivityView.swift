//
//  EewLiveActivityView.swift
//  Widget
//
//  緊急地震速報用のLive Activity表示
//

import SwiftUI
import WidgetKit

// MARK: - EEW用カラー定義

private let eewSecondaryTextColor: Color = liveActivitySecondaryTextColor
private let eewHeaderSecondaryTextColor: Color = liveActivityHeaderSecondaryTextColor

// MARK: - EEW用スタイル

@available(iOS 16.1, *)
extension View {
    func eewLabelStyle(_ variant: LiveActivityLabelStyle.Variant = .primary) -> some View {
        liveActivityLabelStyle(variant)
    }
}

// MARK: - Header Container

@available(iOS 16.1, *)
struct HeaderContainer: View {
    let display: EewDisplay
    let headline: String?

    private let stripeHeight: CGFloat = 8

    var body: some View {
        VStack(spacing: 0) {
            stripePattern
                .frame(height: stripeHeight)

            HStack(alignment: .center, spacing: 8) {
                VStack(alignment: .leading, spacing: 2) {
                    // 「緊急地震速報(警報|予報|取消) 第N報」または「… 最終 第N報」
                    Text(display.headerLabel)
                        .font(
                            .system(
                                size: 12,
                                weight: .semibold,
                                design: .monospaced
                            )
                        )
                        .foregroundColor(eewHeaderSecondaryTextColor)
                        .lineLimit(1)
                        .minimumScaleFactor(0.7)

                    // headline: "XXXで地震" / 警報時 "XX YYで強い揺れ" / 取消時 "取り消されました"
                    if let headline = display.headerHeadline(from: headline) {
                        Text(headline)
                            .font(.system(size: 15, weight: .heavy))
                            .foregroundColor(.primary)
                            .lineLimit(1)
                            .minimumScaleFactor(0.5)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                // 主要動到達までのカウントダウン / 到達済み
                if let remaining = ArrivalCountdown.remaining(until: display.countdownArrivalDate) {
                    VStack(alignment: .trailing, spacing: 0) {
                        Text("主要動到達まで")
                            .eewLabelStyle(.header)
                        ArrivalCountdownText(
                            remaining: remaining,
                            size: 20,
                            color: .white
                        )
                    }
                } else if display.countdownArrivalDate != nil {
                    Text("主要動到達済み")
                        .font(.system(size: 14, weight: .heavy))
                        .foregroundColor(.white)
                }
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(backgroundColor)
        }
        .clipShape(ContainerRelativeShape())
    }

    private var stripePattern: StripePattern {
        if display.isCanceled {
            return StripePattern(colors: [
                Color(red: 0.5, green: 0.5, blue: 0.5),
                Color(red: 0.25, green: 0.25, blue: 0.25),
            ])
        }
        return StripePattern(isWarning: display.isWarning)
    }

    private var backgroundColor: Color {
        if display.isCanceled {
            return Color(red: 0.4, green: 0.4, blue: 0.4)
        } else if display.isWarning {
            return Color(red: 0.7, green: 0.1, blue: 0.1)
        } else {
            return Color(red: 0.8, green: 0.4, blue: 0.05)
        }
    }
}


@available(iOS 16.1, *)
struct EewLockScreenView: View {
    let state: EewContentState

    private let standardMargin: CGFloat = 14

    var body: some View {
        let display = state.display
        VStack(spacing: 0) {
            HeaderContainer(display: display, headline: state.headline)
                .padding(.horizontal, standardMargin)
                .padding(.top, standardMargin)
                .padding(.bottom, display.isCanceled ? 8 : 4)

            contentView
                .padding(.horizontal, standardMargin)
                .padding(.bottom, standardMargin)
        }
    }

    @ViewBuilder
    private var contentView: some View {
        if state.display.isCanceled {
            canceledContentView
        } else {
            earthquakeContentView
        }
    }

    // MARK: - 取消報

    /// 取消報では震源・予想震度・到達予想がすべて無効。
    /// 主文はヘッダーの見出し行に出しているため、ここは値を出していない理由だけを添える。
    private var canceledContentView: some View {
        HStack(alignment: .center, spacing: 8) {
            EewCanceledSymbol(size: 24)
            Text(EewDisplay.canceledDescription)
                .font(.system(size: 13, weight: .semibold))
                .foregroundColor(eewSecondaryTextColor)
                .lineLimit(2)
                .minimumScaleFactor(0.8)
            Spacer(minLength: 0)
        }
    }

    // MARK: - 通常報

    private var earthquakeContentView: some View {
        HStack(alignment: .bottom, spacing: 10) {
            if let intensity = state.display.maxIntensity {
                VStack(spacing: 2) {
                    Text("最大震度")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(eewSecondaryTextColor)
                    SquareIntensityBadge(
                        intensity: intensity,
                        size: .normal
                    )
                }
            }

            uncanceledDetailsView
                .frame(maxWidth: .infinity, alignment: .leading)

            if let intensity = state.display.forecastIntensity,
               let regionName = state.location?.regionName,
               !regionName.isEmpty {
                forecastIntensityView(
                    regionName: regionName,
                    intensity: intensity
                )
            }
        }
    }

    /// 取消報以外で表示する震源・規模・時刻。取消報ではこれらの値がすべて無効なため出さない。
    private var uncanceledDetailsView: some View {
        VStack(alignment: .leading, spacing: 4) {
            if let hypocenterName = state.hypocenterName {
                HStack(alignment: .firstTextBaseline, spacing: 4) {
                    Text(
                        state.isPlum == true || state.isLevel == true ? "検知観測点" : "震源地"
                    )
                    .eewLabelStyle()
                    Text(hypocenterName)
                        .font(.system(size: 16, weight: .heavy))
                        .foregroundColor(.primary)
                        .lineLimit(1)
                        .minimumScaleFactor(0.75)
                }
            }

            // PLUM法/レベル法/1点検知の場合は特別な表示
            if state.isPlum == true {
                detectionMethodLabel("PLUM法による検知")
            } else if state.isLevel == true {
                detectionMethodLabel("レベル法による検知")
            } else if state.isOnePoint == true {
                detectionMethodLabel("低精度の緊急地震速報")
            } else {
                HStack(spacing: 14) {
                    if let magnitude = state.magnitude {
                        HStack(alignment: .firstTextBaseline, spacing: 0) {
                            Text("M")
                                .eewLabelStyle()
                            Text(String(format: "%.1f", magnitude))
                                .font(
                                    .system(
                                        size: 18,
                                        weight: .bold,
                                        design: .monospaced
                                    )
                                )
                                .tracking(-2.5)
                                .foregroundColor(.primary)
                        }
                    }
                    if let depth = state.depth {
                        depthView(depth: Int(depth))
                    }
                }
            }

            // 発生/検知時刻
            if let date = state.timeDate {
                HStack(alignment: .firstTextBaseline, spacing: 4) {
                    Text(state.timeLabel)
                        .eewLabelStyle()
                    Text(JSTDateFormat.monthDay(date))
                        .font(
                            .system(
                                size: 12,
                                weight: .semibold,
                                design: .monospaced
                            )
                        )
                        .foregroundColor(.primary)
                        .tracking(-1)
                    Text(JSTDateFormat.timeWithSeconds(date))
                        .font(
                            .system(
                                size: 14,
                                weight: .bold,
                                design: .monospaced
                            )
                        )
                        .foregroundColor(.primary)
                        .tracking(-1)
                }
            }
        }
    }

    // 検知方法ラベル（PLUM法/レベル法/1点検知）
    private func detectionMethodLabel(_ text: String) -> some View {
        Text(text)
            .font(.system(size: 14, weight: .bold, design: .monospaced))
            .lineLimit(1)
    }

    // 深さ表示（数値を大きく）
    private func depthView(depth: Int) -> some View {
        HStack(alignment: .firstTextBaseline, spacing: 0) {
            Text("深さ")
                .eewLabelStyle()
            Text("\(depth)")
                .font(.system(size: 18, weight: .bold, design: .monospaced))
                .tracking(-1)
                .foregroundColor(.primary)
            Text(" km")
                .font(.system(size: 10, weight: .medium))
                .foregroundColor(eewSecondaryTextColor)
        }
    }

    // MARK: - 現在地の予想震度

    private func forecastIntensityView(
        regionName: String,
        intensity: IntensityValue
    ) -> some View {
        VStack(spacing: 2) {
            HStack(spacing: 2) {
                Image(systemName: "location.fill")
                    .font(.system(size: 9, weight: .semibold))
                    .foregroundColor(eewSecondaryTextColor)
                    .symbolEffect(.pulse)
                Text(regionName)
                    .font(.system(size: 10, weight: .semibold))
                    .foregroundColor(.primary)
                    .lineLimit(1)
                    .minimumScaleFactor(0.75)
            }
            SquareIntensityBadge(intensity: intensity, size: .normal)
        }
    }
}

// MARK: - Square Intensity Badge

@available(iOS 16.1, *)
struct SquareIntensityBadge: View {
    enum Size {
        case normal
        case small
        case compact  // 横長でコンパクト

        var badgeSize: CGFloat {
            switch self {
            case .normal: return 50
            case .small: return 38
            case .compact: return 24
            }
        }

        var mainFontSize: CGFloat {
            switch self {
            case .normal: return 38
            case .small: return 28
            case .compact: return 18
            }
        }

        var subFontSize: CGFloat {
            switch self {
            case .normal: return 16
            case .small: return 12
            case .compact: return 10
            }
        }

        var cornerRadius: CGFloat {
            switch self {
            case .normal: return 12
            case .small: return 10
            case .compact: return 8
            }
        }

        var horizontalPadding: CGFloat {
            switch self {
            case .normal, .small: return 0
            case .compact: return 6
            }
        }
    }

    let intensity: IntensityValue
    var size: Size = .normal

    var body: some View {
        let parts = intensity.formattedParts
        HStack(alignment: .firstTextBaseline, spacing: 0) {
            Text(parts.main)
                .font(
                    .system(
                        size: size.mainFontSize,
                        weight: .bold,
                        design: .monospaced
                    )
                )
            if let sub = parts.sub {
                Text(sub)
                    .font(.system(size: size.subFontSize, weight: .heavy))
            }
        }
        .foregroundColor(intensity.textColor)
        .frame(height: size.badgeSize)
        .frame(minWidth: size.badgeSize)
        .padding(.horizontal, size.horizontalPadding)
        .background(intensity.backgroundColor)
        .clipShape(
            RoundedRectangle(
                cornerRadius: size.cornerRadius,
                style: .continuous
            )
        )
    }
}

// MARK: - Preview

struct EewLiveActivityWidget_Previews: PreviewProvider {
    static let attributes = EewLiveActivityAttributes(eventId: "20240101123456")

    static var previews: some View {
        // Lock Screen
        attributes
            .previewContext(.noto32, viewKind: .content)
            .previewDisplayName("Lock Screen - 警報")

        attributes
            .previewContext(.ibarakiForecast, viewKind: .content)
            .previewDisplayName("Lock Screen - 予報")

        attributes
            .previewContext(.notoFinal, viewKind: .content)
            .previewDisplayName("Lock Screen - 最終報")

        attributes
            .previewContext(.plum, viewKind: .content)
            .previewDisplayName("Lock Screen - PLUM法")

        attributes
            .previewContext(.levelMethod, viewKind: .content)
            .previewDisplayName("Lock Screen - レベル法")

        attributes
            .previewContext(.onePoint, viewKind: .content)
            .previewDisplayName("Lock Screen - 1点検知")

        attributes
            .previewContext(.canceled, viewKind: .content)
            .previewDisplayName("Lock Screen - 取消")

        attributes
            .previewContext(.canceledWithStaleValues, viewKind: .content)
            .previewDisplayName("Lock Screen - 取消(値が残存)")

        attributes
            .previewContext(.canceledWithStaleValues, viewKind: .dynamicIsland(.expanded))
            .previewDisplayName("Expanded - 取消(値が残存)")

        attributes
            .previewContext(.countingDown(), viewKind: .content)
            .previewDisplayName("Lock Screen - 到達カウントダウン")

        // Dynamic Island - Compact
        attributes
            .previewContext(.countingDown(), viewKind: .dynamicIsland(.compact))
            .previewDisplayName("Compact - 到達カウントダウン")

        attributes
            .previewContext(.noto32, viewKind: .dynamicIsland(.compact))
            .previewDisplayName("Compact - 警報")

        attributes
            .previewContext(.ibarakiForecast, viewKind: .dynamicIsland(.compact))
            .previewDisplayName("Compact - 予報")

        attributes
            .previewContext(.canceled, viewKind: .dynamicIsland(.compact))
            .previewDisplayName("Compact - 取消")

        // Dynamic Island - Expanded
        attributes
            .previewContext(.countingDown(), viewKind: .dynamicIsland(.expanded))
            .previewDisplayName("Expanded - 到達カウントダウン")

        attributes
            .previewContext(.noto32, viewKind: .dynamicIsland(.expanded))
            .previewDisplayName("Expanded - 警報")

        attributes
            .previewContext(.ibarakiForecast, viewKind: .dynamicIsland(.expanded))
            .previewDisplayName("Expanded - 予報")

        attributes
            .previewContext(.notoFinal, viewKind: .dynamicIsland(.expanded))
            .previewDisplayName("Expanded - 最終報(到達予想なし)")

        attributes
            .previewContext(.plum, viewKind: .dynamicIsland(.expanded))
            .previewDisplayName("Expanded - PLUM法")

        attributes
            .previewContext(.canceled, viewKind: .dynamicIsland(.expanded))
            .previewDisplayName("Expanded - 取消")

        // Dynamic Island - Minimal
        attributes
            .previewContext(.noto32, viewKind: .dynamicIsland(.minimal))
            .previewDisplayName("Minimal - 警報")

        attributes
            .previewContext(.ibarakiForecast, viewKind: .dynamicIsland(.minimal))
            .previewDisplayName("Minimal - 予報")
    }
}
