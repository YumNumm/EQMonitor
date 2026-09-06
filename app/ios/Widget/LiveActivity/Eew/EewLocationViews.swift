import SwiftUI

@available(iOS 16.1, *)
struct EewLocationNoticeView: View {
    let notice: EewLocationNotice
    let intensity: IntensityValue?

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
            .background(
                background,
                in: RoundedRectangle(cornerRadius: 10)
            )
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
                ArrivalCountdownText(remaining: remaining, size: size, color: .white)
            }
        }
    }
}

@available(iOS 16.1, *)
struct EewLockScreenLocationView: View {
    let state: EewContentState

    var body: some View {
        HStack(alignment: .bottom, spacing: 6) {
            VStack(alignment: .leading, spacing: 7) {
                VStack(alignment: .leading, spacing: 2) {
                    Text(state.display.locationNotice == .warning ? "現在地に警報" : "現在地")
                        .font(AppFonts.flex(size: 9, weight: .bold))
                        .foregroundStyle(.white.opacity(0.8))
                    if let regionName = state.location?.regionName, !regionName.isEmpty {
                        Text(regionName)
                            .font(AppFonts.flex(size: 10, weight: .heavy))
                            .lineLimit(2)
                    }
                }
                if let arrivalDate = state.display.countdownArrivalDate {
                    EewArrivalView(arrivalDate: arrivalDate)
                }
            }
            if let intensity = state.display.localIntensity {
                EewLocalIntensityView(intensity: intensity, size: 56)
            }
        }
        .foregroundStyle(.white)
        .padding(.leading, 7)
        .overlay(alignment: .leading) {
            Rectangle().fill(.white.opacity(0.35)).frame(width: 0.5)
        }
    }
}
