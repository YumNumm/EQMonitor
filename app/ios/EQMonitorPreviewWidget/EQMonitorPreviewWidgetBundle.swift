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

// EEW は 1 つの Activity を報ごとに更新し続ける。単発の状態だけでは
// 更新時のレイアウト崩れに気付けないため、報の進行を系列で渡す。
// キャンバス下部の State を切り替えると第1報から最終報までを順に確認できる。

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
