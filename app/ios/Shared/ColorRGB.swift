//
//  ColorRGB.swift
//  Shared (WidgetExtension / AppIntentExtension / WidgetModelsTests)
//

import SwiftUI

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
