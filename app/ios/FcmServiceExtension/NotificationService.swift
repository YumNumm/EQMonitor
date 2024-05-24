//
//  NotificationService.swift
//  FcmServiceExtension
//
//  Created by 尾上 遼太朗 on 2024/05/23.
//

import UserNotifications
import Gzip

class NotificationService: UNNotificationServiceExtension {
    
    var contentHandler: ((UNNotificationContent) -> Void)?
    var bestAttemptContent: UNMutableNotificationContent?
    
    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
        self.contentHandler = contentHandler
        bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent)
        
        let notificationSettings = try? loadNotificationSettings()
        let payload = request.content.userInfo["payload"] as? String
        if(notificationSettings == nil || payload == nil) {
            contentHandler(bestAttemptContent!)
            return
        }
        
        let notificationPayload = try? decodePayload(payload: payload!)
        if(notificationPayload == nil) {
            contentHandler(bestAttemptContent!)
            return
        }
        
        // EEW
        if(notificationPayload!.type == .eew){
            var shouldSilent = false
            var shouldCritical = true // false
            
            // 最大震度の検証
            if (notificationPayload!.eewInformation.maxIntensity.rawValue >= notificationSettings!.eewSettings.emergencyIntensity.rawValue ){
                shouldCritical = true
            }
            if (notificationPayload!.eewInformation.maxIntensity.rawValue <= notificationSettings!.eewSettings.silentIntensity.rawValue) {
                shouldSilent = true
            }
            var replaceSubTitle: String?
            // 各地域ごとの検証
            for area in notificationPayload!.eewInformation.regionIntensities {
                let matchedArea = notificationSettings!.eewSettings.regions.first(where: {$0.code == area.code})
                if (matchedArea != nil){
                    if (area.intensity.rawValue >= matchedArea!.emergencyIntensity.rawValue){
                        shouldCritical = true
                    }
                    if (area.intensity.rawValue <= matchedArea!.silentIntensity.rawValue){
                        shouldSilent = true
                    }
                    if(matchedArea!.isMain){
                        replaceSubTitle = "\(matchedArea!.name)で予想震度\(area.intensity)"
                        if(area.hasArrivalTime){
                            let arrivalTime = area.arrivalTime.date
                            let now = Date()
                            let diffInSeconds = arrivalTime.timeIntervalSince(now)
                            if(diffInSeconds > 0){
                                replaceSubTitle = "あと\(diffInSeconds)秒で到達 \(replaceSubTitle!)"
                            }else {
                                replaceSubTitle = "到達済み \(replaceSubTitle!)"
                            }
                        }
                    }
                }
            }
            if (shouldSilent) {
                bestAttemptContent!.sound = nil
                bestAttemptContent!.interruptionLevel = .passive
            }
            if(shouldCritical){
                bestAttemptContent!.interruptionLevel = .critical
            }
            
            if(replaceSubTitle != nil){
                bestAttemptContent!.subtitle = replaceSubTitle!
            }
            
            contentHandler(bestAttemptContent!)
            return
            
        }
        
    }
    
    override func serviceExtensionTimeWillExpire() {
        // Called just before the extension will be terminated by the system.
        // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
        if let contentHandler = contentHandler, let bestAttemptContent =  bestAttemptContent {
            contentHandler(bestAttemptContent)
        }
    }
    
    
    /// ProtoBufのデコード
    func decodePayload(payload: String) throws -> Eqmonitor_NotificationPayload {
        // decode base64
        let base64String = payload
        let decodedData = Data(base64Encoded: base64String)!
        // gunzip
        let gunzippedData = try! decodedData.gunzipped()
        // decode protobuf
        let notificationPayload = try Eqmonitor_NotificationPayload(serializedData: gunzippedData)
        return notificationPayload
    }
    
    // 設定の読み出し
    func loadNotificationSettings() throws -> Eqmonitor_NotificationSettings {
        let appGroup = UserDefaults(suiteName: "group.net.yumnumm.eqmonitor")!
        let value = appGroup.string(forKey: "notification_settings")
        if let value = value {
            let data = Data(base64Encoded: value)!
            return try Eqmonitor_NotificationSettings(serializedData: data)
        }
        throw NSError()
        
    }
}
