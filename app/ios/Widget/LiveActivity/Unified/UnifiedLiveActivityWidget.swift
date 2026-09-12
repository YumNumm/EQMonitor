import ActivityKit
import SwiftUI
import WidgetKit

@available(iOS 16.1, *)
struct EarthquakeLiveActivityWidget: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: EarthquakeLiveActivityAttributes.self) { context in
            UnifiedLiveActivityView(display: UnifiedLiveActivityDisplay(state: context.state))
                .activityBackgroundTint(.black)
                .activitySystemActionForegroundColor(.white)
                .widgetURL(UnifiedLiveActivityDisplay(state: context.state).url)
        } dynamicIsland: { context in
            let display = UnifiedLiveActivityDisplay(state: context.state)
            return DynamicIsland {
                DynamicIslandExpandedRegion(.leading) {
                    UnifiedMaximumBadge(display: display, size: 32)
                        .dynamicIsland(verticalPlacement: .belowIfTooWide)
                }
                DynamicIslandExpandedRegion(.trailing) {
                    UnifiedSourceMetrics(display: display, vertical: true, size: 21)
                        .dynamicIsland(verticalPlacement: .belowIfTooWide)
                }
                DynamicIslandExpandedRegion(.bottom) {
                    VStack(alignment: .leading, spacing: 5) {
                        Text(display.title)
                            .font(AppFonts.flex(size: 10, weight: .medium))
                            .foregroundStyle(.white.opacity(0.8))
                        Text(display.headline)
                            .font(AppFonts.flex(size: 14, weight: .heavy))
                            .fixedSize(horizontal: false, vertical: true)
                        UnifiedLocationDetails(display: display, intensitySize: 44)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 8)
                    .padding(.bottom, 4)
                }
            } compactLeading: {
                UnifiedCompactBadge(display: display, size: 24)
            } compactTrailing: {
                if let range = ArrivalCountdown.remaining(until: display.arrivalDate) {
                    ArrivalCountdownText(remaining: range, size: 14, color: .white)
                } else {
                    Text(display.compactStatus)
                        .font(AppFonts.flex(size: 10, weight: .bold))
                }
            } minimal: {
                UnifiedCompactBadge(display: display, size: 20)
            }
            .keylineTint(display.headerBorderColor)
            .widgetURL(display.url)
        }
    }
}

@available(iOS 16.1, *)
private struct UnifiedCompactBadge: View {
    let display: UnifiedLiveActivityDisplay
    let size: CGFloat

    var body: some View {
        if let intensity = display.localIntensity {
            LiveActivityLocalIntensityView(
                intensity: intensity, size: size,
                accessibilityTitle: display.localIntensityLabel,
                backgroundColor: display.localIntensityBackground
            )
        } else {
            UnifiedMaximumBadge(display: display, size: size)
        }
    }
}
