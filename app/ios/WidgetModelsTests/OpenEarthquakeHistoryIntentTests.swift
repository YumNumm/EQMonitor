import AppIntents
import Foundation
import Testing

@MainActor
struct OpenEarthquakeHistoryIntentTests {
    @Test func opensHistoryThroughForegroundIntent() async throws {
        var openedURL: URL?
        var intent = OpenEarthquakeHistoryIntent()
        intent.navigation = EarthquakeHistoryNavigation { url in
            openedURL = url
            return true
        }
        _ = try await intent.perform()
        #expect(openedURL?.absoluteString == "eqmonitor:///earthquake-history")
        #expect(intent.target == .earthquakeHistory)
        #expect(OpenEarthquakeHistoryIntent.supportedModes == .foreground)
    }

    @Test func failedNavigationIsNotSuccessfulExecution() async {
        var intent = OpenEarthquakeHistoryIntent()
        intent.navigation = EarthquakeHistoryNavigation { _ in false }
        await #expect(throws: EarthquakeHistoryNavigationError.cannotOpen) {
            try await intent.perform()
        }
    }
}
