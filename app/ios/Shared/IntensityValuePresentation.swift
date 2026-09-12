import EQMonitorAPI
import SwiftUI

extension IntensityValue {
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

    var titleText: String {
        switch self {
        case .fiveLowerNoInput: return "5弱以上"
        case .sixLowerNoInput: return "6弱以上"
        default: return displayString
        }
    }

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

    var subText: String? {
        switch self {
        case .fiveLowerNoInput, .sixLowerNoInput: return "弱以上"
        case .fiveLower, .sixLower: return "弱"
        case .fiveUpper, .sixUpper: return "強"
        default: return nil
        }
    }

    var formattedParts: (main: String, sub: String?) {
        (mainNumber, subText)
    }

    var backgroundColor: Color {
        switch self {
        case .zero: return Color(rgb: 0xFFFFFF)
        case .one: return Color(rgb: 0x40C4FF)
        case .two: return Color(rgb: 0xB9F6CA)
        case .three: return Color(rgb: 0x00C853)
        case .four: return Color(rgb: 0xFFEE58)
        case .fiveLowerNoInput, .fiveLower: return Color(rgb: 0xFFC107)
        case .fiveUpper: return Color(rgb: 0xEF6C00)
        case .sixLowerNoInput, .sixLower: return Color(rgb: 0xFF2800)
        case .sixUpper: return Color(rgb: 0xA50021)
        case .seven: return Color(rgb: 0xC800FF)
        }
    }

    var textColor: Color {
        switch self {
        case .zero, .one, .two, .three, .four,
             .fiveLowerNoInput, .fiveLower, .fiveUpper:
            return .black
        case .sixLowerNoInput, .sixLower, .sixUpper, .seven:
            return .white
        }
    }

    var dangerLevel: Int {
        switch self {
        case .zero, .one: return 0
        case .two, .three: return 1
        case .four, .fiveLowerNoInput, .fiveLower: return 2
        case .fiveUpper, .sixLowerNoInput, .sixLower: return 3
        case .sixUpper, .seven: return 4
        }
    }

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
