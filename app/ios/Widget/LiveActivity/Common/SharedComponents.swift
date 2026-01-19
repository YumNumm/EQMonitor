//
//  SharedComponents.swift
//  Widget
//
//  Live Activity用の共通コンポーネント
//

import SwiftUI
import WidgetKit

// MARK: - 共通カラー定義

/// 薄い文字色（ラベル、補助テキスト用）
let liveActivitySecondaryTextColor: Color = .primary.opacity(0.55)
/// ヘッダー内の薄い文字色（白ベース）
let liveActivityHeaderSecondaryTextColor: Color = .white.opacity(0.7)

// MARK: - 共通スタイル（ViewModifier）

/// ラベル用スタイル（震源地、M、深さ、発生、主要動到達まで など）
@available(iOS 16.1, *)
struct LiveActivityLabelStyle: ViewModifier {
    enum Variant {
        case primary      // メインコンテンツ内のラベル
        case header       // ヘッダー内のラベル（白ベース）
    }

    let variant: Variant

    func body(content: Content) -> some View {
        content
            .font(.system(size: 10, weight: .bold))
            .foregroundColor(variant == .header ? liveActivityHeaderSecondaryTextColor : liveActivitySecondaryTextColor)
    }
}

@available(iOS 16.1, *)
extension View {
    /// Live Activity用ラベルスタイルを適用
    func liveActivityLabelStyle(_ variant: LiveActivityLabelStyle.Variant = .primary) -> some View {
        modifier(LiveActivityLabelStyle(variant: variant))
    }
}

// MARK: - Stripe Pattern

@available(iOS 16.1, *)
struct StripePattern: View {
    let colors: [Color]

    init(colors: [Color]) {
        self.colors = colors
    }

    /// EEW用の便利イニシャライザ
    init(isWarning: Bool) {
        self.colors = isWarning
            ? [Color.red, Color.black]
            : [Color.orange, Color(red: 0.5, green: 0.25, blue: 0.0)]
    }

    var body: some View {
        GeometryReader { geometry in
            let stripeWidth: CGFloat = 8

            Canvas { context, size in
                let totalWidth = size.width + size.height * 2
                var x: CGFloat = -size.height

                while x < totalWidth {
                    var path = Path()
                    path.move(to: CGPoint(x: x, y: size.height))
                    path
                        .addLine(
                            to: CGPoint(x: x + stripeWidth, y: size.height)
                        )
                    path
                        .addLine(
                            to: CGPoint(x: x + size.height + stripeWidth, y: 0)
                        )
                    path.addLine(to: CGPoint(x: x + size.height, y: 0))
                    path.closeSubpath()

                    let colorIndex = Int((x + size.height) / stripeWidth) % 2
                    let color = colors.count > abs(colorIndex) ? colors[abs(colorIndex)] : colors[0]
                    context.fill(path, with: .color(color))
                    x += stripeWidth
                }
            }
        }
    }
}
