//
//  IntensityBadge.swift
//  Shared (WidgetExtension / AppIntentExtension)
//
//  震度バッジ。EarthquakeWidgetView から共有ソースへ移動した。
//

import SwiftUI

/// 震度バッジの表示内容。
///
/// 予想最大震度が未発表（nil）の報でもバッジを消さないための型。
/// 消すとレイアウトが崩れるうえ、「震度 0 が発表された」のか
/// 「まだ発表されていない」のかを読み手が区別できなくなる。
struct IntensityBadgeAppearance {
    let main: String
    let sub: String?
    let backgroundColor: Color
    let textColor: Color
}

extension IntensityBadgeAppearance {
    /// 予想最大震度が未発表のときの表示。灰色地に「-」を置く。
    static let unavailable = IntensityBadgeAppearance(
        main: "-",
        sub: nil,
        backgroundColor: Color(rgb: 0x757575),
        textColor: .white
    )

    init(intensity: IntensityValue?) {
        guard let intensity else {
            self = .unavailable
            return
        }
        let parts = intensity.formattedParts
        self.init(
            main: parts.main,
            sub: parts.sub,
            backgroundColor: intensity.backgroundColor,
            textColor: intensity.textColor
        )
    }
}

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
