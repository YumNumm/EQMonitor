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

// State 1: 現在地が警報対象 / 2: 警報対象外・震度3 / 3: 予報・震度4
// 4: 現在地なし / 5: 到達予想なし / 6: 警報対象・震度なし / 7: 取消
// 8: 深発 / 9: PLUM / 10: 予報・震度3非表示 / 11: 震度1 / 12: 震度2

private let eewPreviewAttributes = EewLiveActivityAttributes(eventId: "20240101161009")

#Preview(
    "EEW デザイン確認 - Lock Screen",
    as: .content,
    using: eewPreviewAttributes
) {
    EewLiveActivityWidget()
} contentStates: {
    for state in EewContentState.designReviewStates() {
        state
    }
}

#Preview(
    "EEW デザイン確認 - Expanded",
    as: .dynamicIsland(.expanded),
    using: eewPreviewAttributes
) {
    EewLiveActivityWidget()
} contentStates: {
    for state in EewContentState.designReviewStates() {
        state
    }
}

#Preview(
    "EEW デザイン確認 - Compact",
    as: .dynamicIsland(.compact),
    using: eewPreviewAttributes
) {
    EewLiveActivityWidget()
} contentStates: {
    for state in EewContentState.designReviewStates() {
        state
    }
}

#Preview(
    "EEW デザイン確認 - Minimal",
    as: .dynamicIsland(.minimal),
    using: eewPreviewAttributes
) {
    EewLiveActivityWidget()
} contentStates: {
    for state in EewContentState.designReviewStates() {
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
