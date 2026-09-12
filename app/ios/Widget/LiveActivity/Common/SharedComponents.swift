import SwiftUI

@available(iOS 16.1, *)
struct ArrivalCountdownText: View {
    let remaining: ClosedRange<Date>
    let size: CGFloat
    var color: Color = .primary

    var body: some View {
        // Workaround: timerInterval は横いっぱいに広がろうとするため、
        // 同じフォントの placeholder で幅を確保して overlay で重ねる
        // See: https://stackoverflow.com/questions/66210592/widgetkit-timer-text-style-expands-it-to-fill-the-width-instead-of-taking-spa
        Text("00:00")
            .font(font)
            .hidden()
            .overlay(alignment: .trailing) {
                Text(timerInterval: remaining, countsDown: true)
                    .font(font)
                    .monospacedDigit()
                    .foregroundColor(color)
                    .contentTransition(.numericText(countsDown: true))
            }
    }

    private var font: Font {
        AppFonts.code(size: size, weight: .bold)
    }
}
