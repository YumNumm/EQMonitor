import SwiftUI

@available(iOS 16.1, *)
struct LiveActivityShakeBadge: View {
    let level: ShakeDetectionLevel
    let size: CGFloat

    var body: some View {
        Text(level.shortDisplayString)
            .font(AppFonts.code(size: size * 0.58, weight: .bold))
            .lineLimit(1)
            .minimumScaleFactor(0.6)
            .foregroundStyle(level.textColor)
            .frame(width: size, height: size)
            .background(
                RoundedRectangle(cornerRadius: size * 0.25, style: .continuous)
                    .fill(level.backgroundColor)
            )
    }
}
