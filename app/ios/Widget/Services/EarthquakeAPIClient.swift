//
//  EarthquakeAPIClient.swift
//  Widget
//
//  API v2 クライアント（EQMonitorAPI 生成コードを使用）
//

import Foundation
import EQMonitorAPI

// MARK: - API Error Types

enum APIError: Error, LocalizedError {
    case networkError(Error)
    case invalidResponse
    case decodingError(String)
    case serverError(Int)
    case invalidURL

    var errorDescription: String? {
        switch self {
        case .networkError(let error):
            return "ネットワークエラー: \(error.localizedDescription)"
        case .invalidResponse:
            return "無効なレスポンス"
        case .decodingError(let detail):
            return "データ解析エラー: \(detail)"
        case .serverError(let code):
            return "サーバーエラー (\(code))"
        case .invalidURL:
            return "無効なURL"
        }
    }
}

// MARK: - API Service

class EarthquakeAPIService {
    private let client: Client

    init(baseURL: URL) {
        self.client = Client(
            serverURL: baseURL,
            transport: URLSessionTransport()
        )
    }

    // MARK: - Fetch Earthquakes (全国)

    /// 地震情報一覧を取得
    /// - Parameters:
    ///   - limit: 取得件数（デフォルト10件）
    /// - Returns: Widget表示用の地震情報配列
    func fetchEarthquakes(limit: Int = 10) async throws -> [EarthquakeDisplayItem] {
        let response = try await client.getV2Earthquake(
            query: .init(limit: String(limit))
        )
        switch response {
        case .ok(let okResponse):
            let body = try okResponse.body.json
            return body.items.map { EarthquakeDisplayItem(from: $0) }
        case .badRequest:
            throw APIError.serverError(400)
        case .internalServerError:
            throw APIError.serverError(500)
        case .undocumented(let statusCode, _):
            throw APIError.serverError(statusCode)
        }
    }

    // MARK: - Fetch Earthquakes by Region

    /// 地域別の地震情報を取得
    /// - Parameters:
    ///   - regionCode: 震度細分区域コード
    ///   - limit: 取得件数（デフォルト10件）
    /// - Returns: Widget表示用の地震情報配列
    func fetchEarthquakesByRegion(regionCode: String, limit: Int = 10) async throws -> [EarthquakeDisplayItem] {
        let response = try await client.getV2EarthquakeIntensityRegionByCode(
            path: .init(code: regionCode),
            query: .init(limit: String(limit))
        )
        switch response {
        case .ok(let okResponse):
            let body = try okResponse.body.json
            return body.items.map { EarthquakeDisplayItem(from: $0) }
        case .badRequest:
            throw APIError.serverError(400)
        case .internalServerError:
            throw APIError.serverError(500)
        case .undocumented(let statusCode, _):
            throw APIError.serverError(statusCode)
        }
    }
}

// MARK: - Config Reader

/// xconfigから設定を読み込むヘルパー
class ConfigReader {
    /// APIベースURLを取得
    /// 優先順位: App Groups UserDefaults → Info.plist (REST_API_URL) → ハードコードフォールバック
    static func getAPIBaseURL() -> URL {
        // Flutter アプリが App Groups UserDefaults に書き込んだ URL を優先する
        if let appGroupDefaults = UserDefaults(suiteName: "group.net.yumnumm.eqmonitor"),
           let urlString = appGroupDefaults.string(forKey: "apiServerUrl"),
           !urlString.isEmpty,
           let url = URL(string: urlString) {
            return url
        }
        if let urlString = Bundle.main.object(forInfoDictionaryKey: "REST_API_URL") as? String,
           !urlString.isEmpty,
           let url = URL(string: urlString) {
            return url
        }
        // フォールバック
        return URL(string: "https://api.eqmonitor.app")!
    }
}

// MARK: - Shared Instance

extension EarthquakeAPIService {
    /// 共有インスタンス
    static let shared = EarthquakeAPIService(baseURL: ConfigReader.getAPIBaseURL())
}
