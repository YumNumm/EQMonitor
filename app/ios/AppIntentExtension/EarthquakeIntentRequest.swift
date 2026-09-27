import AppIntents
import Foundation

/// 主Intentとカードの直接実行・更新に共通の検証。保存地域を現在地とは断定しない。
struct EarthquakeIntentRequest: Sendable {
    let plan: WidgetFetchPlan
    let area: String
    let isSavedLocation: Bool
    let limit: Int

    static func resolve(
        regionID: String?, limit: Int,
        settings: WidgetRegionSettings,
        areas: [JmaCodeTable.JmaArea]
    ) throws -> Self {
        guard (1...10).contains(limit) else { throw EQIntentError.invalidLimit }
        guard let regionID else {
            return Self(plan: .nationwide, area: "全国", isSavedLocation: false, limit: limit)
        }
        if regionID.hasPrefix("region:") {
            guard let code = settings.currentLocationRegionCode,
                  code.count == 3, code.utf8.allSatisfy({ (48...57).contains($0) }),
                  regionID == "region:\(code)",
                  let name = settings.currentLocationRegionName,
                  !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
            else { throw EQIntentError.locationUnavailable }
            return Self(plan: .region(code: code), area: "保存地域（\(name)）", isSavedLocation: true, limit: limit)
        }
        guard let area = areas.first(where: { "\($0.kind.rawValue):\($0.code)" == regionID }) else {
            throw EQIntentError.invalidRegion
        }
        guard settings.isPro else { throw EQIntentError.proRequired }
        let plan: WidgetFetchPlan = area.kind == .prefecture
            ? .prefecture(code: area.code) : .city(code: area.code)
        return Self(plan: plan, area: area.nameJa, isSavedLocation: false, limit: limit)
    }

    static func current(regionID: String?, limit: Int) throws -> Self {
        try resolve(
            regionID: regionID, limit: limit,
            settings: WidgetRegionResolver.settings(
                from: UserDefaults(suiteName: WidgetRegionResolver.appGroupSuiteName)),
            areas: JmaCodeTable.shared.prefectures + JmaCodeTable.shared.cities
        )
    }

    var locationNotice: String {
        isSavedLocation ? "位置の取得時刻は不明です。現在地とは限りません。" : ""
    }
}

// 一時的な描画キャッシュは、APIの最新状態や現在地の代用にしない。
actor EarthquakeSnippetStore {
    static let shared = EarthquakeSnippetStore()
    struct Snapshot: Sendable {
        let request: EarthquakeIntentRequest
        let items: [EarthquakeDisplayItem]
        let fetchedAt: Date
        let wasRefreshed: Bool
        var minIntensity: MinIntensityOption? = nil
    }
    private var snapshots: [String: Snapshot] = [:]

    func save(_ snapshot: Snapshot, id: String = UUID().uuidString) -> String {
        // 表示セッションを超えて保持しない。失効時は全国や最新情報で代替しない。
        snapshots = snapshots.filter { snapshot.fetchedAt.timeIntervalSince($0.value.fetchedAt) < 3600 }
        snapshots[id] = snapshot
        return id
    }

    func get(_ id: String, now: Date = Date()) throws -> Snapshot {
        guard let snapshot = snapshots[id],
              now.timeIntervalSince(snapshot.fetchedAt) < 3600 else { throw EQIntentError.snapshotUnavailable }
        return snapshot
    }
}
