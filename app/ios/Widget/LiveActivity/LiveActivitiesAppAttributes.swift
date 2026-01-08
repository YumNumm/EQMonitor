//
//  LiveActivitiesAppAttributes.swift
//  Widget
//
//  Live Activity用のAttributes定義
//  live_activitiesパッケージと連携するため、命名規則に従う
//

import ActivityKit
import WidgetKit
import SwiftUI

// MARK: - Live Activity Attributes

/// Live Activity用Attributes
/// live_activitiesパッケージの命名規則に従う
struct LiveActivitiesAppAttributes: ActivityAttributes, Identifiable {
    public typealias ContentState = LiveActivityContentState

    public var id = UUID()

    // 静的なプロパティ（Live Activity開始時に設定、変更不可）
    let eventId: String
    let type: String  // "eew" or "shake_detection"
}

// MARK: - Content State

/// Live Activityのコンテンツ状態（動的に更新可能）
struct LiveActivityContentState: Codable, Hashable {
    // 共通フィールド
    let eventId: String
    let type: String

    // === EEW用フィールド ===
    let hypocenterName: String?
    let magnitude: Double?
    let depth: Int?
    let originTime: String?
    let maxIntensity: String?
    let serialNo: Int?
    let isFinal: Bool?
    let isWarning: Bool?
    let headline: String?  // 例: "石川県能登地方で地震" または警報時 "XX YYで強い揺れ"

    // === 揺れ検知用フィールド ===
    let level: String?
    let detectedAt: String?

    // === 現在地情報 ===
    let location: LocationInfo?

    // MARK: - Computed Properties

    /// EEWかどうか
    var isEew: Bool {
        type == "eew"
    }

    /// 揺れ検知かどうか
    var isShakeDetection: Bool {
        type == "shake_detection"
    }

    /// 震度値（EEW用）
    var intensityValue: IntensityValue? {
        guard let maxIntensity = maxIntensity else { return nil }
        return IntensityValue(rawValue: maxIntensity)
    }

    /// 揺れレベル（揺れ検知用）
    var shakeLevel: ShakeDetectionLevel? {
        guard let level = level else { return nil }
        return ShakeDetectionLevel(rawValue: level)
    }
}

// MARK: - Location Info

/// 現在地情報
struct LocationInfo: Codable, Hashable {
    let regionName: String
    let forecastIntensity: String?
    let forecastLpgmIntensity: String?
    let arrivalTime: String?
    let intensity: Double?

    /// 予想震度
    var forecastIntensityValue: IntensityValue? {
        guard let forecastIntensity = forecastIntensity else { return nil }
        return IntensityValue(rawValue: forecastIntensity)
    }

    /// 到達予想時刻
    var arrivalDate: Date? {
        guard let arrivalTime = arrivalTime else { return nil }
        return ISO8601DateFormatter().date(from: arrivalTime)
    }
}

// MARK: - Shake Detection Level

/// 揺れ検知レベル
enum ShakeDetectionLevel: String, Codable, CaseIterable {
    case weaker = "Weaker"
    case weak = "Weak"
    case medium = "Medium"
    case strong = "Strong"
    case stronger = "Stronger"

    /// 表示用文字列
    var displayString: String {
        switch self {
        case .weaker: return "微弱な揺れ"
        case .weak: return "弱い揺れ"
        case .medium: return "揺れ"
        case .strong: return "強い揺れ"
        case .stronger: return "非常に強い揺れ"
        }
    }

    /// 背景色
    var backgroundColor: Color {
        switch self {
        case .weaker:
            return Color(red: 0.75, green: 0.75, blue: 0.75)
        case .weak:
            return Color(red: 0.6, green: 0.85, blue: 1.0)
        case .medium:
            return Color(red: 1.0, green: 0.9, blue: 0.4)
        case .strong:
            return Color(red: 1.0, green: 0.4, blue: 0.2)
        case .stronger:
            return Color(red: 0.85, green: 0.1, blue: 0.2)
        }
    }

    /// テキスト色
    var textColor: Color {
        switch self {
        case .weaker, .weak, .medium:
            return .black
        default:
            return .white
        }
    }
}

// MARK: - Helper Extensions

extension LiveActivitiesAppAttributes {
    /// live_activitiesパッケージ用のキー接頭辞
    func prefixedKey(_ key: String) -> String {
        return "\(id)_\(key)"
    }
}
