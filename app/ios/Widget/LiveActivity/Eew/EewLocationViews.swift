import SwiftUI

/// 現在地が警報対象のときの見た目。Lock Screen・Dynamic Island・スモール表示で共通に使う。
///
/// 警報でも現在地が対象外なら色を付けない。現在地に警報が出たとの誤解を避ける。
@available(iOS 16.1, *)
enum EewAlertStyle {
    /// 点滅する塗りの色。白文字が読める濃さにする
    static let fillColor = Color(red: 0.72, green: 0.0, blue: 0.0)
    /// 面全体の地色。震度バッジや塗りと同化しないよう黒へ寄せる
    static let surfaceColor = Color(red: 0.20, green: 0.0, blue: 0.0)

    /// Lock Screen・スモール表示の地色。Dynamic Island は常に黒で変えられない。
    static func surfaceColor(for display: EewDisplay) -> Color {
        display.locationNotice == .warning ? surfaceColor : .black
    }
}

/// 文字の背景を1秒おきに点滅させる。濃い赤の塗りを出したり消したりし、文字は常に白。
@available(iOS 16.1, *)
struct EewAlertBlinkHighlight: ViewModifier {
    let isActive: Bool
    /// 到達カウントダウンと秒の切り替わりをそろえるための時刻
    let anchor: Date?
    /// 文字の幅ではなく、使える幅いっぱいを塗る
    var fillsWidth = false

    func body(content: Content) -> some View {
        if isActive {
            content
                .foregroundStyle(.white)
                .padding(.horizontal, 4)
                .padding(.vertical, 1)
                .frame(maxWidth: fillsWidth ? .infinity : nil, alignment: .leading)
                .background {
                    BlinkBlock(anchor: anchor).foregroundStyle(EewAlertStyle.fillColor)
                }
        } else {
            content
        }
    }
}

@available(iOS 16.1, *)
struct EewLocationNoticeView: View {
    let notice: EewLocationNotice
    let intensity: IntensityValue?
    /// 点滅を到達カウントダウンの秒にそろえるための時刻
    var blinkAnchor: Date?

    var body: some View {
        let background: Color = switch notice {
        case .warning: Color(rgb: 0xBE0100)
        case .forecast: intensity?.backgroundColor ?? .clear
        case .weak: Color(rgb: 0xCDEEFF)
        }
        let foreground: Color = switch notice {
        case .warning: .white
        case .forecast: intensity?.textColor ?? .white
        case .weak: .black
        }
        Text(notice.title)
            .font(AppFonts.flex(size: 14, weight: .heavy))
            .foregroundStyle(foreground)
            .lineLimit(1)
            .minimumScaleFactor(0.8)
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 8)
            .padding(.vertical, 8)
            .background {
                if notice == .warning {
                    // 警報対象は塗りを1秒おきに点滅させる
                    BlinkBlock(anchor: blinkAnchor)
                        .foregroundStyle(EewAlertStyle.fillColor)
                        .clipShape(ContainerRelativeShape())
                } else {
                    ContainerRelativeShape().fill(background)
                }
            }
            .accessibilityLabel(notice == .warning ? "現在地は緊急地震速報の警報対象地域です" : notice.title)
    }
}

@available(iOS 16.1, *)
struct EewArrivalView: View {
    let arrivalDate: Date
    var size: CGFloat = 22

    var body: some View {
        if let remaining = ArrivalCountdown.remaining(until: arrivalDate) {
            VStack(alignment: .leading, spacing: 0) {
                Text("到達まで")
                    .font(AppFonts.flex(size: 10, weight: .bold))
                    .foregroundStyle(.white.opacity(0.8))
                ArrivalCountdownText(remaining: remaining, size: size, color: .white, alignment: .leading)
            }
        }
    }
}

@available(iOS 16.1, *)
struct EewLockScreenLocationView: View {
    let state: EewContentState

    var body: some View {
        HStack(alignment: .bottom, spacing: 6) {
            if state.display.localIntensity != nil,
               let remaining = ArrivalCountdown.remaining(until: state.display.countdownArrivalDate) {
                // 予想震度と到達予想がそろうときは地名を省き、カウントダウンを大きく見せる
                VStack(alignment: .leading, spacing: 0) {
                    Text("現在地\n揺れ到達まで")
                        .font(AppFonts.flex(size: 10, weight: .bold))
                        .foregroundStyle(.white.opacity(0.8))
                        .fixedSize()
                    ArrivalCountdownText(
                        remaining: remaining, size: EewLockScreenMetrics.countdownSize,
                        color: .white, alignment: .leading
                    )
                }
            } else {
                VStack(alignment: .leading, spacing: 4) {
                    VStack(alignment: .leading, spacing: 2) {
                        Text(state.display.locationNotice == .warning ? "現在地に警報" : "現在地")
                            .font(AppFonts.flex(size: 10, weight: .bold))
                            .foregroundStyle(.white.opacity(0.8))
                        if let regionName = state.location?.displayRegionName, !regionName.isEmpty {
                            Text(regionName)
                                .font(AppFonts.flex(size: 10, weight: .heavy))
                                .lineLimit(2)
                                .minimumScaleFactor(0.8)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                    }
                    if let arrivalDate = state.display.countdownArrivalDate {
                        EewArrivalView(arrivalDate: arrivalDate, size: 18)
                    }
                }
            }
            if let intensity = state.display.localIntensity {
                EewLocalIntensityView(intensity: intensity, size: 48)
                    .fixedSize()
            }
        }
        .foregroundStyle(.white)
        .padding(.leading, 7)
        .overlay(alignment: .leading) {
            Rectangle().fill(.white.opacity(0.35)).frame(width: 0.5)
        }
    }
}
