//
//  EarthquakeFetcher.swift
//  AppIntentExtension
//
//  WidgetFetchPlan に応じて EarthquakeAPIService の取得メソッドへ分岐する。
//

import Foundation
import EQMonitorAPI

enum EarthquakeFetcher {
    static func fetch(
        plan: WidgetFetchPlan,
        limit: Int,
        minIntensity: Components.Schemas.JmaIntensity?
    ) async throws -> [EarthquakeDisplayItem] {
        let service = EarthquakeAPIService.shared
        switch plan {
        case .nationwide:
            return try await service.fetchEarthquakes(
                limit: limit, minIntensity: minIntensity)
        case .region(let code):
            return try await service.fetchEarthquakesByRegion(
                regionCode: code, limit: limit, minIntensity: minIntensity)
        case .prefecture(let code):
            return try await service.fetchEarthquakesByPrefecture(
                prefectureCode: code, limit: limit, minIntensity: minIntensity)
        case .city(let code):
            return try await service.fetchEarthquakesByCity(
                cityCode: code, limit: limit, minIntensity: minIntensity)
        }
    }
}
