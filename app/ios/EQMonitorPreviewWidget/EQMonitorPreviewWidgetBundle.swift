//
//  EQMonitorPreviewWidgetBundle.swift
//  EQMonitorPreviewWidget
//

import ActivityKit
import SwiftUI
import WidgetKit

@main
struct EQMonitorPreviewWidgetBundle: WidgetBundle {
    var body: some Widget {
        EarthquakeWidget()
        if #available(iOS 16.1, *) {
            EewLiveActivityWidget()
            ShakeDetectionLiveActivityWidget()
        }
    }
}

// MARK: - Live Activity Previews

private let eewPreviewAttributes = EewLiveActivityAttributes(eventId: "20240101161009")

#Preview(
    "EEW 報の進行 - Lock Screen",
    as: .content,
    using: eewPreviewAttributes
) {
    EewLiveActivityWidget()
} contentStates: {
    for state in EewContentState.warningSequence() {
        state
    }
}

#Preview(
    "EEW 報の進行 - Expanded",
    as: .dynamicIsland(.expanded),
    using: eewPreviewAttributes
) {
    EewLiveActivityWidget()
} contentStates: {
    for state in EewContentState.warningSequence() {
        state
    }
}

#Preview(
    "EEW 報の進行 - Compact",
    as: .dynamicIsland(.compact),
    using: eewPreviewAttributes
) {
    EewLiveActivityWidget()
} contentStates: {
    for state in EewContentState.warningSequence() {
        state
    }
}

#Preview(
    "EEW 報の進行 - Minimal",
    as: .dynamicIsland(.minimal),
    using: eewPreviewAttributes
) {
    EewLiveActivityWidget()
} contentStates: {
    for state in EewContentState.warningSequence() {
        state
    }
}

#Preview(
    "EEW 取消までの進行 - Lock Screen",
    as: .content,
    using: EewLiveActivityAttributes(eventId: "20240102123456")
) {
    EewLiveActivityWidget()
} contentStates: {
    for state in EewContentState.canceledSequence() {
        state
    }
}

#Preview(
    "EEW 取消までの進行 - Expanded",
    as: .dynamicIsland(.expanded),
    using: EewLiveActivityAttributes(eventId: "20240102123456")
) {
    EewLiveActivityWidget()
} contentStates: {
    for state in EewContentState.canceledSequence() {
        state
    }
}
