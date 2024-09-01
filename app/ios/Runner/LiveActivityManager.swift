//
//  Untitled.swift
//  Runner
//
//  Created by 尾上 遼太朗 on 2024/09/02.
//

import Foundation
import ActivityKit
import os.log
import UIKit


@available(iOS 16.1, *)
class LiveActivityManager: NSObject, ObservableObject {
    public static let shared: LiveActivityManager = LiveActivityManager()

    private var currentActivity: Activity<LiveActivityAttributes>? = nil

    override init() {
        super.init()
    }


    func getPushToStartToken() {
        if #available(iOS 17.2, *) {
            Task {
                print("Activity PushToStart started listening...")
                for await data in Activity<LiveActivityAttributes>.pushToStartTokenUpdates {
                    let token = data.map {String(format: "%02x", $0)}.joined()
                    print("Activity PushToStart Token: \(token)")
                }
            }
        }
    }
}

