import XCTest

final class SmartStackTests: XCTestCase {
    private let carousel = XCUIApplication(bundleIdentifier: "com.apple.Carousel")

    // デジタルクラウンの回転では Simulator のスマートスタックは開かなかった。文字盤からの上スワイプで開く。
    func testOpenSmartStack() {
        showWatchFace()
        carousel.swipeUp()
        sleep(3)
        let attachment = XCTAttachment(screenshot: XCUIScreen.main.screenshot())
        attachment.name = "smart_stack"
        attachment.lifetime = .keepAlways
        add(attachment)
    }

    private func showWatchFace() {
        for _ in 0..<3 {
            sleep(2)
            let settings = carousel.descendants(matching: .any)
                .matching(NSPredicate(format: "identifier IN %@", ["設定", "Settings"]))
            if settings.firstMatch.exists {
                XCUIDevice.shared.press(.home)
            } else {
                return
            }
        }
    }
}
