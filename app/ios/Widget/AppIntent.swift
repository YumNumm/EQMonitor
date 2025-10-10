//
//  AppIntent.swift
//  Widget
//
//  Created by 尾上 遼太朗 on 2025/10/09.
//

import WidgetKit
import AppIntents

enum RegionType: String, AppEnum {
    case currentLocation
    case specificRegion
    case nationwide

    static var typeDisplayRepresentation: TypeDisplayRepresentation {
        "表示範囲"
    }

    static var caseDisplayRepresentations: [RegionType: DisplayRepresentation] {
        [
            .currentLocation: "現在地",
            .specificRegion: "指定地域",
            .nationwide: "全国"
        ]
    }
}

struct RegionEntity: AppEntity {
    let id: String
    let name: String

    static var typeDisplayRepresentation: TypeDisplayRepresentation {
        "地域"
    }

    var displayRepresentation: DisplayRepresentation {
        DisplayRepresentation(title: "\(name)")
    }

    static var defaultQuery = RegionEntityQuery()
}

struct RegionEntityQuery: EntityQuery {
    func entities(for identifiers: [String]) async throws -> [RegionEntity] {
        let allRegions = RegionLoader.loadRegions()
        return allRegions
            .filter { identifiers.contains($0.code) }
            .map { RegionEntity(id: $0.code, name: $0.name) }
    }

    func suggestedEntities() async throws -> [RegionEntity] {
        let allRegions = RegionLoader.loadRegions()
        // 最初の20件を表示
        return allRegions.prefix(20).map { RegionEntity(id: $0.code, name: $0.name) }
    }

    func defaultResult() async -> RegionEntity? {
        // デフォルトは東京都23区
        return RegionEntity(id: "350", name: "東京都２３区")
    }
}

struct EarthquakeWidgetIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource { "地震履歴設定" }
    static var description: IntentDescription { "表示する地域を選択してください" }

    @Parameter(title: "表示範囲", default: .nationwide)
    var regionType: RegionType

    @Parameter(title: "地域")
    var region: RegionEntity?

    init() {}

    init(regionType: RegionType, region: RegionEntity? = nil) {
        self.regionType = regionType
        self.region = region
    }
}

// ウィジェット再読み込み用Intent
struct RefreshWidgetIntent: AppIntent {
    static var title: LocalizedStringResource { "ウィジェットを更新" }
    static var description: IntentDescription { "地震情報を最新の状態に更新します" }

    func perform() async throws -> some IntentResult {
        // すべてのウィジェットを再読み込み
        WidgetCenter.shared.reloadAllTimelines()
        return .result()
    }
}
