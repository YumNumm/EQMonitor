//
//  WidgetErrorMessageTests.swift
//  WidgetModelsTests
//
//  ウィジェットのエラー表示に開発者向けの生の例外文言が出ないことを保証する。
//

import Foundation
import Testing

struct WidgetErrorMessageTests {
    @Test func offlineTellsUserToCheckConnection() {
        #expect(WidgetErrorMessage.network(.notConnectedToInternet)
                == "インターネットに接続されていません")
        #expect(WidgetErrorMessage.network(.dataNotAllowed)
                == "インターネットに接続されていません")
    }

    @Test func hostFailuresAreReportedAsServerUnreachable() {
        #expect(WidgetErrorMessage.network(.cannotFindHost)
                == "サーバーに接続できませんでした")
        #expect(WidgetErrorMessage.network(.networkConnectionLost)
                == "サーバーに接続できませんでした")
    }

    @Test func timeoutHasDedicatedMessage() {
        #expect(WidgetErrorMessage.network(.timedOut) == "通信がタイムアウトしました")
    }

    @Test func unclassifiedNetworkErrorFallsBackToGenericMessage() {
        #expect(WidgetErrorMessage.network(.badServerResponse)
                == "通信エラーが発生しました")
    }

    @Test func serverErrorsAreMappedByStatusCode() {
        #expect(WidgetErrorMessage.server(statusCode: 500) == "サーバーが応答していません")
        #expect(WidgetErrorMessage.server(statusCode: 503) == "サーバーが応答していません")
        #expect(WidgetErrorMessage.server(statusCode: 429) == "アクセスが集中しています")
        #expect(WidgetErrorMessage.server(statusCode: 400) == WidgetErrorMessage.unknown)
    }

    /// どの分岐でも改行や例外の debugDescription を含まない短文であること。
    /// ウィジェットは面積が狭く、長文が入るとレイアウトが崩れる。
    @Test func allMessagesAreShortSingleLine() {
        let messages = [
            WidgetErrorMessage.unknown,
            WidgetErrorMessage.network(.notConnectedToInternet),
            WidgetErrorMessage.network(.cannotFindHost),
            WidgetErrorMessage.network(.timedOut),
            WidgetErrorMessage.network(.badServerResponse),
            WidgetErrorMessage.server(statusCode: 500),
            WidgetErrorMessage.server(statusCode: 429),
        ]
        for message in messages {
            #expect(!message.contains("\n"))
            #expect(message.count <= 20)
        }
    }
}
