import Foundation
import Testing

struct WidgetBehaviorTests {
    @Test func itemCountsFitCommonWidgetHeights() {
        #expect(WidgetLayoutPolicy.maxItemCount(layout: .small, availableHeight: 158) == 2)
        #expect(WidgetLayoutPolicy.maxItemCount(layout: .medium, availableHeight: 169) == 2)
        #expect(WidgetLayoutPolicy.maxItemCount(layout: .large, availableHeight: 354) == 5)
    }

    @Test func shortWidgetsStillShowOneItem() {
        #expect(WidgetLayoutPolicy.maxItemCount(layout: .small, availableHeight: 80) == 1)
    }

    @Test func earthquakeDetailURLUsesExistingAppRoute() {
        #expect(
            EarthquakeDetailURL.make(eventId: "202607160001")?.absoluteString
                == "eqmonitor:///earthquake-history-details/202607160001"
        )
    }
}
