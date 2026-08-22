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

    /// 主要動到達カウントダウンを主役にするレイアウトのプレビュー。
    /// 固定日時では常に 00:00 になってしまうため、実行時刻から到達予想を作る。
    static func countingDown(secondsUntilArrival: TimeInterval = 30) -> EewContentState {
        let formatter = ISO8601DateFormatter()
        return EewContentState(
            eventId: "20240101123456",
            type: "eew",
            hypocenterName: "石川県能登地方",
            magnitude: 7.6,
            depth: 10,
            time: formatter.string(from: Date()),
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
                arrivalTime: formatter.string(
                    from: Date().addingTimeInterval(secondsUntilArrival)
                ),
                intensity: nil
            )
        )
    }

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

// MARK: - Preview Sequences

/// 実際の EEW は 1 つのイベントに対して報を重ね、規模・予想震度・警報/予報の別が
/// 更新されていく。Live Activity は同じ Activity を更新し続けるため、
/// 単発の状態だけでなく「報が進んだときに破綻しないか」を見る必要がある。
/// ここでは報の進行を系列として持ち、プレビューで State を切り替えて確認する。
///
/// 主要動到達の予想時刻は実行時刻からの相対で作る。固定日時にすると
/// カウントダウンが常に 00:00 になり、残り時間の表示を確認できない。
extension EewContentState {
    /// 予報の第1報から警報へ切り替わり、最終報まで規模と予想震度が上がっていく流れ。
    static func warningSequence(from now: Date = Date()) -> [EewContentState] {
        let originTime = now.addingTimeInterval(-8)
        return [
            notoReport(
                serialNo: 1,
                magnitude: 4.9,
                depth: 10,
                maxIntensity: "4",
                isWarning: false,
                headline: "石川県で地震",
                forecastIntensity: "3",
                originTime: originTime,
                arrivalTime: now.addingTimeInterval(32)
            ),
            notoReport(
                serialNo: 2,
                magnitude: 6.1,
                depth: 10,
                maxIntensity: "5+",
                isWarning: true,
                headline: "石川県で地震 北陸で強い揺れ",
                forecastIntensity: "5-",
                originTime: originTime,
                arrivalTime: now.addingTimeInterval(26)
            ),
            notoReport(
                serialNo: 4,
                magnitude: 6.9,
                depth: 10,
                maxIntensity: "6-",
                isWarning: true,
                headline: "石川県で地震 北陸で強い揺れ",
                forecastIntensity: "5+",
                originTime: originTime,
                arrivalTime: now.addingTimeInterval(16)
            ),
            notoReport(
                serialNo: 8,
                magnitude: 7.4,
                depth: 10,
                maxIntensity: "6+",
                isWarning: true,
                headline: "石川県で地震 北陸で強い揺れ",
                forecastIntensity: "6-",
                originTime: originTime,
                arrivalTime: now.addingTimeInterval(6)
            ),
            // 主要動が到達し、カウントダウンが 00:00 で止まっている状態
            notoReport(
                serialNo: 32,
                magnitude: 7.6,
                depth: 16,
                maxIntensity: "7",
                isWarning: true,
                headline: "石川県で地震 北陸で強い揺れ",
                forecastIntensity: "6-",
                originTime: originTime,
                arrivalTime: now.addingTimeInterval(-12)
            ),
            notoReport(
                serialNo: 47,
                magnitude: 7.6,
                depth: 16,
                maxIntensity: "7",
                isWarning: true,
                headline: "石川県で地震 北陸で強い揺れ",
                forecastIntensity: "6-",
                originTime: originTime,
                arrivalTime: now.addingTimeInterval(-12),
                isFinal: true
            ),
        ]
    }

    /// 予報のまま推移し、最後に取消となる流れ。
    /// 取消報で震源・予想震度・到達予想が消えることを確認する。
    static func canceledSequence(from now: Date = Date()) -> [EewContentState] {
        let originTime = now.addingTimeInterval(-6)
        return [
            ibarakiForecastReport(
                serialNo: 1,
                magnitude: 4.2,
                maxIntensity: "3",
                originTime: originTime,
                arrivalTime: now.addingTimeInterval(18)
            ),
            ibarakiForecastReport(
                serialNo: 2,
                magnitude: 4.8,
                maxIntensity: "4",
                originTime: originTime,
                arrivalTime: now.addingTimeInterval(10)
            ),
            EewContentState(
                eventId: "20240102123456",
                type: "eew",
                hypocenterName: nil,
                magnitude: nil,
                depth: nil,
                time: nil,
                isOriginTime: false,
                maxIntensity: nil,
                serialNo: 3,
                isFinal: true,
                isWarning: false,
                isCanceled: true,
                headline: "茨城県沖で地震",
                isPlum: false,
                isLevel: false,
                isOnePoint: false,
                location: nil
            ),
        ]
    }

    private static func notoReport(
        serialNo: Int,
        magnitude: Double,
        depth: Double,
        maxIntensity: String,
        isWarning: Bool,
        headline: String,
        forecastIntensity: String,
        originTime: Date,
        arrivalTime: Date,
        isFinal: Bool = false
    ) -> EewContentState {
        let formatter = ISO8601DateFormatter()
        return EewContentState(
            eventId: "20240101161009",
            type: "eew",
            hypocenterName: "石川県能登地方",
            magnitude: magnitude,
            depth: depth,
            time: formatter.string(from: originTime),
            isOriginTime: true,
            maxIntensity: maxIntensity,
            serialNo: serialNo,
            isFinal: isFinal,
            isWarning: isWarning,
            isCanceled: false,
            headline: headline,
            isPlum: false,
            isLevel: false,
            isOnePoint: false,
            location: LocationInfo(
                regionName: "富山県東部",
                forecastIntensity: forecastIntensity,
                forecastLpgmIntensity: nil,
                arrivalTime: formatter.string(from: arrivalTime),
                intensity: nil
            )
        )
    }

    private static func ibarakiForecastReport(
        serialNo: Int,
        magnitude: Double,
        maxIntensity: String,
        originTime: Date,
        arrivalTime: Date
    ) -> EewContentState {
        let formatter = ISO8601DateFormatter()
        return EewContentState(
            eventId: "20240102123456",
            type: "eew",
            hypocenterName: "茨城県沖",
            magnitude: magnitude,
            depth: 40,
            time: formatter.string(from: originTime),
            isOriginTime: true,
            maxIntensity: maxIntensity,
            serialNo: serialNo,
            isFinal: false,
            isWarning: false,
            isCanceled: false,
            headline: "茨城県沖で地震",
            isPlum: false,
            isLevel: false,
            isOnePoint: false,
            location: LocationInfo(
                regionName: "東京都23区",
                forecastIntensity: "2",
                forecastLpgmIntensity: nil,
                arrivalTime: formatter.string(from: arrivalTime),
                intensity: nil
            )
        )
    }
}
