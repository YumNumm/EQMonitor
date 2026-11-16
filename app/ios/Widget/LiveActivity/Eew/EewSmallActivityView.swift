import SwiftUI

/// Apple Watch の Smart Stack と CarPlay に出る `.small` 用の表示。
///
/// 領域が小さいため、一目で必要な「自分の場所がどうなるか」を主役にする。
/// 現在地の情報があれば予想震度と到達まで、無ければ全国の最大震度と震源を出す。
@available(iOS 16.1, *)
struct EewSmallActivityView: View {
    let state: EewContentState

    /// これより狭いと 40mm / 41mm の Apple Watch。余白と震度を詰めて文字の幅を確保する。
    private static let narrowWidth: CGFloat = 170

    var body: some View {
        GeometryReader { geometry in
            content(narrow: geometry.size.width < Self.narrowWidth)
        }
        .background(EewAlertStyle.surfaceColor(for: state.display))
    }

    private func content(narrow: Bool) -> some View {
        let display = state.display
        return HStack(alignment: .center, spacing: narrow ? 6 : 8) {
            if display.isCanceled {
                EewCanceledSymbol(size: narrow ? 22 : 26)
            } else if let intensity = display.localIntensity {
                EewLocalIntensityView(intensity: intensity, size: narrow ? 34 : 40)
                    .fixedSize()
            } else {
                EewMaximumIntensityView(intensity: display.maxIntensity, size: narrow ? 26 : 30)
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
                    // 塗りを敷く警戒文は折り返さず、縮めて1行に収める
                    .lineLimit(display.locationNotice == .warning ? 1 : 2)
                    .minimumScaleFactor(0.7)
                    .modifier(EewAlertBlinkHighlight(
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
        .padding(.horizontal, narrow ? 8 : 10)
        .padding(.vertical, narrow ? 4 : 6)
        .foregroundStyle(.white)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

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
                HStack(alignment: .firstTextBaseline, spacing: 4) {
                    Text("到達まで")
                        .font(AppFonts.flex(size: 10, weight: .bold))
                        .foregroundStyle(.white.opacity(0.8))
                    ArrivalCountdownText(remaining: remaining, size: 16, color: .white, alignment: .leading)
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
