//
//  DesignSystem.swift
//  Widget
//

import SwiftUI

// MARK: - Adaptive Color Palette

extension Color {
    // background
    static let eqBg = DesignTokens.bg
    static let eqSurface = DesignTokens.surface

    // outline
    static let eqOutlineSoft = DesignTokens.outlineSoft

    // text
    static let eqTextPrimary = DesignTokens.textPrimary
    static let eqTextSecondary = DesignTokens.textSecondary
    static let eqTextTertiary = DesignTokens.textTertiary
}

// MARK: - Widget Background

struct EQWidgetBackground: View {
    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        ZStack {
            LinearGradient.eqSurfaceGradient
            if colorScheme == .light {
                // ライトだけ、左上から薄い青の光が差し込むように広くぼかして重ねる
                EllipticalGradient(
                    stops: [
                        .init(color: DesignTokens.brand.opacity(0.20), location: 0),
                        .init(color: DesignTokens.brand.opacity(0.09), location: 0.4),
                        .init(color: DesignTokens.brand.opacity(0.02), location: 0.8),
                        .init(color: DesignTokens.brand.opacity(0), location: 1),
                    ],
                    center: .topLeading,
                    startRadiusFraction: 0,
                    endRadiusFraction: 1.3
                )
            }
        }
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
