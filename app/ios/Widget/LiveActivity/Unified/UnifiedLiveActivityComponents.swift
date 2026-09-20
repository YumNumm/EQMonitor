//
//  UnifiedLiveActivityComponents.swift
//  Widget
//
//  統合 Live Activity の共通パーツ。
//
//  Lock Screen / Dynamic Island の双方から使うため、ここでは状態を判断せず
//  渡された値を描くことに徹する。何を出すかは `UnifiedLiveActivityDisplay`。
//

import SwiftUI
import WidgetKit

// MARK: - 出所 Chip

/// 震度バッジに重ねる「予想 / 観測」Chip の配置。
///
/// どれが読みやすいかは実機の Lock Screen でしか判断できないため、
/// デザイン確認用に候補を切り替えられるようにしている。
enum IntensityChipStyle: Hashable, CaseIterable {
    /// バッジ内側の左上に重ねる
    case corner
    /// バッジ上端に帯として敷く
    case topBar
    /// バッジの外へはみ出して重ねる（Lock Screen 専用。親に余白が要る）
    case overhang
}

/// 震度の出所を示す Chip。震度色に依存しない固定配色にして、
/// どの震度の上でも読めるようにする。
@available(iOS 16.1, *)
struct IntensitySourceChip: View {
    let text: String
    let size: CGFloat

    var body: some View {
        Text(text)
            .font(AppFonts.flex(size: size, weight: .heavy))
            .foregroundStyle(.white)
            .lineLimit(1)
            .fixedSize()
            .padding(.horizontal, size * 0.36)
            .padding(.vertical, size * 0.18)
            .background(Color.black.opacity(0.78), in: Capsule())
            .overlay(Capsule().strokeBorder(.white.opacity(0.35), lineWidth: 0.5))
    }
}

// MARK: - 震度バッジ

/// 出所 Chip を重ねられる震度バッジ。
///
/// 配色は EEW（予想）と地震情報（観測）で共通の JMA 震度階級配色を使い、
/// 値の意味の違いは Chip で示す。色の意味を経路ごとに変えない。
@available(iOS 16.1, *)
struct UnifiedIntensityBadge: View {
    let intensity: IntensityValue
    let size: CGFloat
    var source: IntensitySource?
    var chipStyle: IntensityChipStyle = .corner
    var isMaximum = false
    var containerRelative = false

    private var chipText: String? {
        guard let source else { return nil }
        return isMaximum ? source.maximumLabel : source.label
    }

    private var chipSize: CGFloat { max(8, size * 0.2) }

    var body: some View {
        switch chipStyle {
        case .corner:
            badge(extraTopPadding: chipText == nil ? 0 : chipSize * 1.5)
                .overlay(alignment: .topLeading) {
                    chip.padding(size * 0.06)
                }
        case .topBar:
            VStack(spacing: 0) {
                if let chipText {
                    Text(chipText)
                        .font(AppFonts.flex(size: chipSize, weight: .heavy))
                        .foregroundStyle(.white)
                        .lineLimit(1)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, chipSize * 0.28)
                        .background(Color.black.opacity(0.78))
                }
                badge(extraTopPadding: 0)
            }
            .clipShape(shape)
        case .overhang:
            badge(extraTopPadding: 0)
                .overlay(alignment: .topLeading) {
                    chip.offset(x: -size * 0.12, y: -size * 0.16)
                }
        }
    }

    @ViewBuilder
    private var chip: some View {
        if let chipText {
            IntensitySourceChip(text: chipText, size: chipSize)
        }
    }

    private func badge(extraTopPadding: CGFloat) -> some View {
        HStack(alignment: .firstTextBaseline, spacing: 0) {
            Text(intensity.mainNumber)
                .font(AppFonts.code(size: size * 0.76, weight: .heavy))
            if let sub = intensity.subText {
                Text(sub)
                    .font(AppFonts.flex(size: size * 0.36, weight: .heavy))
            }
        }
        .foregroundStyle(intensity.textColor)
        .lineLimit(1)
        .minimumScaleFactor(0.7)
        .padding(.horizontal, size * 0.08)
        .padding(.top, extraTopPadding)
        .frame(minWidth: size, minHeight: size + extraTopPadding)
        .background(intensity.backgroundColor)
        .clipShape(shape)
    }

    private var shape: AnyShape {
        containerRelative
            ? AnyShape(ContainerRelativeShape())
            : AnyShape(RoundedRectangle(cornerRadius: size * 0.2, style: .continuous))
    }
}

/// 震度が未発表のときに置くプレースホルダ。バッジごと消すと
/// レイアウトが跳ねるため、枠と「-」を残して欠測であることを示す。
@available(iOS 16.1, *)
struct UnifiedIntensityPlaceholder: View {
    let size: CGFloat
    var label: String?

    var body: some View {
        VStack(spacing: 0) {
            if let label {
                Text(label)
                    .font(AppFonts.flex(size: max(8, size * 0.2), weight: .heavy))
                    .foregroundStyle(.white.opacity(0.7))
            }
            Text("-")
                .font(AppFonts.code(size: size * 0.62, weight: .heavy))
                .foregroundStyle(.white.opacity(0.7))
        }
        .frame(minWidth: size, minHeight: size)
        .background(
            RoundedRectangle(cornerRadius: size * 0.2, style: .continuous)
                .strokeBorder(.white.opacity(0.35), lineWidth: 1)
        )
    }
}

// MARK: - 揺れレベルバッジ

/// 揺れの強さバッジ。未知の level が届いても表示が空にならないよう、
/// 判別できない場合はグレーの「?」で「揺れ検知中だが強さ不明」を示す。
@available(iOS 16.1, *)
struct UnifiedShakeLevelBadge: View {
    let level: ShakeDetectionLevel?
    let size: CGFloat

    var body: some View {
        Text(level?.shortDisplayString ?? "?")
            .font(AppFonts.code(size: size * 0.58, weight: .bold))
            .lineLimit(1)
            .minimumScaleFactor(0.6)
            .foregroundStyle(level?.textColor ?? .white)
            .frame(width: size, height: size)
            .background(
                RoundedRectangle(cornerRadius: size * 0.25, style: .continuous)
                    .fill(level?.backgroundColor ?? Color.gray)
            )
    }
}

// MARK: - ヘッダー

/// 主表示ブロックの色・種別・見出し・最大値を載せるヘッダー。
@available(iOS 16.1, *)
struct UnifiedHeaderContainer: View {
    let display: UnifiedLiveActivityDisplay
    var chipStyle: IntensityChipStyle = .corner

    private let stripeHeight: CGFloat = 8

    var body: some View {
        VStack(spacing: 0) {
            StripePattern(colors: display.stripeColors)
                .frame(height: stripeHeight)

            HStack(alignment: .center, spacing: 8) {
                VStack(alignment: .leading, spacing: 2) {
                    Text(display.typeLabel)
                        .font(AppFonts.flex(size: 11, weight: .semibold))
                        .foregroundStyle(liveActivityHeaderSecondaryTextColor)
                        .lineLimit(1)
                        .minimumScaleFactor(0.7)

                    if let headline = display.headline, !headline.isEmpty {
                        Text(headline)
                            .font(AppFonts.flex(size: 15, weight: .heavy))
                            .foregroundStyle(liveActivityHeaderPrimaryTextColor)
                            .lineLimit(1)
                            .minimumScaleFactor(0.5)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                trailingBadge
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 4)
            .background(display.headerBackgroundColor)
        }
        .clipShape(ContainerRelativeShape())
    }

    @ViewBuilder
    private var trailingBadge: some View {
        if let level = display.headerShakeLevel {
            UnifiedShakeLevelBadge(level: level, size: 34)
                .fixedSize()
        } else if let intensity = display.headerIntensity {
            UnifiedIntensityBadge(
                intensity: intensity,
                size: 30,
                source: display.intensitySource,
                chipStyle: chipStyle,
                isMaximum: true
            )
            .fixedSize()
        }
    }
}

// MARK: - 震源要素

/// M・深さの 1 行。低精度の EEW では検知手法を出して数値を出さない。
@available(iOS 16.1, *)
struct UnifiedMetricsRow: View {
    var magnitudeText: String?
    var depth: Double?
    var emphasizeMagnitude = false
    var lowAccuracyLabel: String?
    var size: CGFloat = 77.23 / 3

    var body: some View {
        if let lowAccuracyLabel {
            Text(lowAccuracyLabel)
                .font(.system(size: 12, weight: .bold))
                .foregroundStyle(.white)
                .fixedSize()
                .padding(.horizontal, 7)
                .padding(.vertical, 3)
                .overlay(ContainerRelativeShape().strokeBorder(.white.opacity(0.5)))
        } else {
            HStack(alignment: .firstTextBaseline, spacing: 10) {
                if let magnitudeText {
                    Text(magnitudeText)
                        .font(AppFonts.code(size: size, weight: .bold))
                        .foregroundStyle(emphasizeMagnitude ? Color(rgb: 0xFF6E6E) : .white)
                }
                if let depth {
                    HStack(alignment: .firstTextBaseline, spacing: size * 0.074) {
                        Text("深さ")
                            .font(AppFonts.code(size: size * 0.44, weight: .medium))
                            .foregroundStyle(.white.opacity(0.8))
                        Text(String(Int(depth)))
                            .font(AppFonts.code(size: size, weight: .bold))
                            .foregroundStyle(.white)
                        Text("km")
                            .font(AppFonts.code(size: size * 0.44, weight: .medium))
                            .foregroundStyle(.white.opacity(0.8))
                    }
                }
            }
            .lineLimit(1)
            .minimumScaleFactor(0.7)
        }
    }
}

// MARK: - 現在地

/// 現在地の地域名と、その地域の震度 / 揺れレベル。
/// 欠損値から場所や震度を推測しない。
@available(iOS 16.1, *)
struct UnifiedLocationPanel: View {
    let display: UnifiedLiveActivityDisplay
    var chipStyle: IntensityChipStyle = .corner
    var badgeSize: CGFloat = 56

    var body: some View {
        HStack(alignment: .bottom, spacing: 6) {
            VStack(alignment: .leading, spacing: 7) {
                VStack(alignment: .leading, spacing: 2) {
                    Text(label)
                        .font(AppFonts.flex(size: 9, weight: .bold))
                        .foregroundStyle(.white.opacity(0.8))
                    if let name = display.locationName {
                        Text(name)
                            .font(AppFonts.flex(size: 11, weight: .heavy))
                            .foregroundStyle(.white)
                            .lineLimit(2)
                            .minimumScaleFactor(0.8)
                    }
                }
                if let arrivalDate = display.eew?.display.countdownArrivalDate,
                   display.primary == .eew {
                    EewArrivalView(arrivalDate: arrivalDate)
                }
            }

            badge
        }
        .padding(.leading, 7)
        .overlay(alignment: .leading) {
            Rectangle().fill(.white.opacity(0.35)).frame(width: 0.5)
        }
    }

    private var label: String {
        if display.primary == .eew, display.eew?.display.locationNotice == .warning {
            return "現在地に警報"
        }
        return "現在地"
    }

    @ViewBuilder
    private var badge: some View {
        if let level = display.locationShakeLevel {
            UnifiedShakeLevelBadge(level: level, size: badgeSize * 0.7)
                .fixedSize()
        } else if let intensity = display.locationIntensity {
            UnifiedIntensityBadge(
                intensity: intensity,
                size: badgeSize,
                source: display.intensitySource,
                chipStyle: chipStyle
            )
            .fixedSize()
        }
    }
}

// MARK: - EEW 帯

/// 主表示が地震情報のときに、直前まで出ていた EEW を 1 行で添える。
@available(iOS 16.1, *)
struct UnifiedEewStrip: View {
    let eew: UnifiedEew

    var body: some View {
        HStack(spacing: 6) {
            Text(eew.display.headerLabel)
                .font(AppFonts.flex(size: 10, weight: .bold))
                .foregroundStyle(.white.opacity(0.75))
                .lineLimit(1)
                .minimumScaleFactor(0.7)

            Spacer(minLength: 4)

            if let intensity = eew.intensityValue, eew.isCanceled != true {
                HStack(spacing: 3) {
                    Text("予想最大")
                        .font(AppFonts.flex(size: 9, weight: .bold))
                        .foregroundStyle(.white.opacity(0.7))
                    Text(intensity.displayString)
                        .font(AppFonts.code(size: 11, weight: .heavy))
                        .foregroundStyle(intensity.textColor)
                        .padding(.horizontal, 5)
                        .padding(.vertical, 1)
                        .background(
                            intensity.backgroundColor,
                            in: RoundedRectangle(cornerRadius: 4, style: .continuous)
                        )
                }
                .fixedSize()
            }
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 2)
        .background(
            Color.white.opacity(0.08),
            in: RoundedRectangle(cornerRadius: 8, style: .continuous)
        )
    }
}
