//
//  EarthquakeWidgetCache.swift
//  Widget
//

import Foundation

struct EarthquakeWidgetCache {
    struct Snapshot: Codable {
        let fetchedAt: Date
        let earthquakes: [EarthquakeDisplayItem]
    }

    private let directory: URL?

    init(
        directory: URL? = FileManager.default
            .containerURL(forSecurityApplicationGroupIdentifier: WidgetRegionResolver.appGroupSuiteName)?
            .appendingPathComponent("Library/Caches/EarthquakeWidget", isDirectory: true)
    ) {
        self.directory = directory
    }

    func load(plan: WidgetFetchPlan, baseURL: URL) -> Snapshot? {
        guard let url = fileURL(plan: plan, baseURL: baseURL),
              let data = try? Data(contentsOf: url)
        else {
            return nil
        }
        return try? JSONDecoder().decode(Snapshot.self, from: data)
    }

    func save(_ snapshot: Snapshot, plan: WidgetFetchPlan, baseURL: URL) {
        guard let directory,
              let url = fileURL(plan: plan, baseURL: baseURL),
              let data = try? JSONEncoder().encode(snapshot)
        else {
            return
        }
        try? FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true)
        try? data.write(to: url, options: .atomic)
    }

    // 接続先 API を切り替えたあとに別サーバの結果を出さないよう、ホストもファイル名に含める
    private func fileURL(plan: WidgetFetchPlan, baseURL: URL) -> URL? {
        let name = "\(baseURL.host ?? "unknown")-\(plan.cacheKey)-v1"
        let safeName = String(name.map { $0.isLetter || $0.isNumber || $0 == "-" || $0 == "." ? $0 : "_" })
        return directory?.appendingPathComponent("\(safeName).json")
    }
}

private extension WidgetFetchPlan {
    var cacheKey: String {
        switch self {
        case .nationwide: "nationwide"
        case .region(let code): "region-\(code)"
        case .prefecture(let code): "prefecture-\(code)"
        case .city(let code): "city-\(code)"
        }
    }
}
