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

/// バッジに描く震度。
///
/// 予想震度は震源が深い場合など JMA が発表しない報がある。値が無いときに
/// バッジごと消すと「震度の欄が存在しない」ように見え、震度が発表されて
/// いないのか表示が壊れているのか区別できない。アプリ本体の EEW カードが
/// `JmaIntensity.unknown`（「不明」）を出しているのと同じく、
/// 「不明」も震度と同じ形で扱えるようにする。
enum EewIntensityBadge: Equatable {
    case value(IntensityValue)
    /// 予想震度が発表されていない / 届いていない
    case unknown

    /// 値が無い場合を「不明」として扱う
    init(_ intensity: IntensityValue?) {
        guard let intensity else {
            self = .unknown
            return
        }
        self = .value(intensity)
    }

    /// 「不明」の文言。アプリ本体の `JmaIntensity.unknown.label` に揃える。
    static let unknownText = "不明"

    /// バッジに描く文字。「不明」は震度階級ではないため弱/強の suffix を持たない。
    var parts: (main: String, sub: String?) {
        switch self {
        case let .value(intensity):
            return intensity.formattedParts
        case .unknown:
            return (Self.unknownText, nil)
        }
    }
}

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
    /// 全国の予想最大震度。震源が深い場合など JMA が予想震度を発表しない報では nil
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

    /// 面積が限られる場所（Dynamic Island）に描く震度バッジ。
    /// 震度が発表されていない報でも欄を空けず「不明」を描く。
    /// 取消報だけは震度そのものが無効なため、欄ごと出さない。
    var intensityBadge: EewIntensityBadge? {
        isCanceled ? nil : EewIntensityBadge(intensity)
    }

    /// Lock Screen 左の「最大震度」欄に描くバッジ。
    /// 現在地の予想震度は別枠で出すため、ここは全国の予想最大震度だけを見る。
    var maxIntensityBadge: EewIntensityBadge? {
        isCanceled ? nil : EewIntensityBadge(maxIntensity)
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

    /// 取消報の主文。Lock Screen と Dynamic Island で文言を揃える。
    static let canceledTitle = "緊急地震速報は取り消されました"

    /// 取消報の補足。震度や到達予想を出していない理由を伝える。
    static let canceledDescription = "予想震度・主要動到達の予想は無効です"
}
