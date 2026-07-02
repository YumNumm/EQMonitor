//
//  DesignSystem.swift
//  Widget
//
//  カラーパレット + Liquid Glass ヘルパー定義

import SwiftUI
import UIKit

// MARK: - Adaptive Color Palette

extension Color {
    // background
    static let eqBg = dynamic(light: 0xF1F4F8, dark: 0x0F141A)
    static let eqSurface = dynamic(light: 0xFFFFFF, dark: 0x171E26)
    static let eqCard = dynamic(light: 0xEDF1F6, dark: 0x232D38)

    // brand
    static let eqBrand = dynamic(light: 0x2F6FE0, dark: 0x4D8DFF)
    static let eqBrandContainer = dynamic(light: 0xE2EAF9, dark: 0x24344A)

    // outline
    static let eqOutlineSoft = dynamic(light: 0xD7DEE7, dark: 0x3A4654)

    // text
    static let eqTextPrimary = dynamic(light: 0x10151B, dark: 0xF3F6FA)
    static let eqTextSecondary = dynamic(light: 0x44505E, dark: 0xC4CCD7)
    static let eqTextTertiary = dynamic(light: 0x6B7787, dark: 0x98A5B5)

    /// ライト/ダークで切り替わる動的カラーを生成する
    private static func dynamic(light: UInt, dark: UInt) -> Color {
        Color(uiColor: UIColor { traits in
            UIColor(rgb: traits.userInterfaceStyle == .dark ? dark : light)
        })
    }
}

private extension UIColor {
    convenience init(rgb: UInt) {
        self.init(
            red: CGFloat((rgb >> 16) & 0xFF) / 255.0,
            green: CGFloat((rgb >> 8) & 0xFF) / 255.0,
            blue: CGFloat(rgb & 0xFF) / 255.0,
            alpha: 1.0
        )
    }
}

// MARK: - Fixed RGB Color

extension Color {
    /// 0xRRGGBB 形式の固定色を生成する（ライト/ダーク非依存）
    init(rgb: UInt) {
        self.init(
            red: Double((rgb >> 16) & 0xFF) / 255.0,
            green: Double((rgb >> 8) & 0xFF) / 255.0,
            blue: Double(rgb & 0xFF) / 255.0
        )
    }
}

// MARK: - Surface Gradient

extension ShapeStyle where Self == LinearGradient {
    /// ウィジェット背景に奥行きを与える縦方向グラデーション
    static var eqSurfaceGradient: LinearGradient {
        LinearGradient(
            colors: [Color.eqSurface, Color.eqBg],
            startPoint: .top,
            endPoint: .bottom
        )
    }
}

// MARK: - Liquid Glass Helpers

extension View {
    /// Liquid Glass マテリアルを角丸矩形で適用する（任意のティント付き）
    func eqGlass(cornerRadius: CGFloat, tint: Color? = nil) -> some View {
        let glass: Glass = tint.map { Glass.regular.tint($0) } ?? .regular
        return self.glassEffect(glass, in: .rect(cornerRadius: cornerRadius, style: .continuous))
    }
}
