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
    let isWarning: Bool
    let isCanceled: Bool
    let headline: String?
    let serialNo: Int?
    let isFinal: Bool
    let arrivalDate: Date?

    private let stripeHeight: CGFloat = 8

    var body: some View {
        VStack(spacing: 0) {
            stripePattern
                .frame(height: stripeHeight)

            HStack(alignment: .center, spacing: 8) {
                VStack(alignment: .leading, spacing: 2) {
                // 「緊急地震速報(警報|予報|取消) 第N報」または「… 最終 第N報」
                    Text(eewTypeLabelWithSerial)
                        .font(
                            .system(
                                size: 12,
                                weight: .semibold,
                                design: .monospaced
                            )
                        )
                        .foregroundColor(eewHeaderSecondaryTextColor)

                    // headline: "XXXで地震" または警報時 "XX YYで強い揺れ"
                    if let headline = headline, !headline.isEmpty, !isCanceled {
                        Text(headline)
                            .font(.system(size: 15, weight: .heavy))
                            .foregroundColor(.primary)
                            .lineLimit(1)
                            .minimumScaleFactor(0.5)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                // 主要動到達までのカウントダウン / 到達済み
                if let remaining = ArrivalCountdown.remaining(until: arrivalDate) {
                    VStack(alignment: .trailing, spacing: 0) {
                        Text("主要動到達まで")
                            .eewLabelStyle(.header)
                        // Workaround: countsDownの時に、横いっぱいに広がろうとするのを防ぐ
                        // See: https://stackoverflow.com/questions/66210592/widgetkit-timer-text-style-expands-it-to-fill-the-width-instead-of-taking-spa
                        Text("00:00")
                            .font(
                                .system(
                                    size: 18,
                                    weight: .black,
                                    design: .monospaced
                                )
                            )
                            .tracking(-0.5)
                            .hidden()
                            .overlay(alignment: .trailing) {
                                Text(timerInterval: remaining, countsDown: true)
                                    .contentTransition(.numericText(countsDown: true))
                                    .font(.system(size: 18, weight: .black))
                                    .foregroundColor(.white)
                                    .monospacedDigit()
                                    .tracking(-0.5)
                            }
                    }
                } else if arrivalDate != nil {
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
        if isCanceled {
            return StripePattern(colors: [
                Color(red: 0.5, green: 0.5, blue: 0.5),
                Color(red: 0.25, green: 0.25, blue: 0.25),
            ])
        }
        return StripePattern(isWarning: isWarning)
    }

    private var eewTypeLabelWithSerial: String {
        let typeLabel: String
        if isCanceled {
            typeLabel = "緊急地震速報(取消)"
        } else {
            typeLabel = isWarning ? "緊急地震速報(警報)" : "緊急地震速報(予報)"
        }
        if let serialNo = serialNo, serialNo > 0 {
            if isFinal {
                return "\(typeLabel) 最終 第\(serialNo)報"
            } else {
                return "\(typeLabel) 第\(serialNo)報"
            }
        }
        return typeLabel
    }

    private var backgroundColor: Color {
        if isCanceled {
            return Color(red: 0.4, green: 0.4, blue: 0.4)
        } else if isWarning {
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
        VStack(spacing: 0) {
            HeaderContainer(
                isWarning: state.isWarning ?? false,
                isCanceled: state.isCanceledReport,
                headline: state.headline,
                serialNo: state.serialNo,
                isFinal: state.isFinal ?? false,
                // 取消報では到達予想は無効。カウントダウンを出すと誤情報になる。
                arrivalDate: state.isCanceledReport ? nil : state.location?.arrivalDate
            )
            .padding(.horizontal, standardMargin)
            .padding(.top, standardMargin)
            .padding(.bottom, 4)

            // メインコンテンツ
            HStack(alignment: .bottom, spacing: 10) {
                // 左側: 最大震度（正方形）。取消報では予想震度自体が無効
                if !state.isCanceledReport, let intensity = state.intensityValue {
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

                detailsView
                .frame(maxWidth: .infinity, alignment: .leading)

                if !state.isCanceledReport,
                   let intensity = state.location?.forecastIntensityValue,
                   let regionName = state.location?.regionName {
                    forecastIntensityView(regionName: regionName, intensity: intensity)
                }
            }
            .padding(.horizontal, standardMargin)
            .padding(.bottom, standardMargin)
        }
    }

    // MARK: - Details (震源地, M, 深さ, 発生時刻)

    private var detailsView: some View {
        VStack(alignment: .leading, spacing: 4) {
            if state.isCanceledReport {
                Text("緊急地震速報は取り消されました")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.primary)
                    .lineLimit(2)
                    .minimumScaleFactor(0.75)
            } else {
                uncanceledDetailsView
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

        // Dynamic Island - Compact
        attributes
            .previewContext(.noto32, viewKind: .dynamicIsland(.compact))
            .previewDisplayName("Compact - 警報")

        attributes
            .previewContext(.ibarakiForecast, viewKind: .dynamicIsland(.compact))
            .previewDisplayName("Compact - 予報")

        // Dynamic Island - Expanded
        attributes
            .previewContext(.noto32, viewKind: .dynamicIsland(.expanded))
            .previewDisplayName("Expanded - 警報")

        attributes
            .previewContext(.ibarakiForecast, viewKind: .dynamicIsland(.expanded))
            .previewDisplayName("Expanded - 予報")

        // Dynamic Island - Minimal
        attributes
            .previewContext(.noto32, viewKind: .dynamicIsland(.minimal))
            .previewDisplayName("Minimal - 警報")

        attributes
            .previewContext(.ibarakiForecast, viewKind: .dynamicIsland(.minimal))
            .previewDisplayName("Minimal - 予報")
    }
}
