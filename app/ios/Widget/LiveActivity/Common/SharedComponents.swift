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

// MARK: - 文字サイズの固定

@available(iOS 16.1, *)
extension View {
    /// Live Activity では Dynamic Type に追従させず、標準の大きさに固定する。
    ///
    /// Lock Screen は高さ160ptが上限、Dynamic Island は領域が決まっており、文字が大きくなると
    /// 収まらず切り取られる。`Font.custom(_:size:)` は既定で Dynamic Type に追従するため、
    /// 各表示の根元でこれを付ける。
    func liveActivityFixedTypeSize() -> some View {
        dynamicTypeSize(.large)
    }
}

// MARK: - 主要動到達カウントダウン

/// 到達までの残り時間。iOS 18 以降は 0.1 秒単位（`8.5秒`、1分以上は `1:15.3`、到達後は `0秒`）、
/// それより前は `M:SS`。
@available(iOS 16.1, *)
struct ArrivalCountdownText: View {
    let remaining: ClosedRange<Date>
    let size: CGFloat
    var color: Color = .primary
    var alignment: TextAlignment = .trailing
    /// `M:SS` で出すときに幅の確保に使う文字列。表示しうる最長の桁数に合わせる。
    var placeholder = "00:00"
    /// 0.1 秒の桁を出すか。分1桁ぶんの幅しか無い場所では収まらないため切る。
    var showsTenths = true

    @Environment(\.isLuminanceReduced) private var isLuminanceReduced

    var body: some View {
        // 常時表示では描き直しが間引かれる。止まった 0.1 秒の桁を見せないよう秒単位にする
        if #available(iOS 18.0, *), showsTenths, !isLuminanceReduced {
            // タイマー文字は横いっぱいに広がろうとするため、同じフォントの placeholder で
            // 幅を確保して overlay で重ねる。placeholder も字形の置き換えを受ける
            Text(tenthsPlaceholder)
                .font(AppFonts.countdown(size: size))
                .hidden()
                .overlay(alignment: overlayAlignment) {
                    Group {
                        if remaining.lowerBound < remaining.upperBound {
                            Text(
                                .currentDate,
                                format: .timer(
                                    countingDownIn: remaining.lowerBound..<remaining.upperBound,
                                    maxPrecision: .milliseconds(100)
                                )
                            )
                        } else {
                            Text(Self.arrivedText)
                        }
                    }
                    .font(AppFonts.countdown(size: size))
                    .lineLimit(1)
                    .multilineTextAlignment(alignment)
                    .foregroundColor(color)
                }
        } else {
            // Workaround: timerInterval は横いっぱいに広がろうとするため、
            // 同じフォントの placeholder で幅を確保して overlay で重ねる
            // See: https://stackoverflow.com/questions/66210592/widgetkit-timer-text-style-expands-it-to-fill-the-width-instead-of-taking-spa
            Text(placeholder)
                .font(font)
                .hidden()
                .overlay(alignment: overlayAlignment) {
                    Text(timerInterval: remaining, countsDown: true)
                        .font(font)
                        .monospacedDigit()
                        .multilineTextAlignment(alignment)
                        .foregroundColor(color)
                        .contentTransition(.numericText(countsDown: true))
                }
        }
    }

    /// フォントの置き換えで `0秒` になる。「秒」を文字として渡すと、描画時にシステムの
    /// 日本語フォントへ差し替えられ、幅が足りず `…` になる
    private static let arrivedText = "0:00.0"

    /// 描いた時点の残りで出しうる最長の文字列。更新が来ないまま残りが増えることはない。
    /// 1分未満は `11.1秒`、1分以上は `1:11.1`（到達までが10分を超えることはない）。
    private var tenthsPlaceholder: String {
        remaining.upperBound.timeIntervalSince(remaining.lowerBound) < 60 ? "0:11.1" : "1:11.1"
    }

    private var overlayAlignment: Alignment {
        alignment == .leading ? .leading : .trailing
    }

    private var font: Font {
        AppFonts.code(size: size, weight: .bold)
    }
}

/// PLUM 法で到達時刻が発表されないときに、カウントダウンの代わりに出す文言。
@available(iOS 16.1, *)
struct EewImminentArrivalText: View {
    let size: CGFloat
    /// 幅の限られる場所では2行に分ける
    var twoLines = false

    var body: some View {
        Text(twoLines ? "すぐに\n到達" : EewDisplay.imminentArrivalTitle)
            .font(AppFonts.flex(size: size, weight: .heavy))
            .foregroundStyle(.white)
            .multilineTextAlignment(.trailing)
            .fixedSize()
            .accessibilityLabel(EewDisplay.imminentArrivalTitle)
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

// MARK: - 点滅

/// 枠いっぱいの塗りを点滅させる。iOS 18 以降は 0.5 秒おき、それより前は 1 秒おき。
///
/// Live Activity はタイマーやアニメーションを自前で回せないため、システムが描き直す時刻の文字を使う。
/// 数字の一部を塗りつぶし、残りを空にした専用フォントで描き、点滅させたい桁だけを枠に合わせて切り抜く。
/// - iOS 18 以降: 0.1 秒単位のストップウォッチ文字と `EQBlinkHalf.ttf`（0〜4 が塗り、5〜9 が空）。
///   末尾の 0.1 秒の桁を切り抜く。
/// - それより前: 毎秒のタイマー文字と `EQBlink.ttf`（偶数が塗り、奇数が空）。秒の1桁目を切り抜く。
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
                if #available(iOS 18.0, *) {
                    // 文字を右詰めで描き、末尾の1文字（0.1 秒の桁）を枠へ合わせる。
                    Color.clear.overlay(alignment: .trailing) {
                        Text(
                            .currentDate,
                            format: .stopwatch(
                                startingAt: Self.start(anchor: anchor),
                                showsHours: false,
                                maxPrecision: .milliseconds(100)
                            )
                        )
                        // 1文字を枠より1割広くし、枠を文字の中央へ置く。同じ幅だと字送りの丸めで
                        // 隣の桁の塗りが端に細く見える
                        .font(AppFonts.blinkHalf(size: width * 1.1))
                        .lineLimit(1)
                        .multilineTextAlignment(.trailing)
                        // 「MM:SS.S」の7文字が収まる幅を渡す
                        .frame(width: width * 9, alignment: .trailing)
                        .offset(x: width * 0.05)
                    }
                    .clipped()
                } else {
                    // 文字は左詰めで描かれる。「M:SS」の4文字目（秒の1桁目）を枠へ合わせる。
                    Color.clear.overlay(alignment: .leading) {
                        Text(Self.end(anchor: anchor), style: .timer)
                            .font(AppFonts.blink(size: width * 1.1))
                            .lineLimit(1)
                            // fixedSize を付けるとタイマー文字が描かれなくなるため、幅を明示する
                            .frame(width: width * 5, alignment: .leading)
                            .offset(x: -width * 3.35)
                    }
                    .clipped()
                }
            }
            .accessibilityHidden(true)
        }
    }

    /// ストップウォッチ文字の開始時刻。基準時刻から整数秒ずらし、塗りの出はじめを
    /// 到達カウントダウンの秒の切り替わりにそろえる。描画時に必ず経過済みになるよう約1分前へ置く。
    static func start(anchor: Date?, now: Date = Date()) -> Date {
        let anchor = anchor ?? now
        let secondsUntilAnchor = anchor.timeIntervalSince(now).rounded(.up)
        return anchor.addingTimeInterval(-secondsUntilAnchor - 60)
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
