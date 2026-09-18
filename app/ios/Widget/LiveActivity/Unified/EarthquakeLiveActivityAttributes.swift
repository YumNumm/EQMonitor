//
//  EarthquakeLiveActivityAttributes.swift
//  Widget
//
//  統合 Live Activity の Attributes / ContentState。
//
//  backend 正典:
//  - packages/notification-common/src/types/unified-live-activity-content-state.ts
//  - docs/examples/unified-live-activity-content-state.json
//
//  ContentState は差分ではなく毎回スナップショット全体が届く。
//  enum 相当の値は String のまま受け取り、表示側で変換する。backend が将来
//  値を増やしても ContentState 全体のデコードが失敗して Live Activity が
//  消えることがないようにするため（旧 EewContentState と同じ方針）。
//

import ActivityKit
import Foundation

struct EarthquakeLiveActivityAttributes: ActivityAttributes, Identifiable {
    typealias ContentState = UnifiedLiveActivityContentState

    /// backend の論理 Live Activity ID。SHA-256 文字列などの不透明値で、
    /// OS の Activity ID や EEW / 地震情報の eventId とは別物。UUID ではない。
    let id: String
}

// MARK: - ContentState

struct UnifiedLiveActivityContentState: Codable, Hashable {
    /// 現行は 2。表示には使わないため、欠落でデコードを失敗させない
    let schemaVersion: Int?
    let id: String?
    let updatedAt: String?
    /// 主表示するブロック。enum 化と欠損時のフォールバックは
    /// `UnifiedLiveActivityDisplay.primary` が担う
    let primary: String?
    let shakeDetection: UnifiedShakeDetection?
    let eew: UnifiedEew?
    let earthquake: UnifiedEarthquake?
}

// MARK: - 揺れ検知

struct UnifiedShakeDetection: Codable, Hashable {
    let headline: String?
    let detectedAt: String?
    let updatedAt: String?
    /// 統合 Event に紐づく全検知の過去最大レベル
    let level: String?
    /// `active` / `ended`
    let status: String?
    /// 配信先に設定された 1 地域のみ。null は地域データなし
    let location: Location?

    struct Location: Codable, Hashable {
        let name: String?
        /// その地域における過去最大レベル
        let level: String?

        var shakeLevel: ShakeDetectionLevel? {
            level.flatMap(ShakeDetectionLevel.init(rawValue:))
        }
    }

    var shakeLevel: ShakeDetectionLevel? {
        level.flatMap(ShakeDetectionLevel.init(rawValue:))
    }

    var detectedDate: Date? { LiveActivityDate.parse(detectedAt) }
    var updatedDate: Date? { LiveActivityDate.parse(updatedAt) }

    /// 紐づく検知が全件終了した状態。ピークレベルは下げない
    var isEnded: Bool { status == "ended" }
}

// MARK: - EEW

struct UnifiedEew: Codable, Hashable {
    let eventId: String?
    let headline: String?
    let hypocenterName: String?
    let magnitude: Double?
    let depth: Double?
    let time: String?
    let isOriginTime: Bool?
    let maxIntensity: String?
    let serialNo: Int?
    /// EEW の最終報。Activity の終了ではない
    let isFinal: Bool?
    let isWarning: Bool?
    let isCanceled: Bool?
    let isPlum: Bool?
    let isLevel: Bool?
    let isOnePoint: Bool?
    let issuedAt: String?
    /// 旧 EEW Live Activity と同一の JSON 形状のため `LocationInfo` を再利用する
    let location: LocationInfo?

    var intensityValue: IntensityValue? {
        maxIntensity.flatMap(IntensityValue.init(rawValue:))
    }

    var timeDate: Date? { LiveActivityDate.parse(time) }

    /// 仮定震源要素による検知では「発生」ではなく「検知」
    var timeLabel: String {
        if isPlum == true || isLevel == true {
            return "地震検知"
        }
        return (isOriginTime ?? true) ? "地震発生" : "地震検知"
    }

    /// 取消・深発・低精度の表示判断は旧 EEW と同じ `EewDisplay` に委ねる
    var display: EewDisplay {
        EewDisplay(
            isCanceled: isCanceled == true,
            isWarning: isWarning == true,
            isFinal: isFinal == true,
            serialNo: serialNo,
            maxIntensity: intensityValue,
            forecastIntensity: location?.forecastIntensityValue,
            arrivalDate: location?.arrivalDate,
            depth: depth,
            isLowAccuracyDetection: isPlum == true || isLevel == true
                || isOnePoint == true,
            isLocationWarning: location?.isWarning == true,
            isLocationPlum: location?.isPlum == true
        )
    }
}

// MARK: - 地震情報

struct UnifiedEarthquake: Codable, Hashable {
    let eventId: String?
    let headline: String?
    /// 受信済みの電文種別を重複なく蓄積した配列
    let informationType: [String]?
    let issuedAt: String?
    let isCanceled: Bool?
    /// 震度速報のみの段階では震源が未確定
    let hypocenterName: String?
    let magnitude: UnifiedMagnitude?
    let depth: Double?
    let originTime: String?
    /// 発表された観測震度（EEW の予想震度とは別物）
    let maxIntensity: String?
    let location: Location?

    struct Location: Codable, Hashable {
        let regionName: String?
        /// その地域の観測震度。震度速報で未発表なら null
        let maxIntensity: String?

        var intensityValue: IntensityValue? {
            maxIntensity.flatMap(IntensityValue.init(rawValue:))
        }
    }

    var intensityValue: IntensityValue? {
        maxIntensity.flatMap(IntensityValue.init(rawValue:))
    }

    var originDate: Date? { LiveActivityDate.parse(originTime) }

    /// 受信済み種別のうち最も情報量の多いもの。表示名はこれに従う
    var primaryInformationType: LiveActivityInformationType? {
        informationType?
            .compactMap(LiveActivityInformationType.init(rawValue:))
            .max { $0.rank < $1.rank }
    }
}

/// 地震情報の電文種別
enum LiveActivityInformationType: String, Codable, CaseIterable {
    case vxse51 = "VXSE51"
    case vxse52 = "VXSE52"
    case vxse53 = "VXSE53"
    case ixac41 = "IXAC41"

    var displayName: String {
        switch self {
        case .vxse51: return "震度速報"
        case .vxse52: return "震源に関する情報"
        case .vxse53: return "震源・震度に関する情報"
        case .ixac41: return "推計震度分布"
        }
    }

    /// Dynamic Island など幅が限られる場所向け
    var shortName: String {
        switch self {
        case .vxse51: return "震度速報"
        case .vxse52: return "震源情報"
        case .vxse53: return "震源・震度"
        case .ixac41: return "推計震度"
        }
    }

    /// 情報量の多い順。表示名はこの順で最上位のものを使う
    var rank: Int {
        switch self {
        case .vxse53: return 3
        case .ixac41: return 2
        case .vxse52: return 1
        case .vxse51: return 0
        }
    }
}

/// 地震情報のマグニチュード。EEW の数値 magnitude とは別の union。
///
/// `UNKNOWN` は「M不明」と発表された状態、フィールドごと null は未取得。
/// この 2 つを同じ表示にしない。
struct UnifiedMagnitude: Codable, Hashable {
    let type: String?
    let value: Double?

    var displayText: String? {
        switch type {
        case "NORMAL":
            return value.map { "M" + String(format: "%.1f", $0) }
        case "UNKNOWN":
            return "M不明"
        case "OVER_M8":
            return "M8以上"
        default:
            return nil
        }
    }

    /// 巨大地震。M 表示自体を強調する
    var isOverM8: Bool { type == "OVER_M8" }
}
