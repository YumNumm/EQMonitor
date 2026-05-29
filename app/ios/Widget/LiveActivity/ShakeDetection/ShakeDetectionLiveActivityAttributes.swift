//
//  ShakeDetectionLiveActivityAttributes.swift
//  Widget
//

import ActivityKit
import SwiftUI

struct ShakeDetectionLiveActivityAttributes: ActivityAttributes, Identifiable {
    public typealias ContentState = ShakeDetectionContentState

    public var id = UUID()
    let eventId: String
}

struct ShakeDetectionContentState: Codable, Hashable {
    let eventId: String
    /// イベント種別（backendは常に "shake_detection" を送る）
    let type: String
    let level: String?
    let detectedAt: String?
    let location: LocationInfo?

    var shakeLevel: ShakeDetectionLevel? {
        guard let level = level else { return nil }
        return ShakeDetectionLevel(rawValue: level)
    }

    var detectedDate: Date? {
        guard let detectedAt = detectedAt else { return nil }
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        if let date = formatter.date(from: detectedAt) { return date }
        formatter.formatOptions = [.withInternetDateTime]
        return formatter.date(from: detectedAt)
    }
}

enum ShakeDetectionLevel: String, Codable, CaseIterable {
    case weaker = "Weaker"
    case weak = "Weak"
    case medium = "Medium"
    case strong = "Strong"
    case stronger = "Stronger"

    var displayString: String {
        switch self {
        case .weaker: return "微弱な揺れ"
        case .weak: return "弱い揺れ"
        case .medium: return "揺れ"
        case .strong: return "強い揺れ"
        case .stronger: return "非常に強い揺れ"
        }
    }

    var shortDisplayString: String {
        switch self {
        case .weaker: return "微"
        case .weak: return "弱"
        case .medium: return "中"
        case .strong: return "強"
        case .stronger: return "激"
        }
    }

    var backgroundColor: Color {
        switch self {
        case .weaker: return Color(red: 0.75, green: 0.75, blue: 0.75)
        case .weak: return Color(red: 0.6, green: 0.85, blue: 1.0)
        case .medium: return Color(red: 1.0, green: 0.9, blue: 0.4)
        case .strong: return Color(red: 1.0, green: 0.4, blue: 0.2)
        case .stronger: return Color(red: 0.85, green: 0.1, blue: 0.2)
        }
    }

    var textColor: Color {
        switch self {
        case .weaker, .weak, .medium: return .black
        default: return .white
        }
    }

    /// ストライプパターン用の2色
    var stripeColors: [Color] {
        switch self {
        case .weaker:
            return [Color(red: 0.75, green: 0.75, blue: 0.75), Color(red: 0.5, green: 0.5, blue: 0.5)]
        case .weak:
            return [Color(red: 0.6, green: 0.85, blue: 1.0), Color(red: 0.3, green: 0.6, blue: 0.8)]
        case .medium:
            return [Color.yellow, Color.orange]
        case .strong:
            return [Color.orange, Color(red: 0.8, green: 0.4, blue: 0.05)]
        case .stronger:
            return [Color.red, Color.black]
        }
    }

    /// ヘッダー背景色
    var headerBackgroundColor: Color {
        switch self {
        case .weaker:
            return Color(red: 0.5, green: 0.5, blue: 0.5)
        case .weak:
            return Color(red: 0.3, green: 0.5, blue: 0.7)
        case .medium:
            return Color(red: 0.8, green: 0.4, blue: 0.05)
        case .strong:
            return Color(red: 0.9, green: 0.3, blue: 0.1)
        case .stronger:
            return Color(red: 0.7, green: 0.1, blue: 0.1)
        }
    }
}

extension ShakeDetectionLiveActivityAttributes {
    func prefixedKey(_ key: String) -> String {
        return "\(id)_\(key)"
    }
}
