//
//  EewLiveActivityAttributes.swift
//  Widget
//

import ActivityKit
import SwiftUI

struct EewLiveActivityAttributes: ActivityAttributes, Identifiable {
    public typealias ContentState = EewContentState

    public var id = UUID()
    let eventId: String
}

struct EewContentState: Codable, Hashable {
    let eventId: String
    /// イベント種別（backend は "eew" を送る）。
    /// UI では使わないため optional。必須にすると backend が欠落させた瞬間に
    /// content-state 全体のデコードが失敗し Live Activity が表示されなくなる。
    let type: String?
    let hypocenterName: String?
    let magnitude: Double?
    let depth: Double?
    let time: String?
    let isOriginTime: Bool?
    let maxIntensity: String?
    let serialNo: Int?
    let isFinal: Bool?
    let isWarning: Bool?
    let isCanceled: Bool?
    let headline: String?
    let isPlum: Bool?
    let isLevel: Bool?
    let isOnePoint: Bool?
    let location: LocationInfo?

    var intensityValue: IntensityValue? {
        guard let maxIntensity = maxIntensity else { return nil }
        return IntensityValue(rawValue: maxIntensity)
    }

    var timeDate: Date? {
        LiveActivityDate.parse(time)
    }

    var timeLabel: String {
        if isPlum == true || isLevel == true {
            return "地震検知"
        }
        return (isOriginTime ?? true) ? "地震発生" : "地震検知"
    }

    /// 表示判定と文言生成。取消報での抑止ルールは [EewDisplay] に集約している。
    var display: EewDisplay {
        EewDisplay(
            isCanceled: isCanceled == true,
            isWarning: isWarning == true,
            isFinal: isFinal == true,
            serialNo: serialNo,
            maxIntensity: intensityValue,
            forecastIntensity: location?.forecastIntensityValue,
            arrivalDate: location?.arrivalDate
        )
    }
}

extension EewLiveActivityAttributes {
    func prefixedKey(_ key: String) -> String {
        return "\(id)_\(key)"
    }
}

// MARK: - Preview Data

extension EewContentState {
    static let noto32 = EewContentState(
        eventId: "20240101123456",
        type: "eew",
        hypocenterName: "石川県能登地方",
        magnitude: 7.6,
        depth: 10,
        time: "2024-01-01T16:10:00+09:00",
        isOriginTime: true,
        maxIntensity: "6+",
        serialNo: 32,
        isFinal: false,
        isWarning: true,
        isCanceled: false,
        headline: "石川県で地震 北陸で強い揺れ",
        isPlum: false,
        isLevel: false,
        isOnePoint: false,
        location: LocationInfo(
            regionName: "東京都23区",
            forecastIntensity: "5-",
            forecastLpgmIntensity: "2",
            arrivalTime: "2024-01-01T16:12:30+09:00",
            intensity: nil
        )
    )

    static let notoFinal = EewContentState(
        eventId: "20240101123456",
        type: "eew",
        hypocenterName: "石川県能登地方",
        magnitude: 7.6,
        depth: 16,
        time: "2024-01-01T16:10:00+09:00",
        isOriginTime: true,
        maxIntensity: "7",
        serialNo: 47,
        isFinal: true,
        isWarning: true,
        isCanceled: false,
        headline: "石川県で地震 北陸で強い揺れ",
        isPlum: false,
        isLevel: false,
        isOnePoint: false,
        location: nil
    )

    static let ibarakiForecast = EewContentState(
        eventId: "20240102123456",
        type: "eew",
        hypocenterName: "茨城県沖",
        magnitude: 4.2,
        depth: 40,
        time: "2024-01-02T12:34:56+09:00",
        isOriginTime: true,
        maxIntensity: "3",
        serialNo: 1,
        isFinal: false,
        isWarning: false,
        isCanceled: false,
        headline: "茨城県沖で地震",
        isPlum: false,
        isLevel: false,
        isOnePoint: false,
        location: nil
    )

    static let plum = EewContentState(
        eventId: "20240103123456",
        type: "eew",
        hypocenterName: "関東地方",
        magnitude: nil,
        depth: nil,
        time: "2024-01-03T16:10:00+09:00",
        isOriginTime: true,
        maxIntensity: "5-",
        serialNo: 1,
        isFinal: false,
        isWarning: false,
        isCanceled: false,
        headline: "関東地方で地震",
        isPlum: true,
        isLevel: false,
        isOnePoint: false,
        location: LocationInfo(
            regionName: "東京都23区",
            forecastIntensity: "4",
            forecastLpgmIntensity: nil,
            arrivalTime: nil,
            intensity: nil
        )
    )

    static let levelMethod = EewContentState(
        eventId: "20240104123456",
        type: "eew",
        hypocenterName: "仮定震源",
        magnitude: nil,
        depth: nil,
        time: "2024-01-04T16:10:00+09:00",
        isOriginTime: false,
        maxIntensity: "4",
        serialNo: 1,
        isFinal: false,
        isWarning: false,
        isCanceled: false,
        headline: "地震発生",
        isPlum: false,
        isLevel: true,
        isOnePoint: false,
        location: LocationInfo(
            regionName: "神奈川県東部",
            forecastIntensity: "3",
            forecastLpgmIntensity: nil,
            arrivalTime: nil,
            intensity: nil
        )
    )

    static let canceled = EewContentState(
        eventId: "20240106123456",
        type: "eew",
        hypocenterName: nil,
        magnitude: nil,
        depth: nil,
        time: nil,
        isOriginTime: false,
        maxIntensity: nil,
        serialNo: 2,
        isFinal: true,
        isWarning: false,
        isCanceled: true,
        headline: "地震発生",
        isPlum: false,
        isLevel: false,
        isOnePoint: false,
        location: nil
    )

    /// 取消報だが backend が震源・予想震度・到達予想を残したまま送ってきたケース。
    /// 取消なのに「最大震度6強」「到達まで」が出ないことを確認するためのプレビュー。
    static let canceledWithStaleValues = EewContentState(
        eventId: "20240106123456",
        type: "eew",
        hypocenterName: "石川県能登地方",
        magnitude: 7.6,
        depth: 10,
        time: "2024-01-06T16:10:00+09:00",
        isOriginTime: true,
        maxIntensity: "6+",
        serialNo: 2,
        isFinal: true,
        isWarning: true,
        isCanceled: true,
        headline: "石川県で地震 北陸で強い揺れ",
        isPlum: false,
        isLevel: false,
        isOnePoint: false,
        location: LocationInfo(
            regionName: "東京都23区",
            forecastIntensity: "5-",
            forecastLpgmIntensity: "2",
            arrivalTime: "2024-01-06T16:12:30+09:00",
            intensity: nil
        )
    )

    static let onePoint = EewContentState(
        eventId: "20240105123456",
        type: "eew",
        hypocenterName: "茨城県沖",
        magnitude: 4.0,
        depth: 30,
        time: "2024-01-05T16:10:00+09:00",
        isOriginTime: true,
        maxIntensity: "3",
        serialNo: 1,
        isFinal: false,
        isWarning: false,
        isCanceled: false,
        headline: "茨城県沖で地震",
        isPlum: false,
        isLevel: false,
        isOnePoint: true,
        location: nil
    )
}
