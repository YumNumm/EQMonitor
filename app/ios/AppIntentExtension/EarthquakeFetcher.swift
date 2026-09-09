//
//  EarthquakeFetcher.swift
//  AppIntentExtension
//
//  WidgetFetchPlan に応じて EarthquakeAPIService の取得メソッドへ分岐する。
//

import Foundation
import EQMonitorAPI

enum EarthquakeFetcher {
    static func fetchEntity(_ id: String, service: EarthquakeAPIService = .shared) async throws -> EarthquakeDisplayItem? {
        do {
            return try await service.fetchEarthquake(eventID: id)
        } catch {
            throw normalizedError(error)
        }
    }

    static func fetch(
        plan: WidgetFetchPlan,
        limit: Int,
        minIntensity: Components.Schemas.JmaIntensity?,
        service: EarthquakeAPIService = .shared
    ) async throws -> [EarthquakeDisplayItem] {
        do {
            return try await fetchItems(plan: plan, limit: limit, minIntensity: minIntensity, service: service)
        } catch {
            throw normalizedError(error)
        }
    }

    static func normalizedError(_ error: any Error) -> any Error {
        if error is CancellationError || (error as? ClientError)?.underlyingError is CancellationError {
            return CancellationError()
        }
        return EQIntentError.fetchFailed(APIError.from(error).errorDescription ?? WidgetErrorMessage.unknown)
    }

    static func fetchItems(
        plan: WidgetFetchPlan, limit: Int, minIntensity: Components.Schemas.JmaIntensity?,
        service: EarthquakeAPIService
    ) async throws -> [EarthquakeDisplayItem] {
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
