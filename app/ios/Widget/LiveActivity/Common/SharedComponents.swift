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

// MARK: - 震度バッジの配色

extension EewIntensityBadge {
    var backgroundColor: Color {
        switch self {
        case let .value(intensity):
            return intensity.backgroundColor
        case .unknown:
            // アプリ本体の unknown は黒。Dynamic Island の地とも Live Activity の
            // ダーク背景とも同化してバッジが消えるため、グレーで置き換える
            // （取消シンボル・揺れ検知の level 不明と同じ扱い）。
            return .gray
        }
    }

    var textColor: Color {
        switch self {
        case let .value(intensity):
            return intensity.textColor
        case .unknown:
            return .white
        }
    }

    /// バッジ寸法に対する主表示の文字サイズ比。
    /// 「不明」は 2 文字あり、震度の数字と同じ比率では正方形に収まらない。
    /// 震度を描くときは各バッジ既定の比率に任せるため nil。
    var unknownMainFontScale: CGFloat? {
        self == .unknown ? 0.34 : nil
    }
}

// MARK: - カスタムフォントの字形切れ対策

extension View {
    /// GoogleSans 系は可変フォントを実行時登録し `weight` を付けて使うため、
    /// 太さの実体を持たないぶん擬似ボールドで描かれ、描画幅が SwiftUI の計測幅を
    /// わずかに超える。末尾が欧文の Text はその差分だけ字形が切り取られる
    /// （Dynamic Island の「深さ40km」で m の右端が欠けていた）。
    /// 欧文で終わるラベルには差分ぶんの逃げを右に確保する。
    func latinTrailingBleed(fontSize: CGFloat) -> some View {
        padding(.trailing, (fontSize * 0.2).rounded(.up))
    }
}

// MARK: - 主要動到達カウントダウン

/// 主要動到達までの残り時間。桁が変わっても幅が揺れないよう等幅フォントで描く。
/// Lock Screen のヘッダーと Dynamic Island で同じ見た目にするため共通化している。
@available(iOS 16.1, *)
struct ArrivalCountdownText: View {
    let remaining: ClosedRange<Date>
    let size: CGFloat
    /// ヘッダーのように背景を自前で塗る場所では白を渡す
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
