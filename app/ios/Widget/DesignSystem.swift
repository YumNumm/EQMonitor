//
//  DesignSystem.swift
//  Widget
//

import SwiftUI
import UIKit

// MARK: - Adaptive Color Palette

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
    func eqGlass(cornerRadius: CGFloat, tint: Color? = nil) -> some View {
        let glass: Glass = tint.map { Glass.regular.tint($0) } ?? .regular
        return self.glassEffect(glass, in: .rect(cornerRadius: cornerRadius, style: .continuous))
    }
}
