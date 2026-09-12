import ActivityKit
import Foundation

/// Command-line scenarios for the preview app only; no production notification path.
@MainActor
final class LiveActivityPreviewScenario {
    var hasRun = false

    func run(arguments: [String] = ProcessInfo.processInfo.arguments) async {
        guard !hasRun, let index = arguments.firstIndex(of: "--live-activity"),
              arguments.indices.contains(index + 1) else { return }
        hasRun = true
        guard let scenario = Scenario(rawValue: arguments[index + 1]) else {
            try? writeResult(["status": "error", "message": "Unknown preview scenario"])
            return
        }
        do {
            let activities = Activity<EarthquakeLiveActivityAttributes>.activities
            if scenario == .end {
                for activity in activities { await activity.end(nil, dismissalPolicy: .immediate) }
                try writeResult(["status": "ended", "count": String(activities.count)])
                return
            }
            guard let url = Bundle.main.url(forResource: "canonical", withExtension: "json"),
                  var json = try JSONSerialization.jsonObject(with: Data(contentsOf: url)) as? [String: Any] else {
                throw CocoaError(.fileReadCorruptFile)
            }
            json["id"] = "unified-live-activity-preview"
            json["primary"] = switch scenario {
            case .shake, .shakeEnded: "shake_detection"
            case .earthquake, .canceledEarthquake: "earthquake"
            default: "eew"
            }
            if var shake = json["shakeDetection"] as? [String: Any] {
                shake["status"] = scenario == .shakeEnded ? "ended" : "active"
                json["shakeDetection"] = shake
            }
            if var earthquake = json["earthquake"] as? [String: Any] {
                earthquake["isCanceled"] = scenario == .canceledEarthquake
                json["earthquake"] = earthquake
            }
            if var eew = json["eew"] as? [String: Any] {
                eew["isCanceled"] = scenario == .cancel
                eew["isFinal"] = scenario == .eewFinal
                eew["isPlum"] = scenario == .plum
                if scenario == .noLocation {
                    eew["location"] = NSNull()
                } else if var location = eew["location"] as? [String: Any] {
                    location["arrivalTime"] = ISO8601DateFormatter().string(from: Date().addingTimeInterval(90))
                    location["forecastIntensity"] = "3"
                    eew["location"] = location
                }
                json["eew"] = eew
            }
            let state = try JSONDecoder().decode(
                UnifiedLiveActivityContentState.self,
                from: JSONSerialization.data(withJSONObject: json)
            )
            let activity: Activity<EarthquakeLiveActivityAttributes>
            if let existing = activities.first(where: { $0.attributes.id == state.id }) {
                activity = existing
                await activity.update(ActivityContent(state: state, staleDate: nil))
            } else {
                guard let attributes = EarthquakeLiveActivityAttributes(id: state.id) else {
                    throw CocoaError(.fileReadCorruptFile)
                }
                activity = try Activity.request(
                    attributes: attributes, content: ActivityContent(state: state, staleDate: nil), pushType: nil
                )
            }
            try writeResult(["status": "active", "activityId": activity.id, "logicalId": activity.attributes.id, "scenario": scenario.rawValue])
        } catch {
            try? writeResult(["status": "error", "message": error.localizedDescription])
        }
    }

    func writeResult(_ result: [String: String]) throws {
        let directory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        try JSONEncoder().encode(result).write(to: directory.appendingPathComponent("live-activity-preview-result.json"), options: .atomic)
    }
}

private enum Scenario: String {
    case shake, eew, earthquake, cancel, plum, end
    case noLocation = "no-location"
    case shakeEnded = "shake-ended"
    case eewFinal = "eew-final"
    case canceledEarthquake = "earthquake-cancel"
}
