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

/// 震度バッジ・見出しの表記。Flutter の JmaIntensity（mainText / suffix）が正。
struct IntensityValueDisplayTests {
    @Test func splitsIntensityIntoMainAndSuffix() {
        #expect(IntensityValue.four.formattedParts == ("4", nil))
        #expect(IntensityValue.fiveLower.formattedParts == ("5", "弱"))
        #expect(IntensityValue.sixUpper.formattedParts == ("6", "強"))
        #expect(IntensityValue.seven.formattedParts == ("7", nil))
    }

    /// 未入電はサブ文字が 3 文字になり正方形バッジに収まらない。
    /// IntensityBadge が幅を伸ばせる実装であることの根拠。
    @Test func noInputIntensityHasLongSuffix() {
        #expect(IntensityValue.fiveLowerNoInput.formattedParts == ("5", "弱以上"))
        #expect(IntensityValue.sixLowerNoInput.formattedParts == ("6", "弱以上"))
    }

    /// 震度速報は震源が未確定かつ未入電になりやすく、この組み合わせが実際に出る。
    @Test func titleTextDropsNoInputWording() {
        #expect(IntensityValue.fiveLowerNoInput.titleText == "5弱以上")
        #expect(IntensityValue.sixLowerNoInput.titleText == "6弱以上")
        #expect(IntensityValue.fiveLower.titleText == "5弱")
        #expect(IntensityValue.seven.titleText == "7")
    }

    @Test func noInputIntensityIsOrderedWithItsLowerBound() {
        #expect(IntensityValue.four < IntensityValue.fiveLowerNoInput)
        #expect(IntensityValue.fiveLowerNoInput < IntensityValue.fiveUpper)
        #expect(IntensityValue.fiveUpper < IntensityValue.sixLowerNoInput)
    }
}
