import Foundation

enum EarthquakeSearchURL {
    static func make(query: String) -> URL? {
        var components = URLComponents()
        components.scheme = "eqmonitor"
        components.host = ""
        components.path = "/earthquake-history/search"
        components.queryItems = [URLQueryItem(name: "query", value: query)]
        // Dart Uri.queryParameters interprets an unescaped plus as a space.
        components.percentEncodedQuery = components.percentEncodedQuery?
            .replacingOccurrences(of: "+", with: "%2B")
        return components.url
    }
}
