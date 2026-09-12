import Foundation

enum EarthquakeDetailURL {
    static func make(eventId: String) -> URL? {
        var components = URLComponents()
        components.scheme = "eqmonitor"
        components.host = ""
        guard !eventId.isEmpty,
              let encodedId = eventId.addingPercentEncoding(withAllowedCharacters:
                .urlPathAllowed.subtracting(CharacterSet(charactersIn: "/%?#"))) else { return nil }
        components.percentEncodedPath = "/earthquake-history-details/\(encodedId)"
        return components.url
    }
}
