//
//  EarthquakeEntity.swift
//  AppIntentExtension
//
//  Intent の戻り値。ショートカットのオートメーションで後続アクションに
//  震源・震度などのプロパティを渡せるようにする。
//

import AppIntents

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
        self.maxIntensity = item.maxIntensity?.titleText ?? "不明"
        self.occurredAt = item.formattedTime
    }
}

struct EarthquakeEntityQuery: EntityQuery {
    // 過去の実行結果を identifier から復元する用途は無いため空実装
    func entities(for identifiers: [String]) async throws -> [EarthquakeEntity] { [] }
    func suggestedEntities() async throws -> [EarthquakeEntity] { [] }
}
