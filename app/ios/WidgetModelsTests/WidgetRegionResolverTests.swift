//
//  WidgetRegionResolverTests.swift
//  WidgetModelsTests
//
//  表示範囲の解決規則。Pro 未加入・未設定・未対応の種別では全国へ落とし、
//  「設定した地域の履歴」を装って別地域の情報を見せないことを保証する。
//

import Foundation
import Testing

struct WidgetRegionResolverTests {
    private let nationwide = ResolvedWidgetRegion(
        plan: .nationwide,
        title: "全国の地震履歴",
        compactTitle: "地震履歴"
    )

    // MARK: - 全国

    @Test func nationwideIgnoresStoredSettings() {
        let resolved = WidgetRegionResolver.resolve(
            regionType: .nationwide,
            settings: WidgetRegionSettings(
                isPro: true,
                searchType: "prefecture",
                regionCode: "13",
                regionName: "東京都"
            )
        )
        #expect(resolved == nationwide)
    }

    // MARK: - 現在地

    @Test func currentLocationUsesResolvedRegionName() {
        let resolved = WidgetRegionResolver.resolve(
            regionType: .currentLocation,
            settings: WidgetRegionSettings(
                currentLocationRegionCode: "276",
                currentLocationRegionName: "東京都23区"
            )
        )
        #expect(resolved.plan == .region(code: "276"))
        #expect(resolved.title == "現在地(東京都23区)の地震履歴")
        #expect(resolved.compactTitle == "東京都23区")
    }

    @Test func currentLocationFallsBackWhenRegionNameIsMissing() {
        let resolved = WidgetRegionResolver.resolve(
            regionType: .currentLocation,
            settings: WidgetRegionSettings(currentLocationRegionCode: "276")
        )
        #expect(resolved.plan == .region(code: "276"))
        #expect(resolved.title == "現在地の地震履歴")
        #expect(resolved.compactTitle == "現在地")
    }

    /// 位置情報が未許可のときは Flutter 側がキーを削除する
    @Test func currentLocationFallsBackToNationwideWithoutCode() {
        #expect(
            WidgetRegionResolver.resolve(
                regionType: .currentLocation,
                settings: WidgetRegionSettings()
            ) == nationwide
        )
        #expect(
            WidgetRegionResolver.resolve(
                regionType: .currentLocation,
                settings: WidgetRegionSettings(currentLocationRegionCode: "")
            ) == nationwide
        )
    }

    // MARK: - 任意地域

    @Test func specificRegionResolvesPrefecture() {
        let resolved = WidgetRegionResolver.resolve(
            regionType: .specificRegion,
            settings: WidgetRegionSettings(
                isPro: true,
                searchType: "prefecture",
                regionCode: "13",
                regionName: "東京都"
            )
        )
        #expect(resolved.plan == .prefecture(code: "13"))
        #expect(resolved.title == "東京都の地震履歴")
        #expect(resolved.compactTitle == "東京都")
    }

    @Test func specificRegionResolvesCity() {
        let resolved = WidgetRegionResolver.resolve(
            regionType: .specificRegion,
            settings: WidgetRegionSettings(
                isPro: true,
                searchType: "city",
                regionCode: "13101",
                regionName: "千代田区"
            )
        )
        #expect(resolved.plan == .city(code: "13101"))
    }

    /// Flutter の RegionSearchType には region も存在する。
    /// ピッカーが拡張されたときに黙って全国へ落ちないよう対応済みにしておく。
    @Test func specificRegionResolvesSubdividedRegion() {
        let resolved = WidgetRegionResolver.resolve(
            regionType: .specificRegion,
            settings: WidgetRegionSettings(
                isPro: true,
                searchType: "region",
                regionCode: "276",
                regionName: "東京都23区"
            )
        )
        #expect(resolved.plan == .region(code: "276"))
    }

    /// 観測点単位の地震履歴 API は無いため解決できない。全国へ落とす。
    @Test func stationSearchTypeIsNotSupported() {
        #expect(WidgetRegionResolver.plan(forSearchType: "station", code: "1") == nil)
        #expect(
            WidgetRegionResolver.resolve(
                regionType: .specificRegion,
                settings: WidgetRegionSettings(
                    isPro: true,
                    searchType: "station",
                    regionCode: "1",
                    regionName: "東京"
                )
            ) == nationwide
        )
    }

    @Test func unknownSearchTypeFallsBackToNationwide() {
        #expect(WidgetRegionResolver.plan(forSearchType: "galaxy", code: "1") == nil)
    }

    /// 任意地域は Pro 専用。解約後も設定は残るので Widget 側でも弾く。
    @Test func specificRegionRequiresPro() {
        #expect(
            WidgetRegionResolver.resolve(
                regionType: .specificRegion,
                settings: WidgetRegionSettings(
                    isPro: false,
                    searchType: "prefecture",
                    regionCode: "13",
                    regionName: "東京都"
                )
            ) == nationwide
        )
    }

    @Test func specificRegionRequiresCode() {
        #expect(
            WidgetRegionResolver.resolve(
                regionType: .specificRegion,
                settings: WidgetRegionSettings(isPro: true, searchType: "prefecture")
            ) == nationwide
        )
    }

    // MARK: - 短縮

    @Test func compactTitleShortensLongRegionName() {
        let resolved = WidgetRegionResolver.resolve(
            regionType: .specificRegion,
            settings: WidgetRegionSettings(
                isPro: true,
                searchType: "city",
                regionCode: "01100",
                regionName: "北海道札幌市中央区南三条"
            )
        )
        // 12 文字 → 先頭 8 文字 + 省略記号
        #expect(resolved.compactTitle == "北海道札幌市中央…")
    }

    @Test func compactTitleKeepsShortRegionName() {
        let resolved = WidgetRegionResolver.resolve(
            regionType: .specificRegion,
            settings: WidgetRegionSettings(
                isPro: true,
                searchType: "prefecture",
                regionCode: "13",
                regionName: "東京都"
            )
        )
        #expect(resolved.compactTitle == "東京都")
    }
}
