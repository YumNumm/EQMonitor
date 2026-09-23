import SwiftUI
import Testing

struct UnifiedLiveActivityRenderTests {
    @Test @MainActor func lockScreenStatesRenderAtCompactWidth() throws {
        for state in UnifiedLiveActivityContentState.designReviewStates() {
            let renderer = ImageRenderer(content: UnifiedLockScreenView(state: state).frame(width: 320))
            let image = try #require(renderer.uiImage)
            #expect(image.size.width == 320)
            #expect(image.size.height > 0)
        }
    }
}
