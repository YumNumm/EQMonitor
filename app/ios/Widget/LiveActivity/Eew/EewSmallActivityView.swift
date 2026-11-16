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
        .background(Self.backgroundColor(for: display))
    }

    /// 背景色に混ぜる基調色の割合。残りは黒。
    /// 震度バッジ（5強の橙・6弱の赤など）と同化しないよう、黒へ寄せて暗くする。
    static let backgroundTintStrength: Double = 0.45

    /// 警報は橙、現在地が警報対象なら赤、予報と取消は黒。
    /// Lock Screen のヘッダー（警報=赤、予報=橙）とは意味づけが異なる。
    static func backgroundColor(for display: EewDisplay) -> Color {
        let strength = backgroundTintStrength
        guard !display.isCanceled else { return .black }
        if display.locationNotice == .warning {
            return Color(red: 0.75 * strength, green: 0.0, blue: 0.0)
        }
        if display.isWarning {
            return Color(red: 0.90 * strength, green: 0.38 * strength, blue: 0.0)
        }
        return .black
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
