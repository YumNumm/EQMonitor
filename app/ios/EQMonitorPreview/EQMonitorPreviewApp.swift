//
//  EQMonitorPreviewApp.swift
//  EQMonitorPreview
//
//  Created by Ryotaro Onoue on 2026/08/22.
//

import SwiftUI

@main
struct EQMonitorPreviewApp: App {
    @Environment(\.scenePhase) private var scenePhase
    @State private var scenario = LiveActivityPreviewScenario()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .onChange(of: scenePhase, initial: true) { _, phase in
                    if phase == .active {
                        Task { await scenario.run() }
                    }
                }
        }
    }
}
