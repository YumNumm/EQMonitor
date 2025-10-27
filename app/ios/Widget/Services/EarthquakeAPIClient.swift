//
//  EarthquakeAPIClient.swift
//  Widget
//
//  Created by Widget Generator
//

import Foundation

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

// DecodingErrorの詳細を取得
extension DecodingError {
    var detailedDescription: String {
        switch self {
        case .typeMismatch(let type, let context):
            return "型不一致: \(type) at \(context.codingPath.map { $0.stringValue }.joined(separator: "."))"
        case .valueNotFound(let type, let context):
            return "値なし: \(type) at \(context.codingPath.map { $0.stringValue }.joined(separator: "."))"
        case .keyNotFound(let key, let context):
            return "キーなし: \(key.stringValue) at \(context.codingPath.map { $0.stringValue }.joined(separator: "."))"
        case .dataCorrupted(let context):
            return "データ破損: \(context.debugDescription) at \(context.codingPath.map { $0.stringValue }.joined(separator: "."))"
        @unknown default:
            return localizedDescription
        }
    }
}

class EarthquakeAPIService {
    private let baseURL: URL

    init(baseURL: URL) {
        self.baseURL = baseURL
    }

    func fetchEarthquakes(
        limit: Int = 10,
        regionId: String? = nil
    ) async throws -> [EarthquakeItem] {
        var urlComponents: URLComponents

        if let regionId = regionId {
            // 地域別エンドポイント
            guard let components = URLComponents(string: "\(baseURL.absoluteString)/earthquake/region") else {
                throw APIError.invalidURL
            }
            urlComponents = components
            urlComponents.queryItems = [
                URLQueryItem(name: "limit", value: String(limit)),
                URLQueryItem(name: "regionId", value: regionId)
            ]
        } else {
            // 全国エンドポイント
            guard let components = URLComponents(string: "\(baseURL.absoluteString)/earthquake") else {
                throw APIError.invalidURL
            }
            urlComponents = components
            urlComponents.queryItems = [
                URLQueryItem(name: "limit", value: String(limit))
            ]
        }

        guard let url = urlComponents.url else {
            throw APIError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            let (data, response) = try await URLSession.shared.data(for: request)

            guard let httpResponse = response as? HTTPURLResponse else {
                throw APIError.invalidResponse
            }

            guard (200...299).contains(httpResponse.statusCode) else {
                throw APIError.serverError(httpResponse.statusCode)
            }

            let decoder = JSONDecoder()

            // デバッグ: レスポンスの内容をログ出力
            if let jsonString = String(data: data, encoding: .utf8) {
                print("API Response: \(jsonString.prefix(500))")
            }

            do {
                let earthquakeResponse = try decoder.decode(EarthquakeResponse.self, from: data)
                return earthquakeResponse.data.map { EarthquakeItem(from: $0) }
            } catch let decodingError as DecodingError {
                // デコードエラーの詳細をログ出力
                print("Decoding Error: \(decodingError.detailedDescription)")
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("Failed JSON: \(jsonString)")
                }
                throw APIError.decodingError(decodingError.detailedDescription)
            }

        } catch let error as APIError {
            throw error
        } catch {
            throw APIError.networkError(error)
        }
    }
}

// xconfigから設定を読み込むヘルパー
class ConfigReader {
    static func getAPIBaseURL() -> URL {
        if let urlString = Bundle.main.object(forInfoDictionaryKey: "REST_API_URL") as? String,
           let url = URL(string: urlString) {
            return url
        }
        return URL(string: "https://v2.api.eqmonitor.app")!
    }
}
