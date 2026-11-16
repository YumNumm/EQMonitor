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
                    // 枠で囲む警戒文は折り返さず、縮めて1行に収める
                    .lineLimit(display.locationNotice == .warning ? 1 : 2)
                    .minimumScaleFactor(0.7)
                    .modifier(EewBlinkHighlight(
                        isActive: display.locationNotice == .warning,
                        anchor: display.countdownArrivalDate,
                        fillsWidth: true
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

    /// 現在地が警報対象のときの枠線の色
    static let alertColor = Color(red: 1.0, green: 0.1, blue: 0.1)
    /// 点滅する塗りの色。白文字が読める濃さにする
    static let alertFillColor = Color(red: 0.72, green: 0.0, blue: 0.0)

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
                        color: .white,
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

/// 文字の背景を1秒おきに点滅させる。濃い赤の塗りと、赤い枠線だけの黒地を交互に出す。
/// 文字は常に白。角は丸めない。
///
/// 現在地が警報対象のときだけ使う。対象外でも色を付けると、現在地に警報が出たと誤解される。
@available(iOS 16.1, *)
private struct EewBlinkHighlight: ViewModifier {
    let isActive: Bool
    let anchor: Date?
    /// 文字の幅ではなく、使える幅いっぱいを塗る
    var fillsWidth = false
    var horizontalPadding: CGFloat = 4

    func body(content: Content) -> some View {
        if isActive {
            content
                .foregroundStyle(.white)
                .padding(.horizontal, horizontalPadding)
                .padding(.vertical, 1)
                .frame(maxWidth: fillsWidth ? .infinity : nil, alignment: .leading)
                .background {
                    BlinkBlock(anchor: anchor)
                        .foregroundStyle(EewSmallActivityView.alertFillColor)
                }
                .overlay {
                    Rectangle().strokeBorder(EewSmallActivityView.alertColor, lineWidth: 1)
                }
        } else {
            content
        }
    }
}
