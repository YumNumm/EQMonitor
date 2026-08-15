//
//  EewDisplay.swift
//  Shared (WidgetExtension / WidgetModelsTests)
//
//  EEW Live Activity の表示判定と文言生成。
//
//  取消報で予想震度や主要動到達カウントダウンを出すと誤情報になるため、
//  「何を出すか」の判断を View から切り離してここへ集約し、テストで固定する。
//  Lock Screen と Dynamic Island で判断が食い違わないようにする目的も兼ねる。
//

import Foundation

struct EewDisplay: Equatable {
    let isCanceled: Bool
    let isWarning: Bool
    let isFinal: Bool
    let serialNo: Int?
    /// 全国の予想最大震度
    let maxIntensity: IntensityValue?
    /// 現在地の予想震度
    let forecastIntensity: IntensityValue?
    let arrivalDate: Date?

    // MARK: - 表示可否

    /// 震源・規模・深さ・発生時刻を表示してよいか。取消報ではすべて無効。
    var showsEarthquakeDetails: Bool { !isCanceled }

    /// 面積が限られる場所に出す震度。現在地の予想震度を優先し、
    /// 無ければ全国の最大震度にフォールバックする。取消報では出さない。
    var intensity: IntensityValue? {
        guard !isCanceled else { return nil }
        return forecastIntensity ?? maxIntensity
    }

    /// [intensity] がどちらの震度かを示すラベル
    var intensityLabel: String {
        forecastIntensity != nil ? "予想震度" : "最大震度"
    }

    /// 主要動到達カウントダウンに使う時刻。取消報では到達予想も無効。
    var countdownArrivalDate: Date? {
        isCanceled ? nil : arrivalDate
    }

    // MARK: - 文言

    /// 「緊急地震速報(警報)」「緊急地震速報(予報)」「緊急地震速報(取消)」
    var typeLabel: String {
        if isCanceled {
            return "緊急地震速報(取消)"
        }
        return isWarning ? "緊急地震速報(警報)" : "緊急地震速報(予報)"
    }

    /// 「第32報」「最終 第47報」。報番号が無い場合は nil。
    var serialLabel: String? {
        guard let serialNo, serialNo > 0 else { return nil }
        return isFinal ? "最終 第\(serialNo)報" : "第\(serialNo)報"
    }

    /// Lock Screen ヘッダーの見出し。「緊急地震速報(警報) 最終 第32報」
    var headerLabel: String {
        guard let serialLabel else { return typeLabel }
        return "\(typeLabel) \(serialLabel)"
    }

    /// ヘッダーに出す headline。取消報では「地震発生」等が残るため出さない。
    func headline(from raw: String?) -> String? {
        guard !isCanceled, let raw, !raw.isEmpty else { return nil }
        return raw
    }
}
