import SwiftUI

@available(iOS 16.1, *)
struct LiveActivityArrivalView: View {
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

