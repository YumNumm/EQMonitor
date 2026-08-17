//
//  WidgetErrorMessage.swift
//  Shared (WidgetExtension / AppIntentExtension / WidgetModelsTests)
//
//  ウィジェットに表示する取得失敗メッセージ。
//
//  ウィジェットは面積が限られており、開発者向けの例外文言（swift-openapi-runtime の
//  ClientError や NSError の debugDescription など）をそのまま出すとレイアウトが崩れ、
//  ユーザにとって意味のない情報になる。原因を数語で示す文言へ正規化する。
//

import Foundation

enum WidgetErrorMessage {
    /// 原因を特定できないときに表示する既定の文言
    static let unknown = "地震情報を取得できませんでした"

    /// 通信エラーの文言。URLError の code から原因を絞り込む。
    static func network(_ code: URLError.Code) -> String {
        switch code {
        case .notConnectedToInternet, .dataNotAllowed:
            return "インターネットに接続されていません"
        case .networkConnectionLost, .cannotConnectToHost, .cannotFindHost,
             .dnsLookupFailed:
            return "サーバーに接続できませんでした"
        case .timedOut:
            return "通信がタイムアウトしました"
        default:
            return "通信エラーが発生しました"
        }
    }

    /// HTTP ステータスコードの文言
    static func server(statusCode: Int) -> String {
        switch statusCode {
        case 429:
            return "アクセスが集中しています"
        case 500...599:
            return "サーバーが応答していません"
        default:
            return unknown
        }
    }
}
