//
//  DesignSystem.swift
//  Widget
//
//  カラーパレット + Liquid Glass ヘルパー定義

import SwiftUI
import UIKit

// MARK: - Adaptive Color Palette

// 色の実体は Shared/DesignTokens.swift（アプリ本体と同値）。
// ここでは既存 View が参照する eq* 名のエイリアスのみを提供する。
extension Color {
    // background
    static let eqBg = DesignTokens.bg
    static let eqSurface = DesignTokens.surface
    static let eqCard = DesignTokens.card

    // brand
    static let eqBrand = DesignTokens.brand
    static let eqBrandContainer = DesignTokens.brandContainer

    // outline
    static let eqOutlineSoft = DesignTokens.outlineSoft

    // text
    static let eqTextPrimary = DesignTokens.textPrimary
    static let eqTextSecondary = DesignTokens.textSecondary
    static let eqTextTertiary = DesignTokens.textTertiary
}

// Color(rgb:) は Shared/ColorRGB.swift へ移動（IntensityValue と共有するため）

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
