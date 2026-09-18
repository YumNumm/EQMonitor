import AppIntents
import UIKit

@available(iOS 27.0, *)
@AppIntent(schema: .system.searchInApp)
struct SearchEarthquakesIntent {
    static let title: LocalizedStringResource = "地域名で地震を検索"
    static let description = IntentDescription("地域名で検索し、アプリで地域を選んで地震履歴を表示します。")
    static let supportedModes: IntentModes = .foreground

    var criteria: StringSearchCriteria

    @MainActor
    func perform() async throws -> some IntentResult {
        guard let url = EarthquakeSearchURL.make(query: criteria.term),
              await UIApplication.shared.open(url) else {
            throw EarthquakeSearchError.cannotOpen
        }
        return .result()
    }
}

enum EarthquakeSearchError: Error, CustomLocalizedStringResourceConvertible {
    case cannotOpen

    var localizedStringResource: LocalizedStringResource {
        "検索画面を開けませんでした。EQMonitorを起動して、もう一度お試しください。"
    }
}
