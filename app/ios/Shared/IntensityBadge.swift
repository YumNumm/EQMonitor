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
    /// バッジ寸法に対する主表示の文字サイズ比。
    /// 「不明」のように数字以外を描くときだけ呼び出し側で下げる。
    var mainFontScale: CGFloat?

    var body: some View {
        HStack(alignment: .lastTextBaseline, spacing: 0) {
            Text(intensity.main)
                .font(AppFonts.code(size: size * (mainFontScale ?? 0.62), weight: .bold))
            if let sub = intensity.sub {
                Text(sub)
                    .font(AppFonts.code(size: size * 0.30, weight: .bold))
            }
        }
        .minimumScaleFactor(0.5)
        .lineLimit(1)
        .foregroundStyle(textColor)
        .padding(.horizontal, size * 0.08)
        // 未入電（「5弱以上」等）はサブ文字が長く正方形に収まらない。
        // 高さだけ固定し、幅は最小 size として横方向に伸ばす
        // （固定幅にすると背景の外へ文字がはみ出す）。
        .frame(height: size)
        .frame(minWidth: size)
        .background(
            RoundedRectangle(cornerRadius: size * cornerRatio, style: .continuous)
                .fill(backgroundColor)
        )
    }
}
