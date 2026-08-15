//
//  LiveActivityDate.swift
//  Shared (WidgetExtension / WidgetModelsTests)
//
//  Live Activity の APNs content-state に含まれる日時文字列をパースする。
//
//  backend の日時表現は経路によって揺れる（`LenientISO8601DateTranscoder` と同じ事情）。
//  ActivityKit の content-state は `String` で受け取ってから View 側で Date に変換するため、
//  OpenAPI クライアントの DateTranscoder が効かない。パースに失敗すると発生時刻や
//  主要動到達までのカウントダウンが丸ごと消えるため、受理できる表現を広く取る。
//

import Foundation

enum LiveActivityDate {
    /// ISO8601 由来の日時文字列を Date に変換する。
    ///
    /// 受理する表現:
    /// - fractional seconds あり/なし (`...T16:10:00.123+09:00` / `...T16:10:00+09:00`)
    /// - UTC 表記 (`...T07:10:00Z`)
    /// - PostgreSQL timestamptz テキスト表現 (`2026-06-26 18:59:00+00`)
    static func parse(_ raw: String?) -> Date? {
        guard let raw, !raw.isEmpty else { return nil }
        let normalized = normalize(raw)
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        if let date = formatter.date(from: normalized) {
            return date
        }
        formatter.formatOptions = [.withInternetDateTime]
        return formatter.date(from: normalized)
    }

    /// ISO8601 パーサが受理できる形へ寄せる。
    /// - 日付と時刻の区切りスペースを `T` に置換
    /// - 末尾のオフセットが 2 桁のみ（`+00` / `-09`）なら `:00` を補って `HH:mm` にする
    private static func normalize(_ raw: String) -> String {
        var value = raw
        if let space = value.firstIndex(of: " ") {
            value.replaceSubrange(space...space, with: "T")
        }
        if let offset = shortOffsetRange(in: value) {
            value.insert(contentsOf: ":00", at: offset.upperBound)
        }
        return value
    }

    /// 末尾が `+HH` / `-HH`（分を伴わない 2 桁オフセット）ならその範囲を返す。
    private static func shortOffsetRange(in value: String) -> Range<String.Index>? {
        guard value.count >= 3 else { return nil }
        let offsetStart = value.index(value.endIndex, offsetBy: -3)
        let sign = value[offsetStart]
        guard sign == "+" || sign == "-" else { return nil }
        let digits = value[value.index(after: offsetStart)...]
        guard digits.count == 2, digits.allSatisfy(\.isNumber) else { return nil }
        return offsetStart..<value.endIndex
    }
}

// MARK: - 到達カウントダウン

enum ArrivalCountdown {
    /// `Text(timerInterval:)` に渡す残り時間の範囲。到達済み・未設定なら nil。
    ///
    /// `now > arrivalDate` の範囲を作ると `ClosedRange` の事前条件違反でクラッシュする。
    /// 「到達したか」の判定と範囲生成で別々に `Date()` を取ると、ちょうど到達した
    /// 瞬間（ユーザが最も画面を見ているタイミング）に踏み抜くため、同じ時刻で判定する。
    static func remaining(until arrivalDate: Date?, now: Date = Date()) -> ClosedRange<Date>? {
        guard let arrivalDate, arrivalDate > now else { return nil }
        return now...arrivalDate
    }
}

// MARK: - 表示用フォーマット

/// JMA が発表する日時は JST を正とするため、端末のタイムゾーンに依存させない。
enum JSTDateFormat {
    private static let timeZone = TimeZone(identifier: "Asia/Tokyo")
    private static let locale = Locale(identifier: "ja_JP")

    /// `MM/dd`
    static func monthDay(_ date: Date) -> String {
        string(from: date, format: "MM/dd")
    }

    /// `HH:mm:ss`
    static func timeWithSeconds(_ date: Date) -> String {
        string(from: date, format: "HH:mm:ss")
    }

    private static func string(from date: Date, format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = locale
        formatter.timeZone = timeZone
        return formatter.string(from: date)
    }
}
