//
//  DesignTokens.swift
//  Shared (WidgetExtension / AppIntentExtension)
//
//  アプリ本体のデザイントークンと同値の定義。変更時は両方更新すること。
//  - 色: lib/core/designsystem/extensions/color_theme_extension.dart /
//        text_color_theme_extension.dart / color_palette.dart
//  - フォント: pubspec.yaml (GoogleSansFlex / GoogleSansCode)
//

import SwiftUI
import UIKit
import CoreText

enum DesignTokens {
    // MARK: ColorThemeExtension

    static let bg = dynamic(light: 0xF5F8FC, dark: 0x0F141A)
    static let surface = dynamic(light: 0xFFFFFF, dark: 0x171E26)
    static let card = dynamic(light: 0xEAF0F7, dark: 0x232D38)
    static let outlineSoft = dynamic(light: 0xD3DDE8, dark: 0x3A4654)

    // MARK: ColorPalette

    static let brand = dynamic(light: 0x2F6FE4, dark: 0x4D8DFF)
    static let brandContainer = dynamic(light: 0xDCE8FF, dark: 0x24344A)

    // MARK: TextColorThemeExtension

    static let textPrimary = dynamic(light: 0x10151C, dark: 0xF3F6FA)
    static let textSecondary = dynamic(light: 0x4A5A6D, dark: 0xC4CCD7)
    static let textTertiary = dynamic(light: 0x738294, dark: 0x98A5B5)

    // MARK: Radius

    static let radiusCard: CGFloat = 24
    static let radiusMd: CGFloat = 16
    static let radiusSm: CGFloat = 12
    static let radiusXs: CGFloat = 8

    /// ライト/ダークで切り替わる動的カラーを生成する
    static func dynamic(light: UInt, dark: UInt) -> Color {
        Color(uiColor: UIColor { traits in
            UIColor(
                rgb: traits.userInterfaceStyle == .dark ? dark : light
            )
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

// MARK: - App Fonts

/// アプリと同じ GoogleSans 系フォント。拡張のバンドルに可変TTFを同梱し、
/// 実行時登録して使う（拡張では Info.plist の UIAppFonts が効かないため）
enum AppFonts {
    private static let registerOnce: Void = {
        let resources = [
            "GoogleSansFlex[GRAD,ROND,opsz,slnt,wdth,wght]",
            "GoogleSansCode[MONO,wght]",
        ]
        for name in resources {
            if let url = Bundle.main.url(forResource: name, withExtension: "ttf") {
                CTFontManagerRegisterFontsForURL(url as CFURL, .process, nil)
            }
        }
    }()

    static func registerIfNeeded() {
        _ = registerOnce
    }

    /// 見出し・本文用（アプリの GoogleSansFlex 相当）。日本語はシステムにフォールバック
    static func flex(size: CGFloat, weight: Font.Weight = .regular) -> Font {
        registerIfNeeded()
        return .custom("Google Sans Flex", size: size).weight(weight)
    }

    /// 数値・時刻など等幅用（アプリの GoogleSansCode 相当）
    static func code(size: CGFloat, weight: Font.Weight = .regular) -> Font {
        registerIfNeeded()
        return .custom("Google Sans Code", size: size).weight(weight)
    }
}
