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

/// Dynamic Island 展開時のレイアウト。
///
/// 展開領域は狭く、要素を並べるほど切り取られて読めなくなる。
/// Apple のタイマー / アラームと同じく「主役を 1 つに絞る」方針で、
/// 状況ごとにどの情報を主役にするかをここで決める。
enum EewDynamicIslandLayout: Equatable {
    /// 取消報。取消の事実だけを伝える。
    case canceled
    /// 主要動到達までのカウントダウンを主役にする（現在地の予想震度と対で見せる）。
    case countdown
    /// 到達予想が無い場合。予想最大震度と震源要素を見せる。
    case summary
}

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

    /// Dynamic Island 展開時に何を主役にするか
    var dynamicIslandLayout: EewDynamicIslandLayout {
        if isCanceled {
            return .canceled
        }
        return countdownArrivalDate != nil ? .countdown : .summary
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

    /// backend の headline をそのまま出してよいか判断する。
    /// 取消報では「地震発生」等が残るため出さない。
    func headline(from raw: String?) -> String? {
        guard !isCanceled, let raw, !raw.isEmpty else { return nil }
        return raw
    }

    /// ヘッダーの見出し行。取消報では backend の headline を捨て、取消の主文に差し替える。
    func headerHeadline(from raw: String?) -> String? {
        isCanceled ? Self.canceledTitle : headline(from: raw)
    }

    // MARK: - 取消報の文言

    static let canceledTitle = "緊急地震速報は取り消されました"
    static let canceledDescription = "予想震度・主要動到達の予想は無効です"
}
