import Foundation
import EQMonitorAPI

/// 表示用の見出しや現在日時のフォールバックを、地震の事実として読み上げない。
enum EarthquakeIntentDialog {
    static func summary(
        items: [EarthquakeDisplayItem], area: String, isRegional: Bool
    ) -> String {
        guard let item = items.first else {
            return "\(area)で条件に合う地震情報は見つかりませんでした。"
        }
        var sentences = ["\(area)の地震・噴火情報を\(items.count)件取得しました。最新の1件を読み上げます。"]
        if !item.status.isNormal {
            sentences.append("これは\(item.status.displayString)の情報です。")
        }
        switch item.earthquakeType {
        case .NORMAL: break
        case .DISTANT: sentences.append("遠地地震の情報です。")
        case .VOLCANO: sentences.append("火山噴火の情報です。")
        }
        sentences.append(timeDescription(item: item))
        let locationLabel = item.earthquakeType == .VOLCANO ? "発生場所" : "震源"
        if let name = item.sourceHypocenterName, !name.isEmpty {
            sentences.append("\(locationLabel)は\(name)です。")
        } else {
            sentences.append("\(locationLabel)は不明です。")
        }
        if item.earthquakeType != .VOLCANO {
            if let intensityClass = item.earthquakeMaxIntensityClass,
               let description = historicalDescription(intensityClass) {
                sentences.append("地震データベース上の分類は\(description)です。")
            } else if item.earthquakeType == .NORMAL || item.earthquakeMaxIntensity != nil {
                sentences.append("地震全体の最大震度は\(maximumIntensityLabel(item: item))です。")
            }
        }
        if isRegional {
            sentences.append("対象地域の震度は\(item.maxIntensity?.titleText ?? "不明")です。")
        }
        if item.earthquakeType == .NORMAL || item.magnitude != "M不明" {
            sentences.append("\(item.magnitude.replacingOccurrences(of: "M", with: "マグニチュード"))。")
        }
        if !item.depth.isEmpty {
            sentences.append("深さは\(item.depth.replacingOccurrences(of: "km", with: "キロメートル"))です。")
        }
        return sentences.joined()
    }

    static func timeDescription(item: EarthquakeDisplayItem) -> String {
        guard let date = item.sourceOriginTime ?? item.sourceArrivalTime else {
            return "時刻は不明です。"
        }
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ja_JP")
        formatter.timeZone = TimeZone(identifier: "Asia/Tokyo")
        let precision = item.sourceOriginTime == nil ? .MINUTE : item.originTimePrecision
        switch precision {
        case .MILLISECOND, .SECOND, .MINUTE: formatter.dateFormat = "yyyy年M月d日H時m分"
        case .HOUR: formatter.dateFormat = "yyyy年M月d日H時"
        case .DAY: formatter.dateFormat = "yyyy年M月d日"
        case .MONTH: formatter.dateFormat = "yyyy年M月"
        }
        return formatter.string(from: date) + (item.sourceOriginTime == nil ? "頃検知。" : "頃発生。")
    }

    static func maximumIntensityLabel(item: EarthquakeDisplayItem) -> String {
        guard let value = item.earthquakeMaxIntensityClass else {
            return item.earthquakeMaxIntensity?.titleText ?? "不明"
        }
        switch value {
        case .A: return "5弱"
        case .B: return "5強"
        case .C: return "6弱"
        case .D: return "6強"
        case ._1, ._2, ._3, ._4, ._5, ._6, ._7: return value.rawValue
        default: return historicalDescription(value) ?? "不明"
        }
    }

    static func historicalDescription(_ value: Components.Schemas.CatalogIntensityClass) -> String? {
        switch value {
        case ._9: return "有感であったが震度は不明"
        case .R: return "顕著地震"
        case .M: return "やや顕著地震"
        case .S: return "小局発地震"
        case .L: return "局発地震"
        case .F: return "有感"
        case .X: return "付近有感"
        default: return nil
        }
    }
}
