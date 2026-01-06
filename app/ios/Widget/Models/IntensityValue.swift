//
//  IntensityValue.swift
//  Widget
//
//  震度階級の列挙型
//  Dart定義: packages/eqapi_types/lib/src/model/v2/enum/intensity.dart
//

import Foundation
import SwiftUI

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
        case .sixLower: return 7
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
        case .sixLower: return "6弱"
        case .sixUpper: return "6強"
        case .seven: return "7"
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
        case .sixLower, .sixUpper: return "6"
        case .seven: return "7"
        }
    }

    /// 震度のサブ表示（弱/強）
    var subText: String? {
        switch self {
        case .fiveLowerNoInput: return "弱以上"
        case .fiveLower, .sixLower: return "弱"
        case .fiveUpper, .sixUpper: return "強"
        default: return nil
        }
    }

    /// 分割された表示（Widget用）
    var formattedParts: (main: String, sub: String?) {
        return (mainNumber, subText)
    }

    /// 背景色
    var backgroundColor: Color {
        switch self {
        case .zero:
            return Color(red: 0.75, green: 0.75, blue: 0.75) // グレー
        case .one:
            return Color(red: 0.95, green: 0.95, blue: 0.95) // 白に近い
        case .two:
            return Color(red: 0.6, green: 0.85, blue: 1.0) // 水色
        case .three:
            return Color(red: 0.2, green: 0.6, blue: 1.0) // 青
        case .four:
            return Color(red: 1.0, green: 0.9, blue: 0.4) // 黄色
        case .fiveLowerNoInput, .fiveLower:
            return Color(red: 1.0, green: 0.65, blue: 0.2) // オレンジ
        case .fiveUpper:
            return Color(red: 1.0, green: 0.4, blue: 0.2) // 濃いオレンジ
        case .sixLower:
            return Color(red: 1.0, green: 0.2, blue: 0.3) // 赤
        case .sixUpper:
            return Color(red: 0.85, green: 0.1, blue: 0.2) // 濃い赤
        case .seven:
            return Color(red: 0.6, green: 0.1, blue: 0.4) // 紫
        }
    }

    /// テキスト色
    var textColor: Color {
        switch self {
        case .zero, .one, .two, .three, .four:
            return .black
        default:
            return .white
        }
    }

    /// 危険度レベル（0-4）
    var dangerLevel: Int {
        switch self {
        case .zero, .one: return 0
        case .two, .three: return 1
        case .four, .fiveLowerNoInput, .fiveLower: return 2
        case .fiveUpper, .sixLower: return 3
        case .sixUpper, .seven: return 4
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
