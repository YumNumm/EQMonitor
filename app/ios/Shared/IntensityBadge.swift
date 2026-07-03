//
//  IntensityBadge.swift
//  Shared (WidgetExtension / AppIntentExtension)
//
//  震度バッジ。EarthquakeWidgetView から共有ソースへ移動した。
//

import SwiftUI

struct IntensityBadge: View {
    let intensity: (main: String, sub: String?)
    let backgroundColor: Color
    let textColor: Color
    var size: CGFloat = 40
    /// 角丸比率。アプリの JmaIntensityIcon に準拠（size / 4 = 25%）
    var cornerRatio: CGFloat = 0.25
    var weight: Font.Weight = .bold

    var body: some View {
        HStack(alignment: .lastTextBaseline, spacing: 0) {
            Text(intensity.main)
                .font(AppFonts.code(size: size * 0.62, weight: .bold))
            if let sub = intensity.sub {
                Text(sub)
                    .font(AppFonts.code(size: size * 0.30, weight: .bold))
            }
        }
        .minimumScaleFactor(0.5)
        .lineLimit(1)
        .foregroundStyle(textColor)
        .frame(width: size, height: size)
        .background(
            RoundedRectangle(cornerRadius: size * cornerRatio, style: .continuous)
                .fill(backgroundColor)
        )
    }
}
