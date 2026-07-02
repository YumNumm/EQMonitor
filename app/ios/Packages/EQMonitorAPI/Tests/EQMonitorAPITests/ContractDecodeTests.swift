import Foundation
import OpenAPIRuntime
import Testing
@testable import EQMonitorAPI

@Suite("Contract fixture decode tests")
struct ContractDecodeTests {

    /// 本番 Client と同一構成のデコーダ。
    /// swift-openapi-runtime の Converter は `JSONDecoder.dateDecodingStrategy` を
    /// `Configuration.dateTranscoder` から組み立てる。ここでも同じ経路を再現し、
    /// 本番で通る/落ちるが正しく反映されるようにする。
    private static func makeDecoder(dateTranscoder: any DateTranscoder) -> JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .custom { dec in
            let container = try dec.singleValueContainer()
            let string = try container.decode(String.self)
            return try dateTranscoder.decode(string)
        }
        return decoder
    }

    /// 本番 Client が実際に使う構成（lenient transcoder）。
    private let decoder = makeDecoder(dateTranscoder: LenientISO8601DateTranscoder())

    /// swift-openapi-runtime のデフォルト構成（fractional seconds 非対応・`T` 必須）。
    /// backend の実レスポンス形式で全滅することを回帰テストで固定する。
    private let defaultDecoder = makeDecoder(dateTranscoder: ISO8601DateTranscoder())

    private func loadFixture(_ name: String) throws -> Data {
        let url = Bundle.module.url(forResource: name, withExtension: "json", subdirectory: "fixtures")!
        return try Data(contentsOf: url)
    }

    // MARK: - EarthquakeListResponse（全国一覧）

    @Test("Decode EarthquakeListResponse — full-info")
    func decodeEarthquakeFullInfo() throws {
        let data = try loadFixture("get__v2_earthquake__full-info")
        let decoded = try decoder.decode(
            Components.Schemas.EarthquakeListResponse.self,
            from: data
        )
        #expect(!decoded.items.isEmpty)
        let item = decoded.items[0]
        #expect(item.event_id == "20251215120000")
        #expect(item.hypocenter?.value1.name == "茨城県北部")
        #expect(item.hypocenter?.value1.detailed?.value1.name == "茨城県北部（詳細）")
        #expect(item.hypocenter?.value1.coordinates?.value1.latitude == 36.7)
        #expect(item.intensity?.value1.max_intensity == ._4)
        #expect(item.telegram_types.contains(.VXSE53))
        #expect(item.earthquake_type == .NORMAL)
    }

    @Test("Decode EarthquakeListResponse — major earthquake")
    func decodeEarthquakeMajor() throws {
        let data = try loadFixture("get__v2_earthquake__major-earthquake")
        let decoded = try decoder.decode(
            Components.Schemas.EarthquakeListResponse.self,
            from: data
        )
        #expect(!decoded.items.isEmpty)
        #expect(decoded.items[0].hypocenter?.value1.depth._type == .SHALLOW)
    }

    // MARK: - Regression: !6- intensity

    @Test("Decode EarthquakeListResponse — !6- (6弱以上未入電) is accepted")
    func decodeEarthquakeSixLowerNoInput() throws {
        let data = try loadFixture("get__v2_earthquake__six-lower-no-input")
        let decoded = try decoder.decode(
            Components.Schemas.EarthquakeListResponse.self,
            from: data
        )
        #expect(decoded.items[0].intensity?.value1.max_intensity == ._excl_6_hyphen_)
    }

    // MARK: - IntensityRegionSearchResponse（本番実データ）

    /// region/350 の本番実レスポンス（10 件）をそのままデコードできる。
    /// hypocenter は code/name 直下・Magnitude/Depth.value あり・
    /// origin_time/arrival_time は PostgreSQL timestamptz 形式（`... +00`）。
    @Test("Decode IntensityRegionSearchResponse — live production data")
    func decodeIntensityRegionLive() throws {
        let data = try loadFixture("get__v2_earthquake_intensity_region__live")
        let decoded = try decoder.decode(
            Components.Schemas.IntensityRegionSearchResponse.self,
            from: data
        )
        #expect(decoded.items.count == 10)
        let first = decoded.items[0]
        #expect(first.intensity == ._1)
        #expect(first.earthquake.event_id == "20260627035948")
        #expect(first.earthquake.hypocenter?.value1.name == "千葉県北西部")
        #expect(first.earthquake.hypocenter?.value1.magnitude.value == 3.8)
        #expect(first.earthquake.telegram_types.contains(.VXSE53))

        // 6- を含むイベント（2 件目）もデコードできる
        #expect(decoded.items[1].intensity == ._3)
        #expect(decoded.items[1].earthquake.intensity?.value1.max_intensity == ._6_hyphen_)
    }

    // MARK: - EEW / Tsunami（新スキーマで従来 fixture が通ること）

    @Test("Decode EewListResponse — warning")
    func decodeEewWarning() throws {
        let data = try loadFixture("get__v2_eew__warning")
        let decoded = try decoder.decode(
            Components.Schemas.EewListResponse.self,
            from: data
        )
        #expect(!decoded.items.isEmpty)
        #expect(decoded.items[0].is_warning == true)
    }

    @Test("Decode EewListResponse — basic")
    func decodeEewBasic() throws {
        let data = try loadFixture("get__v2_eew")
        let decoded = try decoder.decode(
            Components.Schemas.EewListResponse.self,
            from: data
        )
        #expect(!decoded.items.isEmpty)
    }

    @Test("Decode TsunamiListResponse — active warning")
    func decodeTsunamiActiveWarning() throws {
        let data = try loadFixture("get__v2_tsunami__active-warning")
        let decoded = try decoder.decode(
            Components.Schemas.TsunamiListResponse.self,
            from: data
        )
        #expect(!decoded.items.isEmpty)
    }

    // MARK: - LenientISO8601DateTranscoder 単体（受理形式の固定）

    /// backend が返しうる 4 形式すべてを同一 Instant として受理する。
    @Test(
        "Lenient transcoder accepts all backend date formats",
        arguments: [
            "2026-06-26 18:59:00+00",         // PostgreSQL timestamptz（スペース区切り・2 桁オフセット）
            "2026-06-26 18:59:00.123+00",     // 上記 + ミリ秒
            "2023-11-14T22:08:20.000Z",       // ISO8601 fractional + Z
            "2023-11-14T22:08:20Z",           // ISO8601 non-fractional + Z
        ]
    )
    func lenientAcceptsAllFormats(_ input: String) throws {
        let transcoder = LenientISO8601DateTranscoder()
        #expect(throws: Never.self) {
            _ = try transcoder.decode(input)
        }
    }

    /// PostgreSQL 形式は UTC の同一時刻として解釈される（`+00` = Z）。
    @Test("Lenient transcoder maps +00 offset to UTC")
    func lenientPostgresEqualsZulu() throws {
        let transcoder = LenientISO8601DateTranscoder()
        let fromPostgres = try transcoder.decode("2026-06-26 18:59:00+00")
        let fromZulu = try transcoder.decode("2026-06-26T18:59:00Z")
        #expect(fromPostgres == fromZulu)
    }

    // MARK: - Regression: デフォルト transcoder では本番形式が落ちる

    /// runtime デフォルト構成（`T` 必須・fractional 非対応）では
    /// PostgreSQL timestamptz 形式のパースに必ず失敗する（＝本番デフォルトのままなら全滅）。
    @Test("Default transcoder fails on PostgreSQL timestamptz format")
    func defaultFailsOnPostgresFormat() throws {
        #expect(throws: (any Error).self) {
            _ = try ISO8601DateTranscoder().decode("2026-06-26 18:59:00+00")
        }
    }

    /// 本番 live fixture もデフォルト構成では全体デコードが失敗する。
    @Test("Default transcoder fails to decode live response")
    func defaultFailsOnLiveResponse() throws {
        let data = try loadFixture("get__v2_earthquake_intensity_region__live")
        #expect(throws: (any Error).self) {
            _ = try defaultDecoder.decode(
                Components.Schemas.IntensityRegionSearchResponse.self,
                from: data
            )
        }
    }
}
