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
    /// 震源の深さ(km)
    let depth: Double?
    /// PLUM法・レベル法・1点検知など、仮定震源要素による低精度の検知か
    let isLowAccuracyDetection: Bool
    var isLocationWarning: Bool = false
    var isLocationPlum: Bool = false

    // MARK: - 表示可否

    /// 震源・規模・深さ・発生時刻を表示してよいか。取消報ではすべて無効。
    var showsEarthquakeDetails: Bool { !isCanceled }

    /// 面積が限られる場所に出す震度。現在地の予想震度を優先し、
    /// 無ければ全国の最大震度にフォールバックする。取消報では出さない。
    var intensity: IntensityValue? {
        guard !isCanceled else { return nil }
        return localIntensity ?? maxIntensity
    }

    /// 予報では現在地の予想震度4以上のみ表示する。警報でも未提供の値は補わない。
    var localIntensity: IntensityValue? {
        guard !isCanceled, let forecastIntensity,
              isWarning || forecastIntensity >= .four else { return nil }
        return forecastIntensity
    }

    var usesLocalIntensity: Bool { localIntensity != nil }

    var showsEventTime: Bool { !isCanceled && !usesLocalIntensity }

    var locationNotice: EewLocationNotice? {
        guard !isCanceled else { return nil }
        if isWarning && isLocationWarning { return .warning }
        if let localIntensity { return localIntensity < .two ? .weak : .forecast }
        return nil
    }

    /// [intensity] がどちらの震度かを示すラベル
    var intensityLabel: String {
        usesLocalIntensity ? "予想震度" : "最大震度"
    }

    /// 主要動到達カウントダウンに使う時刻。取消報では到達予想も無効。
    var countdownArrivalDate: Date? {
        usesLocalIntensity && !isLocationPlum ? arrivalDate : nil
    }

    /// 深発地震のため予想震度が発表されない旨の注釈を出すか。
    ///
    /// JMA は震源が深さ 150km より深い場合、予想震度・主要動到達時刻を発表しない。
    /// ただし「150km より深い」ことと「予想震度が無い」ことは同値ではないため、
    /// 未発表かつ深発で、PLUM 法など別の理由がないときに限って理由を添える。
    var showsDeepHypocenterIntensityNotice: Bool {
        guard !isCanceled, !isLowAccuracyDetection, maxIntensity == nil,
              let depth
        else {
            return false
        }
        return depth > Self.deepHypocenterDepthThreshold
    }

    /// Dynamic Island 展開時に何を主役にするか
    var dynamicIslandLayout: EewDynamicIslandLayout {
        if isCanceled {
            return .canceled
        }
        return countdownArrivalDate != nil ? .countdown : .summary
    }

    // MARK: - 文言

    /// 取消時は種別を付けず、見出しで取り消された事実を伝える。
    var typeLabel: String {
        if isCanceled {
            return "緊急地震速報"
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

    static let canceledTitle = "先ほどの緊急地震速報は取り消されました"

    // MARK: - 深発地震の文言

    /// JMA が予想震度を発表しなくなる深さ(km)。アプリ本体の
    /// `EewDeepHypocenterIntensityNotice` と同じ基準にする。
    static let deepHypocenterDepthThreshold: Double = 150
    static let deepHypocenterIntensityNotice = "震源の深さが150kmより深いため、予想震度は発表されていません"
}

enum EewLocationNotice: Equatable {
    case warning
    case forecast
    case weak

    var title: String {
        switch self {
        case .warning: return "現在地で強い揺れ"
        case .forecast: return "現在地で揺れ"
        case .weak: return "現在地で弱い揺れ"
        }
    }
}
