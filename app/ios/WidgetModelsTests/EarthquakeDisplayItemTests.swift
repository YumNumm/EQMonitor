//
//  EarthquakeDisplayItemTests.swift
//  WidgetModelsTests
//
//  表示表記が Flutter アプリ実装（正）と一致することを保証する。
//  期待値の根拠: app/lib/feature/earthquake_history/ 配下の
//  magnitude_text.dart / depth_text.dart / earthquake_history_list_tile.dart
//

import Foundation
import Testing
import EQMonitorAPI

struct EarthquakeDisplayItemFormatTests {
    @Test func magnitudeNormal() {
        #expect(EarthquakeDisplayItem.formatMagnitude(
            .init(_type: .NORMAL, value: 5.2)) == "M5.2")
    }

    @Test func magnitudeOver8() {
        // Flutter (magnitude_text.dart) は「M8超」
        #expect(EarthquakeDisplayItem.formatMagnitude(
            .init(_type: .OVER_M8)) == "M8超")
    }

    @Test func magnitudeUnknown() {
        #expect(EarthquakeDisplayItem.formatMagnitude(
            .init(_type: .UNKNOWN)) == "M不明")
    }

    @Test func timeWithOrigin() throws {
        // Flutter (earthquake_history_list_tile.dart) は "yyyy/MM/dd HH:mm頃発生"
        let date = try #require(makeDate(2026, 7, 3, 10, 15))
        #expect(EarthquakeDisplayItem.formatTime(date, isArrival: false)
                == "2026/07/03 10:15頃発生")
    }

    @Test func timeWithArrival() throws {
        let date = try #require(makeDate(2026, 7, 3, 10, 15))
        #expect(EarthquakeDisplayItem.formatTime(date, isArrival: true)
                == "2026/07/03 10:15頃検知")
    }

    @Test func depthShallow() {
        #expect(EarthquakeDisplayItem.formatDepth(.init(_type: .SHALLOW)) == "ごく浅い")
    }

    @Test func depthNormal() {
        #expect(EarthquakeDisplayItem.formatDepth(.init(_type: .NORMAL, value: 50)) == "50km")
    }

    @Test func depthOver700() {
        #expect(EarthquakeDisplayItem.formatDepth(.init(_type: .OVER_700)) == "700km以上")
    }

    @Test func depthUnknownIsEmpty() {
        // Flutter はリスト表示で深さ不明を出さない → 空文字で表現し View 側が行を省略する
        #expect(EarthquakeDisplayItem.formatDepth(.init(_type: .UNKNOWN)) == "")
        #expect(EarthquakeDisplayItem.formatDepth(nil) == "")
    }

    @Test func hypocenterFallbackUsesIntensity() {
        // Flutter は震源名が無いとき「最大震度◯を観測」
        #expect(EarthquakeDisplayItem.resolveTitle(
            name: nil, detailedName: nil, maxIntensity: .fiveLower) == "最大震度5弱を観測")
    }

    @Test func hypocenterPrefersDetailedName() {
        #expect(EarthquakeDisplayItem.resolveTitle(
            name: "石川県能登地方", detailedName: "珠洲市付近", maxIntensity: .four) == "珠洲市付近")
    }

    @Test func hypocenterFallbackWithoutIntensityIsEmpty() {
        #expect(EarthquakeDisplayItem.resolveTitle(
            name: nil, detailedName: nil, maxIntensity: nil) == "")
    }

    private func makeDate(
        _ year: Int, _ month: Int, _ day: Int, _ hour: Int, _ minute: Int
    ) -> Date? {
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = day
        components.hour = hour
        components.minute = minute
        components.timeZone = TimeZone(identifier: "Asia/Tokyo")
        return Calendar(identifier: .gregorian).date(from: components)
    }
}
