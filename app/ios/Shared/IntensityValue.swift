//
//  IntensityValue.swift
//  Widget
//
//  震度階級の列挙型
//  Dart定義: packages/eqapi_types/lib/src/model/v2/enum/intensity.dart
//

import Foundation

/// 震度階級
enum IntensityValue: String, Codable, CaseIterable, Comparable, Hashable, Sendable {
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

}

/// 長周期地震動階級
enum LpgmIntensityValue: String, Codable, CaseIterable, Comparable, Hashable, Sendable {
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
