//
//  RegionEntity.swift
//  AppIntentExtension
//
//  Intent の「対象地域」パラメータ。都道府県・市区町村を名前検索で選択できる。
//

import AppIntents

struct RegionEntity: AppEntity {
    static let typeDisplayRepresentation: TypeDisplayRepresentation = "地域"
    static let defaultQuery = RegionQuery()

    /// `"prefecture:01"` / `"city:0123500"` 形式
    let id: String
    let name: String
    let kind: JmaCodeTable.JmaArea.Kind

    var displayRepresentation: DisplayRepresentation {
        DisplayRepresentation(
            title: "\(name)",
            subtitle: kind == .prefecture ? "都道府県" : "市区町村"
        )
    }

    init(area: JmaCodeTable.JmaArea) {
        self.id = "\(area.kind.rawValue):\(area.code)"
        self.name = area.nameJa
        self.kind = area.kind
    }

    /// API 取得プランへの変換
    var fetchPlan: WidgetFetchPlan {
        let code = String(id.split(separator: ":", maxSplits: 1)[1])
        switch kind {
        case .prefecture:
            return .prefecture(code: code)
        case .city:
            return .city(code: code)
        }
    }
}

struct RegionQuery: EntityStringQuery {
    private var allAreas: [JmaCodeTable.JmaArea] {
        JmaCodeTable.shared.prefectures + JmaCodeTable.shared.cities
    }

    func entities(for identifiers: [String]) async throws -> [RegionEntity] {
        let wanted = Set(identifiers)
        return allAreas
            .filter { wanted.contains("\($0.kind.rawValue):\($0.code)") }
            .map(RegionEntity.init)
    }

    func entities(matching string: String) async throws -> [RegionEntity] {
        Array(
            allAreas
                .filter { $0.nameJa.contains(string) }
                .prefix(30)
                .map(RegionEntity.init)
        )
    }

    func suggestedEntities() async throws -> [RegionEntity] {
        JmaCodeTable.shared.prefectures.map(RegionEntity.init)
    }
}
