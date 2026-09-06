//
//  EewLiveActivityView.swift
//  Widget
//

import SwiftUI
import WidgetKit

// MARK: - EEW用カラー定義

private let eewHeaderPrimaryTextColor: Color = liveActivityHeaderPrimaryTextColor
private let eewHeaderSecondaryTextColor: Color = liveActivityHeaderSecondaryTextColor

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
                        .font(AppFonts.flex(size: 11, weight: .semibold))
                        .foregroundColor(eewHeaderSecondaryTextColor)
                        .lineLimit(1)
                        .minimumScaleFactor(0.7)

                    // headline: "XXXで地震" / 警報時 "XX YYで強い揺れ" / 取消時 "取り消されました"
                    if let headline = display.headerHeadline(from: headline) {
                        Text(headline)
                            .font(AppFonts.flex(size: 15, weight: .heavy))
                            .foregroundColor(eewHeaderPrimaryTextColor)
                            .lineLimit(1)
                            .minimumScaleFactor(0.5)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                if !display.isCanceled {
                    EewMaximumIntensityView(intensity: display.maxIntensity, size: 32)
                        .fixedSize()
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

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HeaderContainer(
                display: state.display,
                headline: state.display.headline(from: state.headline) ?? state.hypocenterName
            )

            if state.display.isCanceled {
                HStack(spacing: 8) {
                    EewCanceledSymbol(size: 24)
                    Text(EewDisplay.canceledDescription)
                        .font(AppFonts.flex(size: 12, weight: .semibold))
                        .foregroundStyle(.white.opacity(0.8))
                        .fixedSize(horizontal: false, vertical: true)
                }
            } else {
                HStack(alignment: .bottom, spacing: 8) {
                    VStack(alignment: .leading, spacing: 8) {
                        if let date = state.timeDate {
                            Text("\(state.timeLabel)  \(JSTDateFormat.monthDay(date)) \(JSTDateFormat.timeWithSeconds(date))")
                                .font(AppFonts.code(size: 10, weight: .medium))
                                .foregroundStyle(.white.opacity(0.8))
                                .lineLimit(1)
                                .minimumScaleFactor(0.8)
                        }
                        EewSourceMetricsView(state: state)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)

                    if state.display.usesLocalIntensity || state.display.locationNotice == .warning {
                        EewLockScreenLocationView(state: state)
                    }
                }

                if state.display.showsDeepHypocenterIntensityNotice {
                    Text(EewDisplay.deepHypocenterIntensityNotice)
                        .font(AppFonts.flex(size: 11, weight: .medium))
                        .foregroundStyle(.white.opacity(0.75))
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
        }
        .padding(12)
        .foregroundStyle(.white)
        .background(.black)
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
            .previewContext(.deepHypocenter, viewKind: .content)
            .previewDisplayName("Lock Screen - 深発(予想震度なし)")

        attributes
            .previewContext(.deepHypocenter, viewKind: .dynamicIsland(.expanded))
            .previewDisplayName("Expanded - 深発(予想震度なし)")

        attributes
            .previewContext(.deepHypocenter, viewKind: .dynamicIsland(.compact))
            .previewDisplayName("Compact - 深発(予想震度なし)")

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

        attributes
            .previewContext(
                .countingDown(secondsUntilArrival: -5),
                viewKind: .content
            )
            .previewDisplayName("Lock Screen - 到達済み")

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
