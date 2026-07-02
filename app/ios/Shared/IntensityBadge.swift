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
    /// 角丸比率。アプリの JmaIntensityIcon は 0.25（size / 4）
    var cornerRatio: CGFloat = 0.22
    var weight: Font.Weight = .heavy

    /// サブ表示が「弱以上」など2文字以上なら小さめ＆縮小許可でバッジ内に収める
    private var isLongSub: Bool { (intensity.sub?.count ?? 0) >= 2 }

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: size * cornerRatio, style: .continuous)
                .fill(backgroundColor)
                .frame(width: size, height: size)

            HStack(alignment: .lastTextBaseline, spacing: 1) {
                Text(intensity.main)
                    .font(.system(size: size * 0.5, weight: weight).monospacedDigit())
                    .foregroundStyle(textColor)

                if let sub = intensity.sub {
                    Text(sub)
                        .font(.system(size: isLongSub ? size * 0.18 : size * 0.27, weight: .bold))
                        .foregroundStyle(textColor)
                        .baselineOffset(-1)
                        .lineLimit(1)
                        .minimumScaleFactor(0.6)
                }
            }
            .padding(.horizontal, 2)
            .frame(width: size, height: size)
        }
    }
}
