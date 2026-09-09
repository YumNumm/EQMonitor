//
//  EarthquakeEntity.swift
//  AppIntentExtension
//
//  Intent の戻り値。ショートカットのオートメーションで後続アクションに
//  震源・震度などのプロパティを渡せるようにする。
//

import AppIntents
import Foundation
import EQMonitorAPI

struct EarthquakeEntity: AppEntity, Identifiable {
    static let typeDisplayRepresentation: TypeDisplayRepresentation = "地震情報"
    static let defaultQuery = EarthquakeEntityQuery()

    /// eventId
    let id: String

    @Property(title: "震源")
    var hypocenterName: String

    @Property(title: "マグニチュード")
    var magnitude: String

    @Property(title: "深さ")
    var depth: String

    @Property(title: "最大震度")
    var maxIntensity: String

    @Property(title: "発生時刻")
    var occurredAt: String

    @Property(title: "対象地域の震度") var regionalIntensity: String?
    @Property(title: "最大震度・分類") var maximumIntensityValue: EarthquakeIntensity?
    @Property(title: "地域震度の値") var regionalIntensityValue: EarthquakeIntensity?
    @Property(title: "情報状態") var informationStatus: String
    @Property(title: "訓練情報") var isTraining: Bool
    @Property(title: "試験情報") var isTest: Bool
    @Property(title: "発生日時") var originTime: Date?
    @Property(title: "検知日時") var arrivalTime: Date?
    @Property(title: "発生日時の精度") var timePrecision: String
    @Property(title: "マグニチュードの数値") var magnitudeValue: Double?
    @Property(title: "深さの数値（km）") var depthValue: Double?
    @Property(title: "地震種別") var earthquakeType: String

    var displayRepresentation: DisplayRepresentation {
        DisplayRepresentation(
            title: "\(hypocenterName)",
            subtitle: "最大震度\(maxIntensity) \(magnitude)"
        )
    }

    init(item: EarthquakeDisplayItem) {
        self.id = item.id
        self.hypocenterName = item.hypocenterName
        self.magnitude = item.magnitude
        self.depth = item.depth.isEmpty ? "不明" : item.depth
        self.maxIntensity = EarthquakeIntentDialog.maximumIntensityLabel(item: item)
        self.occurredAt = EarthquakeIntentDialog.timeDescription(item: item)
        self.maximumIntensityValue = EarthquakeIntensity.maximum(item: item)
        self.regionalIntensityValue = item.regionalIntensity.flatMap { EarthquakeIntensity(rawValue: $0.rawValue) }
        self.regionalIntensity = item.regionalIntensity?.titleText
        self.informationStatus = item.status.isNormal ? "通常" : item.status.displayString
        self.isTraining = item.status == .training
        self.isTest = item.status == .test
        self.originTime = item.sourceOriginTime
        self.arrivalTime = item.sourceArrivalTime
        self.timePrecision = item.originTimePrecision.rawValue
        self.magnitudeValue = item.magnitudeValue
        self.depthValue = item.depthValue
        self.earthquakeType = item.earthquakeType.rawValue
    }
}

struct EarthquakeEntityQuery: EntityQuery {
    func entities(for identifiers: [String]) async throws -> [EarthquakeEntity] {
        try await resolve(identifiers: identifiers, fetch: { try await EarthquakeFetcher.fetchEntity($0) })
    }

    /// 地域震度は地域検索の結果にだけ含める。ID再解決は地震全体の最新情報を返す。
    func resolve(
        identifiers: [String],
        fetch: (String) async throws -> EarthquakeDisplayItem?
    ) async throws -> [EarthquakeEntity] {
        var seen = Set<String>()
        var entities: [EarthquakeEntity] = []
        for id in identifiers where id.count == 14 && id.utf8.allSatisfy({ (48...57).contains($0) }) {
            guard seen.insert(id).inserted else { continue }
            if let item = try await fetch(id) { entities.append(EarthquakeEntity(item: item)) }
        }
        return entities
    }
    func suggestedEntities() async throws -> [EarthquakeEntity] { [] }
}

/// 過去の震度5・6と現在の弱/強、未入電や非数値分類を区別する。
enum EarthquakeIntensity: String, AppEnum {
    case zero = "0", one = "1", two = "2", three = "3", four = "4"
    case fiveLower = "5-", fiveUpper = "5+", sixLower = "6-", sixUpper = "6+", seven = "7"
    case fiveLowerNoInput = "!5-", sixLowerNoInput = "!6-"
    case historicalFive = "5", historicalSix = "6", feltUnknown = "9"
    case remarkable = "R", somewhatRemarkable = "M", smallLocal = "S", local = "L"
    case felt = "F", nearbyFelt = "X"

    static let typeDisplayRepresentation: TypeDisplayRepresentation = "震度・地震分類"
    static let caseDisplayRepresentations: [Self: DisplayRepresentation] = [
        .zero: "震度0", .one: "震度1", .two: "震度2", .three: "震度3", .four: "震度4",
        .fiveLower: "震度5弱", .fiveUpper: "震度5強", .sixLower: "震度6弱", .sixUpper: "震度6強", .seven: "震度7",
        .fiveLowerNoInput: "震度5弱以上未入電", .sixLowerNoInput: "震度6弱以上未入電",
        .historicalFive: "震度5（旧分類）", .historicalSix: "震度6（旧分類）",
        .feltUnknown: "有感・震度不明", .remarkable: "顕著地震", .somewhatRemarkable: "やや顕著地震",
        .smallLocal: "小局発地震", .local: "局発地震", .felt: "有感", .nearbyFelt: "付近有感",
    ]

    static func maximum(item: EarthquakeDisplayItem) -> Self? {
        if let classification = item.earthquakeMaxIntensityClass {
            switch classification.rawValue {
            case "A": return .fiveLower
            case "B": return .fiveUpper
            case "C": return .sixLower
            case "D": return .sixUpper
            default: return Self(rawValue: classification.rawValue)
            }
        }
        return item.earthquakeMaxIntensity.flatMap { Self(rawValue: $0.rawValue) }
    }
}
