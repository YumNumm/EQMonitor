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
/// ヘッダー内の主要な文字色。ヘッダー背景は常に濃色のため、外観に依らず白で固定する
let liveActivityHeaderPrimaryTextColor: Color = .white
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

// MARK: - 主要動到達カウントダウン

@available(iOS 16.1, *)
struct ArrivalCountdownText: View {
    let remaining: ClosedRange<Date>
    let size: CGFloat
    var color: Color = .primary
    var alignment: TextAlignment = .trailing
    /// 幅の確保に使う文字列。表示しうる最長の桁数に合わせる。
    var placeholder = "00:00"

    var body: some View {
        // Workaround: timerInterval は横いっぱいに広がろうとするため、
        // 同じフォントの placeholder で幅を確保して overlay で重ねる
        // See: https://stackoverflow.com/questions/66210592/widgetkit-timer-text-style-expands-it-to-fill-the-width-instead-of-taking-spa
        Text(placeholder)
            .font(font)
            .hidden()
            .overlay(alignment: alignment == .leading ? .leading : .trailing) {
                Text(timerInterval: remaining, countsDown: true)
                    .font(font)
                    .monospacedDigit()
                    .multilineTextAlignment(alignment)
                    .foregroundColor(color)
                    .contentTransition(.numericText(countsDown: true))
            }
    }

    private var font: Font {
        AppFonts.code(size: size, weight: .bold)
    }
}

// MARK: - Stripe Pattern

@available(iOS 16.1, *)
struct StripePattern: View {
    let colors: [Color]

    init(colors: [Color]) {
        self.colors = colors
    }

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

// MARK: - 1秒おきの点滅

/// 偶数秒だけ枠いっぱいを塗る。
///
/// Live Activity はタイマーやアニメーションを自前で回せないため、システムが毎秒描き直す
/// タイマー文字を使う。`EQBlink.ttf` は偶数の数字を塗りつぶし、奇数の数字を空にした専用フォントで、
/// 秒の1桁目だけを枠に合わせて切り抜くと 1 秒おきの点滅になる。
@available(iOS 16.1, *)
struct BlinkBlock: View {
    /// 到達カウントダウンと秒の切り替わりをそろえるための基準時刻
    var anchor: Date?

    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @Environment(\.isLuminanceReduced) private var isLuminanceReduced

    var body: some View {
        if reduceMotion || isLuminanceReduced {
            // 点滅を止める設定・常時表示では塗りっぱなしにする
            Rectangle()
        } else {
            GeometryReader { geo in
                let width = max(geo.size.width, 1)
                // 文字は左詰めで描かれる。「M:SS」の4文字目（秒の1桁目）を枠へ合わせる。
                Color.clear.overlay(alignment: .leading) {
                    Text(Self.end(anchor: anchor), style: .timer)
                        .font(AppFonts.blink(size: width))
                        .lineLimit(1)
                        // fixedSize を付けるとタイマー文字が描かれなくなるため、幅を明示する
                        .frame(width: width * 4.5, alignment: .leading)
                        .offset(x: -width * 3)
                }
                .clipped()
            }
            .accessibilityHidden(true)
        }
    }

    /// 残りが常に「M:SS」の4文字になる終了時刻。基準時刻から偶数秒ずらし、秒の偶奇をそろえる。
    static func end(anchor: Date?, now: Date = Date()) -> Date {
        var end = anchor ?? now
        while end.timeIntervalSince(now) < 300 {
            end.addTimeInterval(120)
        }
        while end.timeIntervalSince(now) > 590 {
            end.addTimeInterval(-120)
        }
        return end
    }
}
