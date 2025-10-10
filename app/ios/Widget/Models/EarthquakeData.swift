//
//  EarthquakeData.swift
//  Widget
//
//  Created by Widget Generator
//

import Foundation

// API Response
struct EarthquakeResponse: Codable {
    let data: [EarthquakeData]
}

struct EarthquakeData: Codable {
    let id: Int
    let status: String
    let magnitude: Double?
    let magnitudeCondition: String?
    let maxIntensity: String?
    let maxLpgmIntensity: String?
    let hypocenter: HypocenterData?
    let arrivalTime: String
    let originTime: String
    let headline: String?
    let text: String?
}

struct HypocenterData: Codable {
    let coordinates: Coordinates
    let depth: Double?
    let code: Int
    let detailCode: Int?
}

struct Coordinates: Codable {
    let latitude: Double
    let longitude: Double
}

// Widget用モデル
struct EarthquakeItem: Identifiable {
    let id: String
    let magnitude: Double?
    let magnitudeCondition: String?
    let maxIntensity: String?
    let hypocenterName: String
    let depth: Double?
    let originTime: Date
    let headline: String?

    init(from data: EarthquakeData) {
        self.id = String(data.id)
        self.magnitude = data.magnitude
        self.magnitudeCondition = data.magnitudeCondition
        self.maxIntensity = data.maxIntensity

        // hypocenterがnilの場合の処理
        if let hypocenter = data.hypocenter {
            self.hypocenterName = EpicenterLoader.getName(forCode: hypocenter.code)
            self.depth = hypocenter.depth
        } else {
            self.hypocenterName = "震源地不明"
            self.depth = nil
        }

        // originTimeのパース: "2025-10-10 21:24:00+09" 形式
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd HH:mm:ssZ"
        inputFormatter.locale = Locale(identifier: "en_US_POSIX")

        // +09を+0900に変換
        let normalizedTime = data.originTime.replacingOccurrences(of: "+09", with: "+0900")
        self.originTime = inputFormatter.date(from: normalizedTime) ?? Date()

        self.headline = data.headline
    }

    // 直接初期化用（プレビュー・モックデータ用）
    init(
        id: String,
        magnitude: Double?,
        magnitudeCondition: String?,
        maxIntensity: String?,
        hypocenterName: String,
        depth: Double?,
        originTime: Date,
        headline: String?
    ) {
        self.id = id
        self.magnitude = magnitude
        self.magnitudeCondition = magnitudeCondition
        self.maxIntensity = maxIntensity
        self.hypocenterName = hypocenterName
        self.depth = depth
        self.originTime = originTime
        self.headline = headline
    }

    var formattedMagnitude: String {
        if let value = magnitude {
            return String(format: "M%.1f", value)
        } else if let condition = magnitudeCondition {
            return "M\(condition)"
        }
        return "M不明"
    }

    var formattedDepth: String {
        if let value = depth {
            if value == 0 || value < 10 {
                return "ごく浅い"
            }
            return "\(Int(value))km"
        }
        return "不明"
    }

    var formattedIntensity: (main: String, sub: String?) {
        guard let intensity = maxIntensity else { return ("-", nil) }

        // 5-, 5+, 6-, 6+ の場合に分割
        if intensity.count >= 2 {
            let firstChar = String(intensity.prefix(1))
            let rest = String(intensity.dropFirst())

            if rest == "-" {
                return (firstChar, "弱")
            } else if rest == "+" {
                return (firstChar, "強")
            }
        }

        return (intensity, nil)
    }

    var relativeTime: String {
        let now = Date()
        let interval = now.timeIntervalSince(originTime)

        if interval < 60 {
            return "数秒前"
        } else if interval < 3600 {
            let minutes = Int(interval / 60)
            return "\(minutes)分前"
        } else if interval < 86400 {
            let hours = Int(interval / 3600)
            return "\(hours)時間前"
        } else {
            let days = Int(interval / 86400)
            return "\(days)日前"
        }
    }
}
