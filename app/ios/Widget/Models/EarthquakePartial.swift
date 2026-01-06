//
//  EarthquakePartial.swift
//  Widget
//
//  地震情報（一覧用、部分的）
//  Dart定義: packages/eqapi_types/lib/src/model/v2/earthquake/earthquake.dart
//

import Foundation

/// 地震情報（一覧用、部分的）
struct EarthquakePartial: Codable, Equatable, Identifiable {
    /// yyyyMMddHHmmss形式のイベントID
    let eventId: String

    /// 電文ステータス
    let status: TelegramStatus

    /// 地震発生時刻
    let originTime: Date?

    /// 地震検知時刻
    let arrivalTime: Date?

    /// 震源情報
    let hypocenter: Hypocenter?

    /// 震度情報
    let intensity: IntensityPartial?

    // MARK: - Identifiable

    var id: String { eventId }

    // MARK: - Utility Properties

    /// 震央地名
    var hypocenterName: String {
        return hypocenter?.displayName ?? "震源地不明"
    }

    /// マグニチュード（数値）
    var magnitudeValue: Double? {
        return hypocenter?.magnitude.numericValue
    }

    /// マグニチュード表示文字列
    var magnitudeDisplayString: String {
        return hypocenter?.magnitude.displayString ?? "M不明"
    }

    /// 深さ表示文字列
    var depthDisplayString: String {
        return hypocenter?.depth.displayString ?? "不明"
    }

    /// 最大震度
    var maxIntensity: IntensityValue? {
        return intensity?.maxIntensity
    }

    /// 最大震度表示文字列
    var maxIntensityDisplayString: String {
        return intensity?.maxIntensity.displayString ?? "-"
    }

    /// 発生時刻（originTime優先、なければarrivalTime）
    var effectiveTime: Date? {
        return originTime ?? arrivalTime
    }

    /// 緯度
    var latitude: Double? {
        return hypocenter?.latitude
    }

    /// 経度
    var longitude: Double? {
        return hypocenter?.longitude
    }

    /// 通常の地震情報かどうか
    var isNormal: Bool {
        return status.isNormal
    }

    /// テスト・訓練のバッジテキスト
    var statusBadge: String? {
        return status.badgeText
    }
}

// MARK: - API Response

/// 地震一覧レスポンス
struct EarthquakeListResponse: Codable {
    let items: [EarthquakePartial]
    let nextToken: String?
    let nextPooling: String?
}

/// 震度細分区域検索レスポンスの項目
struct IntensityRegionSearchItem: Codable, Equatable, Identifiable {
    let eventId: String
    let region: IntensityRegionInfo
    let earthquake: EarthquakePartial

    var id: String { eventId }
}

/// 震度検索用の地域情報
struct IntensityRegionInfo: Codable, Equatable {
    let code: String
    let name: String
    let intensity: IntensityValue?
    let lpgmIntensity: LpgmIntensityValue?
}

/// 震度細分区域検索レスポンス
struct IntensityRegionSearchResponse: Codable {
    let items: [IntensityRegionSearchItem]
    let nextToken: String?
    let nextPooling: String?
}
