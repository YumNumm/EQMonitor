//
//  NotificationService.swift
//  FcmServiceExtension
//
//  Created by 尾上 遼太朗 on 2024/05/23.
//

import Foundation
import UserNotifications
import WidgetKit

class NotificationService: UNNotificationServiceExtension {

    var contentHandler: ((UNNotificationContent) -> Void)?
    var bestAttemptContent: UNMutableNotificationContent?

    override func didReceive(
        _ request: UNNotificationRequest,
        withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void
    ) {
        self.contentHandler = contentHandler
        bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent)

        // Record telemetry event for notification receipt
        let now = Int64(Date().timeIntervalSince1970 * 1000)
        let eventId = (request.content.userInfo["eventId"] as? String)
        let channelId = (request.content.userInfo["channelId"] as? String) ?? "unknown"
        let payloadDict: [String: Any] = [
            "framework": "apns",
            "channel_id": channelId,
            "title": request.content.title,
        ]
        if let payloadData = try? JSONSerialization.data(withJSONObject: payloadDict),
           let payloadStr = String(data: payloadData, encoding: .utf8) {
            TelemetryWriter.record(
                eventType: "notification_received",
                timestampMs: now,
                eventId: eventId,
                payload: payloadStr
            )
        }

        // 地震情報の通知（VXSE* テレグラム）はウィジェットの地震履歴を更新しうるため、
        // 受信時にタイムラインを再読み込みし、15分ポーリングを待たず即時反映する。
        if channelId.hasPrefix("VXSE") {
            WidgetCenter.shared.reloadAllTimelines()
        }

        contentHandler(bestAttemptContent!)
    }

    override func serviceExtensionTimeWillExpire() {
        // Called just before the extension will be terminated by the system.
        // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
        if let contentHandler = contentHandler, let bestAttemptContent = bestAttemptContent {
            contentHandler(bestAttemptContent)
        }
    }
}
