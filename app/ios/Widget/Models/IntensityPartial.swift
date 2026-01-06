//
//  IntensityPartial.swift
//  Widget
//
//  震度情報（部分的、citiesとstationsを含まない）
//  Dart定義: packages/eqapi_types/lib/src/model/v2/earthquake/intensity.dart
//

import Foundation

/// コード・名前ペア
struct CodeName: Codable, Equatable {
    let code: String
    let name: String
}

/// 震度情報の各項目
struct IntensityItem: Codable, Equatable {
    let value: CodeName
    let maxIntensity: IntensityValue?
    let maxLpgmIntensity: LpgmIntensityValue?

    // MARK: - Utility Properties

    /// 地域コード
    var code: String { value.code }

    /// 地域名
    var name: String { value.name }
}

/// 震度に関する情報（部分的、citiesとstationsを含まない）
struct IntensityPartial: Codable, Equatable {
    let maxIntensity: IntensityValue
    let maxLpgmIntensity: LpgmIntensityValue?
    let prefectures: [IntensityItem]
    let regions: [IntensityItem]

    // MARK: - Utility Properties

    /// 観測された最大震度の表示文字列
    var maxIntensityDisplayString: String {
        return maxIntensity.displayString
    }

    /// 最大震度を観測した都道府県のリスト
    var prefecturesWithMaxIntensity: [IntensityItem] {
        return prefectures.filter { $0.maxIntensity == maxIntensity }
    }

    /// 最大震度を観測した地域のリスト
    var regionsWithMaxIntensity: [IntensityItem] {
        return regions.filter { $0.maxIntensity == maxIntensity }
    }

    /// 震度4以上を観測した地域の数
    var regionsWithIntensity4OrHigher: Int {
        return regions.filter { item in
            guard let intensity = item.maxIntensity else { return false }
            return intensity >= .four
        }.count
    }

    /// 都道府県ごとの震度情報のサマリー
    func prefectureSummary(limit: Int = 3) -> String {
        let sorted = prefectures
            .filter { $0.maxIntensity != nil }
            .sorted { ($0.maxIntensity ?? .zero) > ($1.maxIntensity ?? .zero) }

        let display = sorted.prefix(limit)
        let names = display.map { "\($0.name)(\($0.maxIntensity?.displayString ?? "-"))" }

        if sorted.count > limit {
            return names.joined(separator: "、") + " 他"
        }
        return names.joined(separator: "、")
    }
}

// MARK: - Extensions for Filtering

extension Array where Element == IntensityItem {
    /// 指定した震度以上の項目をフィルタリング
    func filtering(minIntensity: IntensityValue) -> [IntensityItem] {
        return filter { item in
            guard let intensity = item.maxIntensity else { return false }
            return intensity >= minIntensity
        }
    }

    /// 震度順でソート（降順）
    func sortedByIntensity() -> [IntensityItem] {
        return sorted { ($0.maxIntensity ?? .zero) > ($1.maxIntensity ?? .zero) }
    }
}
