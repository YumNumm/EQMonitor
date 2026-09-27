import Foundation
import Testing
import EQMonitorAPI

struct EarthquakeIntentDialogTests {
    func earthquake() throws -> Components.Schemas.EarthquakePartial {
        let json = """
        {"event_id":"20260830001711","status":"NORMAL",
         "origin_time":"2026-08-29T15:17:00Z","origin_time_precision":"SECOND",
         "hypocenter":{"code":"473","name":"千葉県東方沖",
           "magnitude":{"type":"NORMAL","value":4.8},
           "depth":{"type":"NORMAL","value":30}},
         "intensity":{"max_intensity":"4"},"datasources":[],
         "telegram_types":[],"earthquake_type":"NORMAL"}
        """
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return try decoder.decode(Components.Schemas.EarthquakePartial.self, from: Data(json.utf8))
    }

    @Test func regionalIntensityDoesNotReplaceEarthquakeMaximum() throws {
        let item = EarthquakeDisplayItem(from: Components.Schemas.IntensityPrefectureSearchItem(
            intensity: ._1, earthquake: try earthquake()
        ))
        let dialog = EarthquakeIntentDialog.summary(items: [item], area: "東京都", isRegional: true)
        #expect(item.earthquakeMaxIntensity == .four)
        #expect(item.maxIntensity == .one)
        #expect(dialog.contains("地震全体の最大震度は4です。対象地域の震度は1です。"))
        #expect(dialog.contains("2026年8月30日0時17分頃発生"))
        #expect(dialog.contains("震源は千葉県東方沖です。"))
        #expect(dialog.contains("マグニチュード4.8"))
    }

    @Test func nationwideDoesNotDescribeRegionalIntensity() throws {
        let dialog = EarthquakeIntentDialog.summary(
            items: [EarthquakeDisplayItem(from: try earthquake())], area: "全国", isRegional: false
        )
        #expect(dialog.contains("全国の地震・噴火情報を1件取得"))
        #expect(!dialog.contains("対象地域の震度"))
    }

    @Test func missingTimeAndHypocenterAreNotInvented() throws {
        var source = try earthquake()
        source.origin_time = nil
        source.hypocenter = nil
        let dialog = EarthquakeIntentDialog.summary(
            items: [EarthquakeDisplayItem(from: source)], area: "全国", isRegional: false
        )
        #expect(dialog.contains("時刻は不明です。震源は不明です。"))
        #expect(!dialog.contains("頃発生"))
        #expect(!dialog.contains("震源は最大震度"))
        #expect(dialog.contains("マグニチュード不明"))
    }

    @Test func detectionTimeIsNotAnnouncedAsOriginTime() throws {
        var source = try earthquake()
        source.arrival_time = source.origin_time
        source.origin_time = nil
        let dialog = EarthquakeIntentDialog.summary(
            items: [EarthquakeDisplayItem(from: source)], area: "全国", isRegional: false
        )
        #expect(dialog.contains("頃検知"))
        #expect(!dialog.contains("頃発生"))
    }

    @Test(arguments: [Components.Schemas.TelegramStatus.TRAINING, .TEST])
    func nonNormalInformationIsAnnouncedBeforeDetails(status: Components.Schemas.TelegramStatus) throws {
        var source = try earthquake()
        source.status = status
        let dialog = EarthquakeIntentDialog.summary(
            items: [EarthquakeDisplayItem(from: source)], area: "全国", isRegional: false
        )
        let warning = status == .TRAINING ? "これは訓練の情報です。" : "これはテストの情報です。"
        #expect(dialog.contains(warning + "2026年8月30日"))
    }

    @Test func emptyResultDoesNotClaimThatNoEarthquakeOccurred() {
        #expect(EarthquakeIntentDialog.summary(items: [], area: "東京都", isRegional: true)
            == "東京都で条件に合う地震情報は見つかりませんでした。")
    }

    @Test func multipleResultsReadOnlyTheFirstAndStateTheCount() throws {
        let item = EarthquakeDisplayItem(from: try earthquake())
        let dialog = EarthquakeIntentDialog.summary(items: [item, item], area: "全国", isRegional: false)
        #expect(dialog.contains("2件取得しました。最新の1件を読み上げます。"))
        #expect(dialog.components(separatedBy: "震源は").count == 2)
    }

    @Test func detailedHypocenterKeepsBothNamesLikeFlutter() throws {
        var source = try earthquake()
        source.hypocenter?.value1.detailed = .init(value1: .init(code: "1", name: "補足の地域名"))
        let item = EarthquakeDisplayItem(from: source)
        #expect(item.sourceHypocenterName == "千葉県東方沖、補足の地域名")
    }

    @Test(arguments: [Components.Schemas.EarthquakeType.VOLCANO, .DISTANT])
    func overseasEventsDoNotInventMissingElements(type: Components.Schemas.EarthquakeType) throws {
        var source = try earthquake()
        source.earthquake_type = type
        source.intensity = nil
        source.hypocenter?.value1.magnitude = .init(_type: .UNKNOWN)
        source.hypocenter?.value1.depth = .init(_type: .UNKNOWN)
        let dialog = EarthquakeIntentDialog.summary(
            items: [EarthquakeDisplayItem(from: source)], area: "全国", isRegional: false
        )
        #expect(!dialog.contains("最大震度"))
        #expect(!dialog.contains("マグニチュード"))
        #expect(!dialog.contains("調査中"))
        #expect(!dialog.contains("深さ"))
        if type == .VOLCANO {
            #expect(dialog.contains("火山噴火の情報です。"))
            #expect(dialog.contains("発生場所は千葉県東方沖です。"))
            #expect(!dialog.contains("震源は"))
        }
    }

    @Test(arguments: [Components.Schemas.OriginTimePrecision.HOUR, .DAY, .MONTH])
    func coarseTimesDoNotInventPrecision(precision: Components.Schemas.OriginTimePrecision) throws {
        var source = try earthquake()
        source.origin_time_precision = precision
        let time = EarthquakeIntentDialog.timeDescription(item: EarthquakeDisplayItem(from: source))
        #expect(!time.contains("分"))
        if precision != .HOUR { #expect(!time.contains("時")) }
        if precision == .MONTH { #expect(time == "2026年8月頃発生。") }
    }

    @Test func overM8AndShallowDepthMatchFlutterSemantics() throws {
        var source = try earthquake()
        source.hypocenter?.value1.magnitude = .init(_type: .OVER_M8)
        source.hypocenter?.value1.depth = .init(_type: .SHALLOW)
        let dialog = EarthquakeIntentDialog.summary(
            items: [EarthquakeDisplayItem(from: source)], area: "全国", isRegional: false
        )
        #expect(dialog.contains("マグニチュード8超"))
        #expect(dialog.contains("深さはごく浅いです。"))
    }

    @Test func historicalFiveIsNotAnnouncedAsFiveLower() throws {
        var source = try earthquake()
        source.intensity?.value1.max_intensity = ._5_hyphen_
        source.intensity?.value1.max_intensity_class = .init(value1: ._5)
        let dialog = EarthquakeIntentDialog.summary(
            items: [EarthquakeDisplayItem(from: source)], area: "全国", isRegional: false
        )
        #expect(dialog.contains("最大震度は5です。"))
        #expect(!dialog.contains("5弱"))
    }

    @Test func historicalNonNumericClassDoesNotBecomeNumericIntensity() throws {
        var source = try earthquake()
        source.intensity?.value1.max_intensity_class = .init(value1: .R)
        let dialog = EarthquakeIntentDialog.summary(
            items: [EarthquakeDisplayItem(from: source)], area: "全国", isRegional: false
        )
        #expect(dialog.contains("地震データベース上の分類は顕著地震です。"))
        #expect(!dialog.contains("最大震度は4"))
    }

    @Test func searchURLPreservesJapaneseAndReservedCharacters() throws {
        let query = "東京 & 千代田区+沿岸/#"
        let url = try #require(EarthquakeSearchURL.make(query: query))
        let components = try #require(URLComponents(url: url, resolvingAgainstBaseURL: false))
        #expect(components.scheme == "eqmonitor")
        #expect(components.path == "/earthquake-history/search")
        #expect(components.queryItems == [URLQueryItem(name: "query", value: query)])
        #expect(components.fragment == nil)
        #expect(url.absoluteString.contains("%2B"))
        #expect(!url.absoluteString.contains("+"))
        #expect(EarthquakeSearchURL.make(query: "Tokyo+Chiyoda")?.absoluteString
            == "eqmonitor:///earthquake-history/search?query=Tokyo%2BChiyoda")
    }
}
