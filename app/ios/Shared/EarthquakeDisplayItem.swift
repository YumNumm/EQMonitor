//
//  EarthquakeDisplayItem.swift
//  Widget
//
//  Widget表示用の変換済みモデル
//  Components.Schemas.EarthquakePartial をWidget表示に最適化した形式に変換
//

import Foundation
import SwiftUI
import EQMonitorAPI

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

    // MARK: - Initialization from Generated EarthquakePartial

    /// Components.Schemas.EarthquakePartial からの変換初期化
    init(from partial: Components.Schemas.EarthquakePartial) {
        let maxIntensity = IntensityValue(from: partial.intensity?.value1.max_intensity)
        self.id = partial.event_id
        self.hypocenterName = Self.resolveTitle(
            name: partial.hypocenter?.value1.name,
            detailedName: partial.hypocenter?.value1.detailed?.value1.name,
            maxIntensity: maxIntensity
        )
        self.magnitude = Self.formatMagnitude(partial.hypocenter?.value1.magnitude)
        self.magnitudeValue = partial.hypocenter?.value1.magnitude.value
        self.maxIntensity = maxIntensity
        self.depth = Self.formatDepth(partial.hypocenter?.value1.depth)
        self.latitude = partial.hypocenter?.value1.coordinates?.value1.latitude
        self.longitude = partial.hypocenter?.value1.coordinates?.value1.longitude
        self.status = TelegramStatus(from: partial.status)

        // 発生時刻の処理（origin_time 優先、無ければ検知時刻）
        if let time = partial.origin_time {
            self.originTime = time
            self.formattedTime = Self.formatTime(time, isArrival: false)
        } else if let time = partial.arrival_time {
            self.originTime = time
            self.formattedTime = Self.formatTime(time, isArrival: true)
        } else {
            self.originTime = Date()
            self.formattedTime = ""
        }
    }

    /// 地域/都道府県/市区町村の震度検索結果からの変換初期化
    /// 3 種の検索アイテムは構造が同一（震度 + EarthquakePartial）なので共通化する
    init(from searchItem: Components.Schemas.IntensityRegionSearchItem) {
        self.init(regionIntensity: searchItem.intensity, earthquake: searchItem.earthquake)
    }

    init(from searchItem: Components.Schemas.IntensityPrefectureSearchItem) {
        self.init(regionIntensity: searchItem.intensity, earthquake: searchItem.earthquake)
    }

    init(from searchItem: Components.Schemas.IntensityCitySearchItem) {
        self.init(regionIntensity: searchItem.intensity, earthquake: searchItem.earthquake)
    }

    private init(
        regionIntensity: Components.Schemas.JmaIntensity,
        earthquake partial: Components.Schemas.EarthquakePartial
    ) {
        // 地域の震度情報を優先（検索結果の場合）
        let maxIntensity = IntensityValue(from: regionIntensity)
            ?? IntensityValue(from: partial.intensity?.value1.max_intensity)
        self.id = partial.event_id
        self.hypocenterName = Self.resolveTitle(
            name: partial.hypocenter?.value1.name,
            detailedName: partial.hypocenter?.value1.detailed?.value1.name,
            maxIntensity: maxIntensity
        )
        self.magnitude = Self.formatMagnitude(partial.hypocenter?.value1.magnitude)
        self.magnitudeValue = partial.hypocenter?.value1.magnitude.value
        self.depth = Self.formatDepth(partial.hypocenter?.value1.depth)
        self.latitude = partial.hypocenter?.value1.coordinates?.value1.latitude
        self.longitude = partial.hypocenter?.value1.coordinates?.value1.longitude
        self.status = TelegramStatus(from: partial.status)
        self.maxIntensity = maxIntensity

        // 発生時刻の処理（origin_time 優先、無ければ検知時刻）
        if let time = partial.origin_time {
            self.originTime = time
            self.formattedTime = Self.formatTime(time, isArrival: false)
        } else if let time = partial.arrival_time {
            self.originTime = time
            self.formattedTime = Self.formatTime(time, isArrival: true)
        } else {
            self.originTime = Date()
            self.formattedTime = ""
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
        self.formattedTime = Self.formatTime(originTime, isArrival: false)
        self.latitude = latitude
        self.longitude = longitude
        self.status = status
    }

    // MARK: - Formatting Helpers
    // 表記はアプリ本体（app/lib/feature/earthquake_history/ 配下）を正とする。
    // internal なのは WidgetModelsTests で表記の一致を検証するため。

    /// 発生/検知時刻の表示文字列を生成
    /// - Parameter isArrival: origin_time が無く arrival_time で代替した場合 true
    static func formatTime(_ date: Date, isArrival: Bool) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        formatter.locale = Locale(identifier: "ja_JP")
        formatter.timeZone = TimeZone(identifier: "Asia/Tokyo")
        return formatter.string(from: date) + (isArrival ? "頃検知" : "頃発生")
    }

    /// マグニチュードの表示文字列を生成
    static func formatMagnitude(_ magnitude: Components.Schemas.Magnitude?) -> String {
        guard let mag = magnitude else { return "M不明" }
        switch mag._type {
        case .NORMAL:
            if let value = mag.value {
                return String(format: "M%.1f", value)
            }
            return "M不明"
        case .UNKNOWN:
            return "M不明"
        case .OVER_M8:
            return "M8超"
        }
    }

    /// 深さの表示文字列を生成。不明は空文字（View 側で表示ごと省略する）
    static func formatDepth(_ depth: Components.Schemas.Depth?) -> String {
        guard let d = depth else { return "" }
        switch d._type {
        case .SHALLOW:
            return "ごく浅い"
        case .NORMAL:
            if let value = d.value {
                return "\(Int(value))km"
            }
            return ""
        case .OVER_700:
            return "700km以上"
        case .UNKNOWN:
            return ""
        }
    }

    /// タイトル（震源名）の解決。震源名が無い場合は「最大震度◯を観測」に
    /// フォールバックする（アプリの earthquake_history_list_tile と同じ規則）
    static func resolveTitle(
        name: String?,
        detailedName: String?,
        maxIntensity: IntensityValue?
    ) -> String {
        if let detailedName { return detailedName }
        if let name { return name }
        if let maxIntensity { return "最大震度\(maxIntensity.titleText)を観測" }
        return ""
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
