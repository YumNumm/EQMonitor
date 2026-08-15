//
//  LiveActivityDateTests.swift
//  WidgetModelsTests
//
//  Live Activity の日時パースは主要動到達カウントダウンと発生時刻表示の前提であり、
//  失敗すると生命に関わる情報が丸ごと欠落する。backend が返しうる表現を網羅する。
//

import Foundation
import Testing

struct LiveActivityDateTests {
    /// backend が JS の Date.toISOString() 相当を返す場合。
    /// ISO8601DateFormatter のデフォルト設定では小数秒を受理できずパースが失敗していた。
    @Test func parsesFractionalSecondsWithUTC() throws {
        let date = try #require(LiveActivityDate.parse("2024-01-01T07:10:00.123Z"))
        #expect(abs(date.timeIntervalSince1970 - 1_704_093_000.123) < 0.001)
    }

    @Test func parsesFractionalSecondsWithOffset() throws {
        let date = try #require(LiveActivityDate.parse("2024-01-01T16:10:00.000+09:00"))
        #expect(date.timeIntervalSince1970 == 1_704_093_000)
    }

    @Test func parsesInternetDateTimeWithOffset() throws {
        let date = try #require(LiveActivityDate.parse("2024-01-01T16:10:00+09:00"))
        #expect(date.timeIntervalSince1970 == 1_704_093_000)
    }

    @Test func parsesInternetDateTimeWithZulu() throws {
        let date = try #require(LiveActivityDate.parse("2024-01-01T07:10:00Z"))
        #expect(date.timeIntervalSince1970 == 1_704_093_000)
    }

    /// PostgreSQL timestamptz のテキスト表現（スペース区切り・2 桁オフセット）
    @Test func parsesPostgresTimestamptzText() throws {
        let date = try #require(LiveActivityDate.parse("2024-01-01 16:10:00+09"))
        #expect(date.timeIntervalSince1970 == 1_704_093_000)
    }

    @Test func returnsNilForMissingOrBlankValue() {
        #expect(LiveActivityDate.parse(nil) == nil)
        #expect(LiveActivityDate.parse("") == nil)
    }

    @Test func returnsNilForUnparsableValue() {
        #expect(LiveActivityDate.parse("not-a-date") == nil)
        // 日付のみは時刻が確定しないため受理しない
        #expect(LiveActivityDate.parse("2024-01-01") == nil)
    }

    /// 端末のタイムゾーンに依存せず JST で表示する（JMA 発表時刻は JST が正）
    @Test func formatsInJapanStandardTimeRegardlessOfDeviceTimeZone() throws {
        let date = try #require(LiveActivityDate.parse("2024-01-01T16:10:05+09:00"))
        #expect(JSTDateFormat.monthDay(date) == "01/01")
        #expect(JSTDateFormat.timeWithSeconds(date) == "16:10:05")
    }
}

struct ArrivalCountdownTests {
    @Test func returnsRangeWhileMainShockIsStillApproaching() throws {
        let now = Date(timeIntervalSince1970: 1_704_093_000)
        let range = try #require(
            ArrivalCountdown.remaining(until: now.addingTimeInterval(30), now: now)
        )
        #expect(range.lowerBound == now)
        #expect(range.upperBound == now.addingTimeInterval(30))
    }

    /// 到達時刻を過ぎた瞬間に `now...arrival` を作ると ClosedRange の事前条件違反で
    /// クラッシュする。境界（同時刻・過去）で必ず nil になることを保証する。
    @Test func returnsNilOnceMainShockHasArrived() {
        let now = Date(timeIntervalSince1970: 1_704_093_000)
        #expect(ArrivalCountdown.remaining(until: now, now: now) == nil)
        #expect(ArrivalCountdown.remaining(until: now.addingTimeInterval(-0.001), now: now) == nil)
        #expect(ArrivalCountdown.remaining(until: now.addingTimeInterval(-60), now: now) == nil)
    }

    @Test func returnsNilWhenArrivalTimeIsUnknown() {
        #expect(ArrivalCountdown.remaining(until: nil) == nil)
    }
}
