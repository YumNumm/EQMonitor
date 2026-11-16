import SwiftUI

/// Apple Watch の Smart Stack と CarPlay に出る `.small` 用の表示。
///
/// 領域が小さいため、一目で必要な「自分の場所がどうなるか」を主役にする。
/// 現在地の情報があれば予想震度と到達まで、無ければ全国の最大震度と震源を出す。
@available(iOS 16.1, *)
struct EewSmallActivityView: View {
    let state: EewContentState

    var body: some View {
        let display = state.display
        HStack(alignment: .center, spacing: 8) {
            if display.isCanceled {
                EewCanceledSymbol(size: 26)
            } else if let intensity = display.localIntensity {
                EewLocalIntensityView(intensity: intensity, size: 40)
                    .fixedSize()
            } else {
                EewMaximumIntensityView(intensity: display.maxIntensity, size: 30)
                    .fixedSize()
            }

            VStack(alignment: .leading, spacing: 1) {
                Text((state.isLocalTest ? "【テスト】" : "") + display.typeLabel)
                    .font(AppFonts.flex(size: 10, weight: .semibold))
                    .foregroundStyle(.white.opacity(0.7))
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)

                // 取消の主文は長いため、小さめにして2行へ収める
                Text(title(display))
                    .font(AppFonts.flex(size: display.isCanceled ? 12 : 14, weight: .heavy))
                    .lineLimit(2)
                    .minimumScaleFactor(0.7)
                    .modifier(EewBlinkHighlight(
                        isActive: display.locationNotice == .warning,
                        anchor: display.countdownArrivalDate,
                        trailingBleed: 10
                    ))

                if !display.isCanceled {
                    detail(display)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 6)
        .foregroundStyle(.white)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black)
    }

    /// 現在地が警報対象のときの強調色。黒地との差の合成で、塗りと文字の色を入れ替える。
    static let alertColor = Color(red: 1.0, green: 0.1, blue: 0.1)

    private func title(_ display: EewDisplay) -> String {
        if display.isCanceled {
            return EewDisplay.canceledTitle
        }
        if let notice = display.locationNotice {
            return notice.title
        }
        return display.headline(from: state.headline) ?? state.hypocenterName ?? ""
    }

    @ViewBuilder
    private func detail(_ display: EewDisplay) -> some View {
        if display.locationNotice != nil {
            if let remaining = ArrivalCountdown.remaining(until: display.countdownArrivalDate) {
                let isLocalWarning = display.locationNotice == .warning
                HStack(alignment: .firstTextBaseline, spacing: 3) {
                    Text("到達まで")
                        .font(AppFonts.flex(size: 10, weight: .bold))
                        .foregroundStyle(.white.opacity(0.8))
                        .lineLimit(1)
                        .minimumScaleFactor(0.8)
                    // 到達までが10分を超えることはないため、分1桁ぶんの幅だけ確保する
                    ArrivalCountdownText(
                        remaining: remaining,
                        size: 16,
                        color: isLocalWarning ? Self.alertColor : .white,
                        alignment: .leading,
                        placeholder: "0:00"
                    )
                    // 幅が足りないときはラベル側を縮め、数字は欠けさせない
                    .fixedSize()
                    .layoutPriority(1)
                    .modifier(EewBlinkHighlight(
                        isActive: isLocalWarning,
                        anchor: display.countdownArrivalDate,
                        horizontalPadding: 2
                    ))
                }
            } else if let hypocenterName = state.hypocenterName, !hypocenterName.isEmpty {
                Text(hypocenterName)
                    .font(AppFonts.flex(size: 11, weight: .medium))
                    .foregroundStyle(.white.opacity(0.8))
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
            }
        } else {
            EewSourceMetricsView(state: state, size: 15)
        }
    }
}

/// 文字の背景を1秒おきに点滅させ、塗りと文字の色を入れ替える。角は丸めない。
///
/// 現在地が警報対象のときだけ使う。対象外でも色を付けると、現在地に警報が出たと誤解される。
@available(iOS 16.1, *)
private struct EewBlinkHighlight: ViewModifier {
    let isActive: Bool
    let anchor: Date?
    /// カードの右端まで帯を伸ばす量。0なら文字の幅だけ塗る。
    var trailingBleed: CGFloat = 0
    var horizontalPadding: CGFloat = 4

    func body(content: Content) -> some View {
        if isActive {
            content
                // 差の合成: 赤い塗りの上では黒文字、黒地の上では赤文字になる
                .foregroundStyle(EewSmallActivityView.alertColor)
                .blendMode(.difference)
                .padding(.horizontal, horizontalPadding)
                .padding(.vertical, 1)
                .frame(maxWidth: trailingBleed > 0 ? .infinity : nil, alignment: .leading)
                .background {
                    BlinkBlock(anchor: anchor)
                        .foregroundStyle(EewSmallActivityView.alertColor)
                }
                .padding(.trailing, -trailingBleed)
        } else {
            content
        }
    }
}
