//
//  IntensityValue.swift
//  Widget
//
//  震度階級の列挙型
//  Dart定義: packages/eqapi_types/lib/src/model/v2/enum/intensity.dart
//

import Foundation
import SwiftUI
import EQMonitorAPI

/// 震度階級
enum IntensityValue: String, Codable, CaseIterable, Comparable {
    case zero = "0"
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case fiveLowerNoInput = "!5-"  // 5弱以上未入電
    case fiveLower = "5-"
    case fiveUpper = "5+"
    case sixLowerNoInput = "!6-"  // 6弱以上未入電
    case sixLower = "6-"
    case sixUpper = "6+"
    case seven = "7"

    // MARK: - Comparable

    private var sortOrder: Int {
        switch self {
        case .zero: return 0
        case .one: return 1
        case .two: return 2
        case .three: return 3
        case .four: return 4
        case .fiveLowerNoInput, .fiveLower: return 5
        case .fiveUpper: return 6
        case .sixLowerNoInput, .sixLower: return 7
        case .sixUpper: return 8
        case .seven: return 9
        }
    }

    static func < (lhs: IntensityValue, rhs: IntensityValue) -> Bool {
        return lhs.sortOrder < rhs.sortOrder
    }

    // MARK: - Display Properties

    /// 表示用文字列（日本語）
    var displayString: String {
        switch self {
        case .zero: return "0"
        case .one: return "1"
        case .two: return "2"
        case .three: return "3"
        case .four: return "4"
        case .fiveLowerNoInput: return "5弱以上未入電"
        case .fiveLower: return "5弱"
        case .fiveUpper: return "5強"
        case .sixLowerNoInput: return "6弱以上未入電"
        case .sixLower: return "6弱"
        case .sixUpper: return "6強"
        case .seven: return "7"
        }
    }

    /// 震源名が無いときの見出し（「最大震度◯を観測」）に埋める文字列。
    /// 「未入電」は電文の受信状況を指す内部事情で、見出しに混ぜると
    /// 「最大震度5弱以上未入電を観測」のような読みづらい文になるため落とす。
    var titleText: String {
        switch self {
        case .fiveLowerNoInput: return "5弱以上"
        case .sixLowerNoInput: return "6弱以上"
        default: return displayString
        }
    }

    /// 震度のメイン数字部分
    var mainNumber: String {
        switch self {
        case .zero: return "0"
        case .one: return "1"
        case .two: return "2"
        case .three: return "3"
        case .four: return "4"
        case .fiveLowerNoInput, .fiveLower, .fiveUpper: return "5"
        case .sixLowerNoInput, .sixLower, .sixUpper: return "6"
        case .seven: return "7"
        }
    }

    /// 震度のサブ表示（弱/強）
    var subText: String? {
        switch self {
        case .fiveLowerNoInput, .sixLowerNoInput: return "弱以上"
        case .fiveLower, .sixLower: return "弱"
        case .fiveUpper, .sixUpper: return "強"
        default: return nil
        }
    }

    /// 分割された表示（Widget用）
    var formattedParts: (main: String, sub: String?) {
        return (mainNumber, subText)
    }

    /// 背景色。アプリ本体の `IntensityColorModel.eqmonitor()` と一致させる。
    /// 未入電（!5-/!6-）は API 変換規則（!5-→5弱色, !6-→6弱色）に倣う。
    var backgroundColor: Color {
        switch self {
        case .zero:
            return Color(rgb: 0xFFFFFF)
        case .one:
            return Color(rgb: 0x40C4FF) // lightBlueAccent
        case .two:
            return Color(rgb: 0xB9F6CA) // greenAccent.shade100
        case .three:
            return Color(rgb: 0x00C853) // greenAccent.shade700
        case .four:
            return Color(rgb: 0xFFEE58) // yellow.shade400
        case .fiveLowerNoInput, .fiveLower:
            return Color(rgb: 0xFFC107) // amber
        case .fiveUpper:
            return Color(rgb: 0xEF6C00) // orange.shade800
        case .sixLowerNoInput, .sixLower:
            return Color(rgb: 0xFF2800)
        case .sixUpper:
            return Color(rgb: 0xA50021)
        case .seven:
            return Color(rgb: 0xC800FF)
        }
    }

    /// テキスト色。アプリ本体の `IntensityColorModel.eqmonitor()` が持つ前景色に一致させる。
    /// eqmonitor() は輝度自動判定ではなく明示指定（震度1/3/5強は黒）を採用しているため、
    /// 完全一致させるにはその指定を踏襲する必要がある。
    var textColor: Color {
        switch self {
        case .zero, .one, .two, .three, .four,
             .fiveLowerNoInput, .fiveLower, .fiveUpper:
            return .black
        case .sixLowerNoInput, .sixLower, .sixUpper, .seven:
            return .white
        }
    }

    /// 危険度レベル（0-4）
    var dangerLevel: Int {
        switch self {
        case .zero, .one: return 0
        case .two, .three: return 1
        case .four, .fiveLowerNoInput, .fiveLower: return 2
        case .fiveUpper, .sixLowerNoInput, .sixLower: return 3
        case .sixUpper, .seven: return 4
        }
    }

    // MARK: - Conversion from Generated JmaIntensity

    /// 生成された JmaIntensity 列挙型からの変換
    init?(from jmaIntensity: Components.Schemas.JmaIntensity?) {
        guard let jma = jmaIntensity else { return nil }
        switch jma {
        case ._0: self = .zero
        case ._1: self = .one
        case ._2: self = .two
        case ._3: self = .three
        case ._4: self = .four
        case ._excl_5_hyphen_: self = .fiveLowerNoInput
        case ._5_hyphen_: self = .fiveLower
        case ._5_plus_: self = .fiveUpper
        case ._excl_6_hyphen_: self = .sixLowerNoInput
        case ._6_hyphen_: self = .sixLower
        case ._6_plus_: self = .sixUpper
        case ._7: self = .seven
        }
    }
}

/// 長周期地震動階級
enum LpgmIntensityValue: String, Codable, CaseIterable, Comparable {
    case zero = "0"
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"

    // MARK: - Comparable

    private var sortOrder: Int {
        switch self {
        case .zero: return 0
        case .one: return 1
        case .two: return 2
        case .three: return 3
        case .four: return 4
        }
    }

    static func < (lhs: LpgmIntensityValue, rhs: LpgmIntensityValue) -> Bool {
        return lhs.sortOrder < rhs.sortOrder
    }

    /// 表示用文字列
    var displayString: String {
        return rawValue
    }
}
