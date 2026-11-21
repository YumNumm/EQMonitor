//
//  Widget.swift
//  Widget
//
//  Created by 尾上 遼太朗 on 2025/10/09.
//

import WidgetKit
import SwiftUI

struct EarthquakeEntry: TimelineEntry {
    let date: Date
    let configuration: EarthquakeWidgetIntent
    let earthquakes: [EarthquakeDisplayItem]
    let error: String?
    let fetchedAt: Date?
    let isStale: Bool
    let title: String
    let compactTitle: String
    let relevance: TimelineEntryRelevance?

    init(
        date: Date,
        configuration: EarthquakeWidgetIntent,
        earthquakes: [EarthquakeDisplayItem],
        error: String?,
        resolved: ResolvedWidgetRegion? = nil,
        fetchedAt: Date? = nil,
        isStale: Bool = false
    ) {
        self.date = date
        self.configuration = configuration
        // 訓練・テストの電文は表示しない。API にも通常のみを要求するが、前回分の保存内容にも効かせる
        self.earthquakes = earthquakes.filter(\.isNormal)
        self.error = error
        self.fetchedAt = fetchedAt
        self.isStale = isStale
        let resolved = resolved ?? WidgetRegionResolver.resolve(regionType: configuration.regionType)
        self.title = resolved.title
        self.compactTitle = resolved.compactTitle
        self.relevance = isStale
            ? nil
            : EarthquakeRelevance.make(earthquakes: self.earthquakes, plan: resolved.plan, now: date)
    }
}

// 直近に揺れの大きい地震があるとき、スマートスタックで前面に出やすくする。
// 全国表示は地震が絶えず並ぶため、震度 4 以上だけを対象にする。
enum EarthquakeRelevance {
    private static let window: TimeInterval = 3 * 60 * 60

    static func make(
        earthquakes: [EarthquakeDisplayItem],
        plan: WidgetFetchPlan,
        now: Date
    ) -> TimelineEntryRelevance? {
        let minimumLevel = plan == .nationwide ? 2 : 1
        let candidates = earthquakes.compactMap { earthquake -> (level: Int, remaining: TimeInterval)? in
            guard let time = earthquake.sourceOriginTime ?? earthquake.sourceArrivalTime else { return nil }
            let elapsed = now.timeIntervalSince(time)
            guard elapsed >= 0, elapsed < window, earthquake.dangerLevel >= minimumLevel else { return nil }
            return (earthquake.dangerLevel, window - elapsed)
        }
        guard let strongest = candidates.max(by: { $0.level < $1.level }) else { return nil }
        return TimelineEntryRelevance(score: Float(strongest.level), duration: strongest.remaining)
    }
}

struct EarthquakeTimelineProvider: AppIntentTimelineProvider {
    typealias Entry = EarthquakeEntry
    typealias Intent = EarthquakeWidgetIntent

    private let cache = EarthquakeWidgetCache()

    func placeholder(in context: Context) -> EarthquakeEntry {
        sampleEntry(configuration: EarthquakeWidgetIntent())
    }

    func snapshot(for configuration: EarthquakeWidgetIntent, in context: Context) async -> EarthquakeEntry {
        // ギャラリー以外で見本を返すと、実在しない地震が実際の情報に見えてしまう
        guard !context.isPreview else {
            return sampleEntry(configuration: configuration)
        }
        let now = Date()
        let resolved = WidgetRegionResolver.resolve(regionType: configuration.regionType)
        if let cached = cache.load(plan: resolved.plan, baseURL: ConfigReader.getAPIBaseURL()) {
            return EarthquakeEntry(
                date: now,
                configuration: configuration,
                earthquakes: cached.earthquakes,
                error: nil,
                resolved: resolved,
                fetchedAt: cached.fetchedAt
            )
        }
        return await loadEntry(configuration: configuration, resolved: resolved, now: now).entry
    }

    func timeline(for configuration: EarthquakeWidgetIntent, in context: Context) async -> Timeline<EarthquakeEntry> {
        let now = Date()
        let resolved = WidgetRegionResolver.resolve(regionType: configuration.regionType)
        let result = await loadEntry(configuration: configuration, resolved: resolved, now: now)
        let reloadMinutes: TimeInterval = result.succeeded ? 15 : 5
        return Timeline(entries: [result.entry], policy: .after(now.addingTimeInterval(reloadMinutes * 60)))
    }

    private func sampleEntry(configuration: EarthquakeWidgetIntent) -> EarthquakeEntry {
        let now = Date()
        return EarthquakeEntry(
            date: now,
            configuration: configuration,
            earthquakes: EarthquakeDisplayItem.mockData,
            error: nil,
            fetchedAt: now
        )
    }

    private func loadEntry(
        configuration: EarthquakeWidgetIntent,
        resolved: ResolvedWidgetRegion,
        now: Date
    ) async -> (entry: EarthquakeEntry, succeeded: Bool) {
        let baseURL = ConfigReader.getAPIBaseURL()
        do {
            let earthquakes = try await fetch(plan: resolved.plan, using: EarthquakeAPIService.shared)
            cache.save(.init(fetchedAt: now, earthquakes: earthquakes), plan: resolved.plan, baseURL: baseURL)
            let entry = EarthquakeEntry(
                date: now,
                configuration: configuration,
                earthquakes: earthquakes,
                error: nil,
                resolved: resolved,
                fetchedAt: now
            )
            return (entry, true)
        } catch {
            if let cached = cache.load(plan: resolved.plan, baseURL: baseURL) {
                let entry = EarthquakeEntry(
                    date: now,
                    configuration: configuration,
                    earthquakes: cached.earthquakes,
                    error: nil,
                    resolved: resolved,
                    fetchedAt: cached.fetchedAt,
                    isStale: true
                )
                return (entry, false)
            }
            let entry = EarthquakeEntry(
                date: now,
                configuration: configuration,
                earthquakes: [],
                error: APIError.from(error).errorDescription ?? WidgetErrorMessage.unknown,
                resolved: resolved
            )
            return (entry, false)
        }
    }

    private func fetch(
        plan: WidgetFetchPlan,
        using apiService: EarthquakeAPIService
    ) async throws -> [EarthquakeDisplayItem] {
        let limit = WidgetLayoutPolicy.fetchLimit
        switch plan {
        case .nationwide:
            return try await apiService.fetchEarthquakes(limit: limit, normalOnly: true)
        case .region(let code):
            return try await apiService.fetchEarthquakesByRegion(regionCode: code, limit: limit, normalOnly: true)
        case .prefecture(let code):
            return try await apiService.fetchEarthquakesByPrefecture(prefectureCode: code, limit: limit, normalOnly: true)
        case .city(let code):
            return try await apiService.fetchEarthquakesByCity(cityCode: code, limit: limit, normalOnly: true)
        }
    }
}

struct EarthquakeWidget: Widget {
    let kind: String = "EarthquakeWidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(
            kind: kind,
            intent: EarthquakeWidgetIntent.self,
            provider: EarthquakeTimelineProvider()
        ) { entry in
            EarthquakeWidgetView(entry: entry)
                .containerBackground(for: .widget) {
                    EQWidgetBackground()
                }
        }
        .configurationDisplayName("地震履歴")
        .description("最近の地震情報を表示します")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
        .contentMarginsDisabled()
    }
}
