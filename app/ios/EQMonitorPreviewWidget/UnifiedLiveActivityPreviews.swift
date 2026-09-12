import ActivityKit
import Foundation
import SwiftUI
import WidgetKit

private final class UnifiedPreviewBundleMarker {}

private enum UnifiedPreviewData {
    static let states: [UnifiedLiveActivityContentState] = {
        guard let url = Bundle(for: UnifiedPreviewBundleMarker.self)
            .url(forResource: "matrix", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let rows = try? JSONSerialization.jsonObject(with: data) as? [[String: Any]] else {
            preconditionFailure("Unified Live Activity preview fixtures are missing")
        }
        return rows.filter { $0["valid"] as? Bool == true }.map { row in
            guard let raw = row["contentState"],
                  let encoded = try? JSONSerialization.data(withJSONObject: raw),
                  let state = try? JSONDecoder().decode(UnifiedLiveActivityContentState.self, from: encoded) else {
                preconditionFailure("Invalid unified Live Activity preview fixture")
            }
            return state
        }
    }()

    static let attributes: EarthquakeLiveActivityAttributes = {
        guard let state = states.first,
              let attributes = EarthquakeLiveActivityAttributes(id: state.id) else {
            preconditionFailure("Unified Live Activity preview requires an opaque ID")
        }
        return attributes
    }()
}

#Preview("統合 - Lock Screen", as: .content, using: UnifiedPreviewData.attributes) {
    EarthquakeLiveActivityWidget()
} contentStates: {
    for state in UnifiedPreviewData.states { state }
}

#Preview("統合 - Expanded", as: .dynamicIsland(.expanded), using: UnifiedPreviewData.attributes) {
    EarthquakeLiveActivityWidget()
} contentStates: {
    for state in UnifiedPreviewData.states { state }
}

#Preview("統合 - Compact", as: .dynamicIsland(.compact), using: UnifiedPreviewData.attributes) {
    EarthquakeLiveActivityWidget()
} contentStates: {
    for state in UnifiedPreviewData.states { state }
}

#Preview("統合 - Minimal", as: .dynamicIsland(.minimal), using: UnifiedPreviewData.attributes) {
    EarthquakeLiveActivityWidget()
} contentStates: {
    for state in UnifiedPreviewData.states { state }
}
