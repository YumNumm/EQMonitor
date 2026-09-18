//
//  UnifiedLiveActivityPreviewData.swift
//  Widget
//
//  統合 Live Activity のデザイン確認用データ。
//
//  到達カウントダウンや経過時間は固定日時にすると常に同じ値で張り付き、
//  表示を確認できない。実行時刻を基準に組み立てる。
//

import Foundation

enum UnifiedPreviewISO {
    /// backend と同じ JST オフセット付き・小数秒なしの ISO8601
    static func string(_ date: Date) -> String {
        let formatter = ISO8601DateFormatter()
        formatter.timeZone = TimeZone(identifier: "Asia/Tokyo")
        formatter.formatOptions = [.withInternetDateTime]
        return formatter.string(from: date)
    }
}

// MARK: - 組み立てヘルパー

extension UnifiedLiveActivityContentState {
    /// backend の実値に合わせた 64 文字 SHA-256 形式の ID。UUID ではない
    static let previewId =
        "9f2c1d4e6a8b0c2d4e6f8a0b2c4d6e8f0a2b4c6d8e0f2a4b6c8d0e2f4a6b8c0d"

    static func preview(
        primary: String,
        shakeDetection: UnifiedShakeDetection? = nil,
        eew: UnifiedEew? = nil,
        earthquake: UnifiedEarthquake? = nil,
        now: Date = Date()
    ) -> UnifiedLiveActivityContentState {
        UnifiedLiveActivityContentState(
            schemaVersion: 2,
            id: previewId,
            updatedAt: UnifiedPreviewISO.string(now),
            primary: primary,
            shakeDetection: shakeDetection,
            eew: eew,
            earthquake: earthquake
        )
    }
}

extension UnifiedShakeDetection {
    static func preview(
        headline: String = "関東地方で揺れを検知しました",
        level: String,
        status: String = "active",
        detectedAt: Date,
        updatedAt: Date,
        locationName: String? = "東京都２３区",
        locationLevel: String? = nil
    ) -> UnifiedShakeDetection {
        UnifiedShakeDetection(
            headline: headline,
            detectedAt: UnifiedPreviewISO.string(detectedAt),
            updatedAt: UnifiedPreviewISO.string(updatedAt),
            level: level,
            status: status,
            location: locationName.map {
                Location(name: $0, level: locationLevel ?? level)
            }
        )
    }
}

extension UnifiedEew {
    static func preview(
        eventId: String = "20260911123456",
        headline: String = "茨城県沖で地震 関東地方で強い揺れ",
        hypocenterName: String? = "茨城県沖",
        magnitude: Double? = 6.8,
        depth: Double? = 30,
        time: Date?,
        maxIntensity: String? = "6-",
        serialNo: Int = 12,
        isFinal: Bool = false,
        isWarning: Bool = true,
        isCanceled: Bool = false,
        isPlum: Bool = false,
        isLevel: Bool = false,
        isOnePoint: Bool = false,
        issuedAt: Date = Date(),
        location: LocationInfo? = nil
    ) -> UnifiedEew {
        UnifiedEew(
            eventId: eventId,
            headline: headline,
            hypocenterName: hypocenterName,
            magnitude: magnitude,
            depth: depth,
            time: time.map(UnifiedPreviewISO.string),
            isOriginTime: true,
            maxIntensity: maxIntensity,
            serialNo: serialNo,
            isFinal: isFinal,
            isWarning: isWarning,
            isCanceled: isCanceled,
            isPlum: isPlum,
            isLevel: isLevel,
            isOnePoint: isOnePoint,
            issuedAt: UnifiedPreviewISO.string(issuedAt),
            location: location
        )
    }

    static func previewLocation(
        regionName: String = "東京都２３区",
        forecastIntensity: String? = "5-",
        forecastLpgmIntensity: String? = "2",
        arrivalTime: Date? = nil,
        isWarning: Bool? = true
    ) -> LocationInfo {
        LocationInfo(
            regionName: regionName,
            forecastIntensity: forecastIntensity,
            forecastLpgmIntensity: forecastLpgmIntensity,
            arrivalTime: arrivalTime.map(UnifiedPreviewISO.string),
            isWarning: isWarning
        )
    }
}

extension UnifiedEarthquake {
    static func preview(
        eventId: String = "20260911123456",
        headline: String = "茨城県沖で地震 最大震度６弱",
        informationType: [String] = ["VXSE53"],
        isCanceled: Bool = false,
        hypocenterName: String? = "茨城県沖",
        magnitude: UnifiedMagnitude? = UnifiedMagnitude(type: "NORMAL", value: 6.8),
        depth: Double? = 30,
        originTime: Date?,
        maxIntensity: String? = "6-",
        locationName: String? = "東京都２３区",
        locationIntensity: String? = "5-"
    ) -> UnifiedEarthquake {
        UnifiedEarthquake(
            eventId: eventId,
            headline: headline,
            informationType: informationType,
            issuedAt: UnifiedPreviewISO.string(Date()),
            isCanceled: isCanceled,
            hypocenterName: hypocenterName,
            magnitude: magnitude,
            depth: depth,
            originTime: originTime.map(UnifiedPreviewISO.string),
            maxIntensity: maxIntensity,
            location: locationName.map {
                Location(regionName: $0, maxIntensity: locationIntensity)
            }
        )
    }
}

// MARK: - デザイン確認用の状態一覧

extension UnifiedLiveActivityContentState {
    /// 主表示 3 種と、各ブロックの組み合わせ・欠損を一通り並べる。
    /// Preview では 1 つずつ切り替えて表示の破綻を見る。
    static func designReviewStates(now: Date = Date()) -> [UnifiedLiveActivityContentState] {
        [
            shakeOnly(now: now),
            shakeOnlyEnded(now: now),
            shakeWithEew(now: now),
            eewOnlyForecast(now: now),
            eewCanceled(now: now),
            earthquakeFull(now: now),
            earthquakeIntensityReportOnly(now: now),
            earthquakeMagnitudeUnknown(now: now),
            earthquakeOverM8(now: now),
            earthquakeCanceled(now: now),
            earthquakeWithoutEew(now: now),
            empty(now: now),
        ]
    }

    // MARK: 揺れ検知が主表示

    /// 揺れ検知のみ。EEW 結合前で、120 秒後に End される想定
    static func shakeOnly(now: Date = Date()) -> UnifiedLiveActivityContentState {
        preview(
            primary: "shake_detection",
            shakeDetection: .preview(
                headline: "関東地方で強い揺れを検知しました",
                level: "Strong",
                detectedAt: now.addingTimeInterval(-18),
                updatedAt: now.addingTimeInterval(-4)
            ),
            now: now
        )
    }

    /// 検知終了後。ピークレベルを下げずに残す
    static func shakeOnlyEnded(now: Date = Date()) -> UnifiedLiveActivityContentState {
        preview(
            primary: "shake_detection",
            shakeDetection: .preview(
                headline: "関東地方で非常に強い揺れを検知しました",
                level: "Stronger",
                status: "ended",
                detectedAt: now.addingTimeInterval(-95),
                updatedAt: now.addingTimeInterval(-20),
                locationLevel: "Strong"
            ),
            now: now
        )
    }

    // MARK: EEW が主表示

    /// 揺れ検知に EEW が結合された直後。主表示は EEW へ切り替わる
    static func shakeWithEew(now: Date = Date()) -> UnifiedLiveActivityContentState {
        preview(
            primary: "eew",
            shakeDetection: .preview(
                level: "Strong",
                detectedAt: now.addingTimeInterval(-24),
                updatedAt: now.addingTimeInterval(-6)
            ),
            eew: .preview(
                time: now.addingTimeInterval(-12),
                serialNo: 4,
                location: UnifiedEew.previewLocation(
                    arrivalTime: now.addingTimeInterval(21)
                )
            ),
            now: now
        )
    }

    /// EEW 単独で開始した予報。現在地は予想震度 4 未満なので出さない
    static func eewOnlyForecast(now: Date = Date()) -> UnifiedLiveActivityContentState {
        preview(
            primary: "eew",
            eew: .preview(
                headline: "茨城県沖で地震",
                magnitude: 4.2,
                depth: 40,
                time: now.addingTimeInterval(-6),
                maxIntensity: "3",
                serialNo: 1,
                isWarning: false,
                location: UnifiedEew.previewLocation(
                    forecastIntensity: "2",
                    forecastLpgmIntensity: nil,
                    arrivalTime: now.addingTimeInterval(14),
                    isWarning: false
                )
            ),
            now: now
        )
    }

    /// EEW 取消。取消でも Activity は終了させず、backend の End を待つ
    static func eewCanceled(now: Date = Date()) -> UnifiedLiveActivityContentState {
        preview(
            primary: "eew",
            eew: .preview(
                headline: "茨城県沖で地震",
                hypocenterName: nil,
                magnitude: nil,
                depth: nil,
                time: nil,
                maxIntensity: nil,
                serialNo: 5,
                isFinal: true,
                isWarning: false,
                isCanceled: true,
                location: nil
            ),
            now: now
        )
    }

    // MARK: 地震情報が主表示

    /// 揺れ検知 → EEW → 地震情報まで揃った状態
    static func earthquakeFull(now: Date = Date()) -> UnifiedLiveActivityContentState {
        preview(
            primary: "earthquake",
            shakeDetection: .preview(
                level: "Stronger",
                status: "ended",
                detectedAt: now.addingTimeInterval(-150),
                updatedAt: now.addingTimeInterval(-90)
            ),
            eew: .preview(
                time: now.addingTimeInterval(-160),
                serialNo: 12,
                isFinal: true,
                location: UnifiedEew.previewLocation(arrivalTime: now.addingTimeInterval(-130))
            ),
            earthquake: .preview(
                informationType: ["VXSE51", "VXSE53"],
                originTime: now.addingTimeInterval(-160)
            ),
            now: now
        )
    }

    /// 震度速報のみ。震源・規模が未確定なので行ごと出さない
    static func earthquakeIntensityReportOnly(now: Date = Date()) -> UnifiedLiveActivityContentState {
        preview(
            primary: "earthquake",
            eew: .preview(
                time: now.addingTimeInterval(-70),
                serialNo: 8,
                isFinal: true,
                location: UnifiedEew.previewLocation(arrivalTime: now.addingTimeInterval(-42))
            ),
            earthquake: .preview(
                headline: "関東地方で最大震度５弱",
                informationType: ["VXSE51"],
                hypocenterName: nil,
                magnitude: nil,
                depth: nil,
                originTime: nil,
                maxIntensity: "5-",
                locationIntensity: "4"
            ),
            now: now
        )
    }

    /// M不明。「未取得（null）」と区別して明示する
    static func earthquakeMagnitudeUnknown(now: Date = Date()) -> UnifiedLiveActivityContentState {
        preview(
            primary: "earthquake",
            eew: .preview(time: now.addingTimeInterval(-120), serialNo: 6, isFinal: true),
            earthquake: .preview(
                informationType: ["VXSE52", "VXSE53"],
                magnitude: UnifiedMagnitude(type: "UNKNOWN", value: nil),
                originTime: now.addingTimeInterval(-120)
            ),
            now: now
        )
    }

    /// M8 以上の巨大地震
    static func earthquakeOverM8(now: Date = Date()) -> UnifiedLiveActivityContentState {
        preview(
            primary: "earthquake",
            eew: .preview(
                hypocenterName: "三陸沖",
                magnitude: 8.1,
                depth: 24,
                time: now.addingTimeInterval(-200),
                maxIntensity: "7",
                serialNo: 24,
                isFinal: true
            ),
            earthquake: .preview(
                headline: "三陸沖で地震 最大震度７",
                informationType: ["VXSE53", "IXAC41"],
                hypocenterName: "三陸沖",
                magnitude: UnifiedMagnitude(type: "OVER_M8", value: nil),
                depth: 24,
                originTime: now.addingTimeInterval(-200),
                maxIntensity: "7",
                locationIntensity: "6+"
            ),
            now: now
        )
    }

    /// 地震情報の取消
    static func earthquakeCanceled(now: Date = Date()) -> UnifiedLiveActivityContentState {
        preview(
            primary: "earthquake",
            eew: .preview(time: now.addingTimeInterval(-90), serialNo: 3, isFinal: true),
            earthquake: .preview(
                informationType: ["VXSE53"],
                isCanceled: true,
                originTime: now.addingTimeInterval(-90)
            ),
            now: now
        )
    }

    /// EEW を伴わない地震情報。仕様上は起こらないが表示を破綻させない
    static func earthquakeWithoutEew(now: Date = Date()) -> UnifiedLiveActivityContentState {
        preview(
            primary: "earthquake",
            earthquake: .preview(
                informationType: ["VXSE53"],
                originTime: now.addingTimeInterval(-240)
            ),
            now: now
        )
    }

    /// primary が指すブロックが欠けた異常系
    static func empty(now: Date = Date()) -> UnifiedLiveActivityContentState {
        preview(primary: "earthquake", now: now)
    }

    // MARK: 遷移の系列

    /// 揺れ検知 → レベル上昇 → EEW 結合 → 続報 → 震度速報 → 震源・震度情報。
    /// 同じ Activity の主表示が入れ替わっても破綻しないかを見る。
    static func progressionSequence(now: Date = Date()) -> [UnifiedLiveActivityContentState] {
        let detectedAt = now.addingTimeInterval(-40)
        let originTime = now.addingTimeInterval(-44)
        return [
            // 1. 弱い揺れを検知して開始
            preview(
                primary: "shake_detection",
                shakeDetection: .preview(
                    headline: "関東地方で揺れを検知しました",
                    level: "Weak",
                    detectedAt: detectedAt,
                    updatedAt: detectedAt
                ),
                now: now
            ),
            // 2. レベル上昇
            preview(
                primary: "shake_detection",
                shakeDetection: .preview(
                    headline: "関東地方で強い揺れを検知しました",
                    level: "Strong",
                    detectedAt: detectedAt,
                    updatedAt: now.addingTimeInterval(-32)
                ),
                now: now
            ),
            // 3. EEW が結合され主表示が入れ替わる
            preview(
                primary: "eew",
                shakeDetection: .preview(
                    level: "Strong",
                    detectedAt: detectedAt,
                    updatedAt: now.addingTimeInterval(-32)
                ),
                eew: .preview(
                    magnitude: 6.1,
                    time: originTime,
                    maxIntensity: "5+",
                    serialNo: 2,
                    location: UnifiedEew.previewLocation(
                        forecastIntensity: "5-",
                        arrivalTime: now.addingTimeInterval(12)
                    )
                ),
                now: now
            ),
            // 4. EEW 続報で規模・予想震度が上がる
            preview(
                primary: "eew",
                shakeDetection: .preview(
                    level: "Stronger",
                    detectedAt: detectedAt,
                    updatedAt: now.addingTimeInterval(-20)
                ),
                eew: .preview(
                    time: originTime,
                    serialNo: 8,
                    isFinal: true,
                    location: UnifiedEew.previewLocation(
                        forecastIntensity: "5+",
                        arrivalTime: now.addingTimeInterval(-3)
                    )
                ),
                now: now
            ),
            // 5. 震度速報が届く
            preview(
                primary: "earthquake",
                shakeDetection: .preview(
                    level: "Stronger",
                    status: "ended",
                    detectedAt: detectedAt,
                    updatedAt: now.addingTimeInterval(-12)
                ),
                eew: .preview(
                    time: originTime, serialNo: 8, isFinal: true,
                    location: UnifiedEew.previewLocation(forecastIntensity: "5+")
                ),
                earthquake: .preview(
                    headline: "関東地方で最大震度５強",
                    informationType: ["VXSE51"],
                    hypocenterName: nil,
                    magnitude: nil,
                    depth: nil,
                    originTime: nil,
                    maxIntensity: "5+",
                    locationIntensity: "5+"
                ),
                now: now
            ),
            // 6. 震源・震度に関する情報で震源が確定する
            preview(
                primary: "earthquake",
                shakeDetection: .preview(
                    level: "Stronger",
                    status: "ended",
                    detectedAt: detectedAt,
                    updatedAt: now.addingTimeInterval(-12)
                ),
                eew: .preview(
                    time: originTime, serialNo: 8, isFinal: true,
                    location: UnifiedEew.previewLocation(forecastIntensity: "5+")
                ),
                earthquake: .preview(
                    informationType: ["VXSE51", "VXSE53"],
                    originTime: originTime
                ),
                now: now
            ),
        ]
    }
}
