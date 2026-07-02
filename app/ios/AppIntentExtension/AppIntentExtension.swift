//
//  AppIntentExtension.swift
//  AppIntentExtension
//
//  Created by ryotaro.onoue on 2026/07/03.
//

import AppIntents

struct AppIntentExtension: AppIntent {
    static var title: LocalizedStringResource { "AppIntentExtension" }
    
    func perform() async throws -> some IntentResult {
        return .result()
    }
}
