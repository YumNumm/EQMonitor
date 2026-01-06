//
//  EarthquakeDisplayItem.swift
//  Widget
//
//  Widget表示用の変換済みモデル
//  EarthquakePartialをWidget表示に最適化した形式に変換
//

import Foundation
import SwiftUI

/// Widget表示用の地震情報
struct EarthquakeDisplayItem: Identifiable, Equatable {
    let id: String
    let hypocenterName: String
    let magnitude: String
    let magnitudeValue: Double?
    let maxIntensity: IntensityValue?
    let depth: String
    let originTime: Date
    let formattedTime: String
    let latitude: Double?
    let longitude: Double?
    let status: TelegramStatus

    // MARK: - Computed Properties

    /// 震度の分割表示（メイン数字とサブテキスト）
    var formattedIntensity: (main: String, sub: String?) {
        guard let intensity = maxIntensity else {
            return ("-", nil)
        }
        return intensity.formattedParts
    }

    /// 震度の背景色
    var intensityBackgroundColor: Color {
        return maxIntensity?.backgroundColor ?? Color.gray
    }

    /// 震度のテキスト色
    var intensityTextColor: Color {
        return maxIntensity?.textColor ?? Color.white
    }

    /// 危険度レベル（アクセシビリティ用）
    var dangerLevel: Int {
        return maxIntensity?.dangerLevel ?? 0
    }

    /// ステータスバッジ（テスト・訓練の場合のみ）
    var statusBadge: String? {
        return status.badgeText
    }

    /// 通常の地震情報かどうか
    var isNormal: Bool {
        return status.isNormal
    }

    // MARK: - Initialization from EarthquakePartial

    /// EarthquakePartialからの変換初期化
    init(from partial: EarthquakePartial) {
        self.id = partial.eventId
        self.hypocenterName = partial.hypocenterName
        self.magnitude = partial.magnitudeDisplayString
        self.magnitudeValue = partial.magnitudeValue
        self.maxIntensity = partial.maxIntensity
        self.depth = partial.depthDisplayString
        self.latitude = partial.latitude
        self.longitude = partial.longitude
        self.status = partial.status

        // 発生時刻の処理
        if let time = partial.effectiveTime {
            self.originTime = time
            self.formattedTime = Self.formatTime(time)
        } else {
            self.originTime = Date()
            self.formattedTime = "時刻不明"
        }
    }

    /// IntensityRegionSearchItemからの変換初期化
    init(from searchItem: IntensityRegionSearchItem) {
        let partial = searchItem.earthquake
        self.id = partial.eventId
        self.hypocenterName = partial.hypocenterName
        self.magnitude = partial.magnitudeDisplayString
        self.magnitudeValue = partial.magnitudeValue
        self.depth = partial.depthDisplayString
        self.latitude = partial.latitude
        self.longitude = partial.longitude
        self.status = partial.status

        // 地域の震度情報を優先（検索結果の場合）
        self.maxIntensity = searchItem.region.intensity ?? partial.maxIntensity

        // 発生時刻の処理
        if let time = partial.effectiveTime {
            self.originTime = time
            self.formattedTime = Self.formatTime(time)
        } else {
            self.originTime = Date()
            self.formattedTime = "時刻不明"
        }
    }

    /// 直接初期化（プレビュー・モックデータ用）
    init(
        id: String,
        hypocenterName: String,
        magnitude: String,
        magnitudeValue: Double?,
        maxIntensity: IntensityValue?,
        depth: String,
        originTime: Date,
        latitude: Double? = nil,
        longitude: Double? = nil,
        status: TelegramStatus = .normal
    ) {
        self.id = id
        self.hypocenterName = hypocenterName
        self.magnitude = magnitude
        self.magnitudeValue = magnitudeValue
        self.maxIntensity = maxIntensity
        self.depth = depth
        self.originTime = originTime
        self.formattedTime = Self.formatTime(originTime)
        self.latitude = latitude
        self.longitude = longitude
        self.status = status
    }

    // MARK: - Private Helpers

    private static func formatTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd HH:mm"
        formatter.locale = Locale(identifier: "ja_JP")
        formatter.timeZone = TimeZone(identifier: "Asia/Tokyo")
        return formatter.string(from: date) + "頃"
    }

    // MARK: - Mock Data for Preview

    static var mockData: [EarthquakeDisplayItem] {
        [
            EarthquakeDisplayItem(
                id: "20260106123456",
                hypocenterName: "福島県沖",
                magnitude: "M5.2",
                magnitudeValue: 5.2,
                maxIntensity: .four,
                depth: "50km",
                originTime: Date().addingTimeInterval(-3600),
                latitude: 37.5,
                longitude: 141.5
            ),
            EarthquakeDisplayItem(
                id: "20260105234500",
                hypocenterName: "千葉県北西部",
                magnitude: "M3.8",
                magnitudeValue: 3.8,
                maxIntensity: .three,
                depth: "30km",
                originTime: Date().addingTimeInterval(-7200),
                latitude: 35.8,
                longitude: 140.1
            ),
            EarthquakeDisplayItem(
                id: "20260105120000",
                hypocenterName: "石川県能登地方",
                magnitude: "M6.5",
                magnitudeValue: 6.5,
                maxIntensity: .sixLower,
                depth: "10km",
                originTime: Date().addingTimeInterval(-14400),
                latitude: 37.2,
                longitude: 136.8
            )
        ]
    }

    static var singleMockData: EarthquakeDisplayItem {
        EarthquakeDisplayItem(
            id: "20260106123456",
            hypocenterName: "福島県沖",
            magnitude: "M5.2",
            magnitudeValue: 5.2,
            maxIntensity: .four,
            depth: "50km",
            originTime: Date().addingTimeInterval(-3600),
            latitude: 37.5,
            longitude: 141.5
        )
    }
}

// MARK: - Array Extension for Batch Conversion

extension Array where Element == EarthquakePartial {
    /// EarthquakePartialの配列をEarthquakeDisplayItemの配列に変換
    func toDisplayItems() -> [EarthquakeDisplayItem] {
        return map { EarthquakeDisplayItem(from: $0) }
    }
}

extension Array where Element == IntensityRegionSearchItem {
    /// IntensityRegionSearchItemの配列をEarthquakeDisplayItemの配列に変換
    func toDisplayItems() -> [EarthquakeDisplayItem] {
        return map { EarthquakeDisplayItem(from: $0) }
    }
}
