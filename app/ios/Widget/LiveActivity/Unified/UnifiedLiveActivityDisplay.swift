//
//  UnifiedLiveActivityDisplay.swift
//  Widget
//
//  統合 Live Activity の「何を・どの色で出すか」の判断。
//
//  Lock Screen と Dynamic Island で判断が食い違わないよう、View から切り離して
//  ここへ集約する（旧 EEW の `EewDisplay` と同じ方針）。
//

import SwiftUI

/// 主表示するブロック
enum UnifiedPrimaryBlock: Equatable {
    case shakeDetection
    case eew
    case earthquake
    /// どのブロックも届いていない。通常は起こらないが表示を空にしない
    case empty
}

struct UnifiedLiveActivityDisplay {
    let state: UnifiedLiveActivityContentState

    init(_ state: UnifiedLiveActivityContentState) {
        self.state = state
    }

    // MARK: - 主表示の決定

    /// backend が指定した `primary` に従う。到達予想時刻などで切り替えない。
    ///
    /// 指定されたブロックが欠けている場合と未知の値が来た場合だけ、backend と
    /// 同じ `earthquake > eew > shake_detection` の優先順位で代替を選ぶ。
    var primary: UnifiedPrimaryBlock {
        switch state.primary {
        case "earthquake" where state.earthquake != nil:
            return .earthquake
        case "eew" where state.eew != nil:
            return .eew
        case "shake_detection" where state.shakeDetection != nil:
            return .shakeDetection
        default:
            return fallbackPrimary
        }
    }

    private var fallbackPrimary: UnifiedPrimaryBlock {
        if state.earthquake != nil { return .earthquake }
        if state.eew != nil { return .eew }
        if state.shakeDetection != nil { return .shakeDetection }
        return .empty
    }

    var shakeDetection: UnifiedShakeDetection? { state.shakeDetection }
    var eew: UnifiedEew? { state.eew }
    var earthquake: UnifiedEarthquake? { state.earthquake }

    /// 主表示が地震情報のときだけ、直前まで出ていた EEW を 1 行で添える。
    /// 揺れ検知は副次表示しない（主表示のときだけ出す）。
    var eewStrip: UnifiedEew? {
        primary == .earthquake ? state.eew : nil
    }

    // MARK: - 文言

    /// ヘッダー左上の種別ラベル
    var typeLabel: String {
        switch primary {
        case .shakeDetection:
            return "揺れ検知"
        case .eew:
            return state.eew?.display.headerLabel ?? "緊急地震速報"
        case .earthquake:
            guard let earthquake = state.earthquake else { return "地震情報" }
            return earthquake.primaryInformationType?.displayName ?? "地震情報"
        case .empty:
            return "地震情報"
        }
    }

    /// ヘッダーの見出し。取消報では backend の headline を捨て、取消の主文に差し替える
    var headline: String? {
        switch primary {
        case .shakeDetection:
            return state.shakeDetection?.headline
        case .eew:
            guard let eew = state.eew else { return nil }
            return eew.display.headerHeadline(from: eew.headline)
        case .earthquake:
            guard let earthquake = state.earthquake else { return nil }
            return earthquake.headline
        case .empty:
            return nil
        }
    }

    // MARK: - ヘッダー右の震度・レベル

    /// 震度速報を受信済みなら、見出しに含まれる最大震度を右側で繰り返さない。
    var lockScreenHeaderIntensity: IntensityValue? {
        if primary == .earthquake,
           state.earthquake?.informationType?.contains("VXSE51") == true {
            return nil
        }
        return headerIntensity
    }

    /// ヘッダー右に出す最大震度。揺れ検知は震度を持たないため nil
    var headerIntensity: IntensityValue? {
        switch primary {
        case .eew:
            guard let eew = state.eew, eew.isCanceled != true else { return nil }
            return eew.intensityValue
        case .earthquake:
            guard let earthquake = state.earthquake else { return nil }
            return earthquake.intensityValue
        case .shakeDetection, .empty:
            return nil
        }
    }

    /// ヘッダー右に出す揺れレベル（イベント全体のピーク）
    var headerShakeLevel: ShakeDetectionLevel? {
        primary == .shakeDetection ? state.shakeDetection?.shakeLevel : nil
    }

    /// 震度バッジに重ねる出所 Chip。揺れレベルには付けない
    var intensitySource: IntensitySource? {
        switch primary {
        case .eew: return .forecast
        case .earthquake: return .observed
        case .shakeDetection, .empty: return nil
        }
    }

    // MARK: - 現在地

    /// 現在地の地域名。欠損値から場所を推測しない
    var locationName: String? {
        let name: String? = switch primary {
        case .shakeDetection: state.shakeDetection?.location?.name
        case .eew: state.eew?.location?.regionName
        case .earthquake: state.earthquake?.location?.regionName
        case .empty: nil
        }
        guard let name, !name.isEmpty else { return nil }
        return name
    }

    /// 現在地の震度。EEW は既存方針（予報は震度4以上のみ）を引き継ぐ
    var locationIntensity: IntensityValue? {
        switch primary {
        case .eew:
            return state.eew?.display.localIntensity
        case .earthquake:
            return state.earthquake?.location?.intensityValue
        case .shakeDetection, .empty:
            return nil
        }
    }

    /// 現在地の揺れレベル（その地域のピーク）
    var locationShakeLevel: ShakeDetectionLevel? {
        primary == .shakeDetection ? state.shakeDetection?.location?.shakeLevel : nil
    }

    /// 現在地ブロックを出すか
    var showsLocation: Bool {
        guard locationName != nil else { return false }
        return locationIntensity != nil || locationShakeLevel != nil
            || primary == .earthquake || primary == .shakeDetection
    }

    // MARK: - 色

    /// ヘッダー背景。震度バッジの配色をそのまま敷くと震度4（黄）などで
    /// 白文字が読めなくなるため、濃色へ寄せた別系統を持つ。
    var headerBackgroundColor: Color {
        switch primary {
        case .shakeDetection:
            return state.shakeDetection?.shakeLevel?.headerBackgroundColor
                ?? Self.neutralHeaderColor
        case .eew:
            guard let display = state.eew?.display else { return Self.neutralHeaderColor }
            if display.isCanceled { return Color(red: 0.4, green: 0.4, blue: 0.4) }
            return display.isWarning
                ? Color(red: 0.7, green: 0.1, blue: 0.1)
                : Color(red: 0.8, green: 0.4, blue: 0.05)
        case .earthquake:
            guard let earthquake = state.earthquake else { return Self.neutralHeaderColor }
            return Self.earthquakeHeaderColor(for: earthquake.intensityValue)
        case .empty:
            return Self.neutralHeaderColor
        }
    }

    /// ヘッダー上端のストライプ
    var stripeColors: [Color] {
        switch primary {
        case .shakeDetection:
            return state.shakeDetection?.shakeLevel?.stripeColors ?? Self.neutralStripeColors
        case .eew:
            guard let display = state.eew?.display else { return Self.neutralStripeColors }
            if display.isCanceled { return Self.neutralStripeColors }
            return display.isWarning
                ? [Color.red, Color.black]
                : [Color.orange, Color(red: 0.5, green: 0.25, blue: 0.0)]
        case .earthquake:
            guard let earthquake = state.earthquake else { return Self.neutralStripeColors }
            return Self.earthquakeStripeColors(for: earthquake.intensityValue)
        case .empty:
            return Self.neutralStripeColors
        }
    }

    /// Dynamic Island の輪郭色
    var keylineTint: Color {
        switch primary {
        case .shakeDetection:
            return state.shakeDetection?.shakeLevel?.backgroundColor ?? .gray
        case .eew:
            guard let display = state.eew?.display else { return .gray }
            if display.isCanceled { return .gray }
            return display.isWarning ? .red : .orange
        case .earthquake:
            guard let earthquake = state.earthquake else { return .gray }
            return earthquake.intensityValue?.backgroundColor ?? .gray
        case .empty:
            return .gray
        }
    }

    private static let neutralHeaderColor = Color(red: 0.30, green: 0.34, blue: 0.40)
    private static let neutralStripeColors = [
        Color(red: 0.5, green: 0.5, blue: 0.5),
        Color(red: 0.25, green: 0.25, blue: 0.25),
    ]

    /// 観測震度に応じた濃色ヘッダー。EEW の警報赤 / 予報橙と同じ濃さに揃える
    static func earthquakeHeaderColor(for intensity: IntensityValue?) -> Color {
        guard let intensity else { return neutralHeaderColor }
        switch intensity.dangerLevel {
        case 0: return Color(red: 0.22, green: 0.40, blue: 0.58)
        case 1: return Color(red: 0.10, green: 0.45, blue: 0.35)
        case 2: return Color(red: 0.80, green: 0.45, blue: 0.05)
        case 3: return Color(red: 0.75, green: 0.18, blue: 0.08)
        default: return Color(red: 0.55, green: 0.04, blue: 0.16)
        }
    }

    static func earthquakeStripeColors(for intensity: IntensityValue?) -> [Color] {
        let base = earthquakeHeaderColor(for: intensity)
        return [base, .black.opacity(0.75)]
    }
}

/// 震度バッジに重ねる出所 Chip の種類
enum IntensitySource: Hashable {
    /// 緊急地震速報の予想震度
    case forecast
    /// 地震情報の観測震度
    case observed

    var label: String {
        switch self {
        case .forecast: return "予想"
        case .observed: return "観測"
        }
    }

    var maximumLabel: String {
        switch self {
        case .forecast: return "最大予想"
        case .observed: return "最大観測"
        }
    }
}
