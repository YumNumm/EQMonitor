import AppIntents
import Foundation

/// Control CenterはSnippetを表示できないため、アプリ本体で履歴画面を開く。
/// このIntentはRunnerとWidgetExtensionの両方に含める。
@available(iOS 18.0, *)
struct OpenEarthquakeHistoryIntent: OpenIntent {
    static let title: LocalizedStringResource = "地震履歴を開く"
    @available(iOS 26.0, *)
    static let supportedModes: IntentModes = .foreground

    @Parameter(title: "画面", default: .earthquakeHistory)
    var target: EarthquakeHistoryDestination

    @Dependency var navigation: EarthquakeHistoryNavigation

    init() {}

    @MainActor
    func perform() async throws -> some IntentResult {
        try await navigation.open()
        return .result()
    }
}

enum EarthquakeHistoryDestination: String, AppEnum {
    case earthquakeHistory
    static let typeDisplayRepresentation: TypeDisplayRepresentation = "EQMonitorの画面"
    static let caseDisplayRepresentations: [Self: DisplayRepresentation] = [
        .earthquakeHistory: "地震履歴",
    ]
}

/// UIApplicationへのアクセスはRunnerから注入し、Widget側では呼ばない。
struct EarthquakeHistoryNavigation: Sendable {
    let openURL: @MainActor @Sendable (URL) async -> Bool

    @MainActor
    func open() async throws {
        guard let url = URL(string: "eqmonitor:///earthquake-history"),
              await openURL(url) else {
            throw EarthquakeHistoryNavigationError.cannotOpen
        }
    }
}

enum EarthquakeHistoryNavigationError: Error, Equatable, CustomLocalizedStringResourceConvertible {
    case cannotOpen
    var localizedStringResource: LocalizedStringResource {
        "地震履歴を開けませんでした。EQMonitorを起動して、もう一度お試しください。"
    }
}
