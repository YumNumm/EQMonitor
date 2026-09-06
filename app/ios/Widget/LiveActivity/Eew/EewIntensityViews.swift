import SwiftUI

/// 最大震度は現在地の色付きバッジと混同させない。未発表でもMAXと「-」を残す。
@available(iOS 16.1, *)
struct EewMaximumIntensityView: View {
    let intensity: IntensityValue?
    let size: CGFloat

    var body: some View {
        let appearance = IntensityBadgeAppearance(intensity: intensity)
        Group {
            if let sub = appearance.sub {
                HStack(alignment: .bottom, spacing: 0) {
                    Text(appearance.main)
                        .font(AppFonts.code(size: size, weight: .heavy))
                    VStack(alignment: .leading, spacing: 0) {
                        Text("MAX")
                            .font(AppFonts.code(size: max(7, size * 0.28), weight: .heavy))
                        Text(sub)
                            .font(AppFonts.flex(size: size * 0.45, weight: .heavy))
                    }
                    .padding(.bottom, size * 0.12)
                }
            } else {
                VStack(alignment: .leading, spacing: -size * 0.12) {
                    Text("MAX")
                        .font(AppFonts.code(size: max(7, size * 0.28), weight: .heavy))
                    Text(appearance.main)
                        .font(AppFonts.code(size: size, weight: .heavy))
                }
            }
        }
        .foregroundStyle(.white)
        .lineLimit(1)
        .minimumScaleFactor(0.7)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("最大予想震度 \(intensity?.displayString ?? "未発表")")
    }
}

@available(iOS 16.1, *)
struct EewLocalIntensityView: View {
    let intensity: IntensityValue
    let size: CGFloat

    var body: some View {
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
        .frame(minWidth: size, minHeight: size)
        .background(intensity.backgroundColor, in: RoundedRectangle(cornerRadius: size * 0.2))
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("現在地の予想震度 \(intensity.displayString)")
    }
}
