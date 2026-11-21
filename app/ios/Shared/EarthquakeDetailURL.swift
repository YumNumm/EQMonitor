import Foundation

enum EarthquakeDetailURL {
    static func make(eventId: String) -> URL? {
        var components = URLComponents()
        components.scheme = "eqmonitor"
        components.host = ""
        components.path = "/earthquake-history-details/\(eventId)"
        return components.url
    }
}

enum EarthquakeHistoryURL {
    static let list = URL(string: "eqmonitor:///earthquake-history")
}
