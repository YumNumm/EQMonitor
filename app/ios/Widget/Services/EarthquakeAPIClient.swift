//
//  EarthquakeAPIClient.swift
//  Widget
//
//  API v2 クライアント
//  Dart定義: packages/eqapi_client/lib/src/v2/earthquake_api_client.dart
//

import Foundation

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

// MARK: - DecodingError Extension

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

// MARK: - API Service

class EarthquakeAPIService {
    private let baseURL: URL
    private let decoder: JSONDecoder

    init(baseURL: URL) {
        self.baseURL = baseURL

        // JSONDecoderの設定
        self.decoder = JSONDecoder()

        // スネークケース → キャメルケース自動変換
        self.decoder.keyDecodingStrategy = .convertFromSnakeCase

        // ISO8601日付フォーマットの設定
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

        self.decoder.dateDecodingStrategy = .custom { decoder in
            let container = try decoder.singleValueContainer()
            let dateString = try container.decode(String.self)

            // 複数の形式を試行
            // 1. ISO8601 with fractional seconds: 2025-10-10T21:24:00.123+09:00
            // 2. ISO8601 standard: 2025-10-10T21:24:00+09:00
            // 3. Without colon in timezone: 2025-10-10T21:24:00+0900

            let formatters: [ISO8601DateFormatter] = {
                let f1 = ISO8601DateFormatter()
                f1.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

                let f2 = ISO8601DateFormatter()
                f2.formatOptions = [.withInternetDateTime]

                return [f1, f2]
            }()

            for formatter in formatters {
                if let date = formatter.date(from: dateString) {
                    return date
                }
            }

            // タイムゾーン部分の修正を試みる（+09 -> +09:00）
            let normalizedString = Self.normalizeTimezone(dateString)
            for formatter in formatters {
                if let date = formatter.date(from: normalizedString) {
                    return date
                }
            }

            throw DecodingError.dataCorrupted(
                DecodingError.Context(
                    codingPath: decoder.codingPath,
                    debugDescription: "Invalid date format: \(dateString)"
                )
            )
        }
    }

    /// タイムゾーン表記を正規化
    private static func normalizeTimezone(_ dateString: String) -> String {
        // +09 -> +09:00, -05 -> -05:00 などを正規化
        let pattern = #"([+-])(\d{2})$"#
        if let regex = try? NSRegularExpression(pattern: pattern, options: []) {
            let range = NSRange(dateString.startIndex..<dateString.endIndex, in: dateString)
            return regex.stringByReplacingMatches(in: dateString, options: [], range: range, withTemplate: "$1$2:00")
        }
        return dateString
    }

    // MARK: - Fetch Earthquakes (全国)

    /// 地震情報一覧を取得
    /// - Parameters:
    ///   - limit: 取得件数（デフォルト10件）
    /// - Returns: Widget表示用の地震情報配列
    func fetchEarthquakes(limit: Int = 10) async throws -> [EarthquakeDisplayItem] {
        guard var urlComponents = URLComponents(string: "\(baseURL.absoluteString)/v2/earthquake") else {
            throw APIError.invalidURL
        }

        urlComponents.queryItems = [
            URLQueryItem(name: "limit", value: String(limit))
        ]

        guard let url = urlComponents.url else {
            throw APIError.invalidURL
        }

        let response: EarthquakeListResponse = try await performRequest(url: url)
        return response.items.toDisplayItems()
    }

    // MARK: - Fetch Earthquakes by Region

    /// 地域別の地震情報を取得
    /// - Parameters:
    ///   - regionCode: 震度細分区域コード
    ///   - limit: 取得件数（デフォルト10件）
    /// - Returns: Widget表示用の地震情報配列
    func fetchEarthquakesByRegion(regionCode: String, limit: Int = 10) async throws -> [EarthquakeDisplayItem] {
        guard var urlComponents = URLComponents(string: "\(baseURL.absoluteString)/v2/earthquake/intensity/region/\(regionCode)") else {
            throw APIError.invalidURL
        }

        urlComponents.queryItems = [
            URLQueryItem(name: "limit", value: String(limit))
        ]

        guard let url = urlComponents.url else {
            throw APIError.invalidURL
        }

        let response: IntensityRegionSearchResponse = try await performRequest(url: url)
        return response.items.toDisplayItems()
    }

    // MARK: - Private Request Helper

    private func performRequest<T: Decodable>(url: URL) async throws -> T {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("EQMonitor-iOS-Widget/1.0", forHTTPHeaderField: "User-Agent")

        // タイムアウト設定
        request.timeoutInterval = 15

        do {
            let (data, response) = try await URLSession.shared.data(for: request)

            guard let httpResponse = response as? HTTPURLResponse else {
                throw APIError.invalidResponse
            }

            guard (200...299).contains(httpResponse.statusCode) else {
                throw APIError.serverError(httpResponse.statusCode)
            }

            #if DEBUG
            if let jsonString = String(data: data, encoding: .utf8) {
                print("API Response (\(url.lastPathComponent)): \(jsonString.prefix(500))")
            }
            #endif

            do {
                return try decoder.decode(T.self, from: data)
            } catch let decodingError as DecodingError {
                #if DEBUG
                print("Decoding Error: \(decodingError.detailedDescription)")
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("Failed JSON: \(jsonString)")
                }
                #endif
                throw APIError.decodingError(decodingError.detailedDescription)
            }

        } catch let error as APIError {
            throw error
        } catch {
            throw APIError.networkError(error)
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
