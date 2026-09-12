import Foundation
import Testing

struct LiveActivityPlatformSupportTests {
    @Test(arguments: [
        (16, 0, false, false),
        (16, 1, true, false),
        (17, 6, true, false),
        (18, 0, true, true),
        (26, 0, true, true),
        (26, 1, true, true),
    ])
    func supportedVersions(major: Int, minor: Int, local: Bool, push: Bool) {
        let support = LiveActivityPlatformSupport(
            osVersion: .init(majorVersion: major, minorVersion: minor, patchVersion: 0),
            isMac: false,
            isVision: false
        )
        #expect(support.supportsLocalActivity == local)
        #expect(support.supportsPushToStart == push)
    }

    @Test(arguments: [(true, false), (false, true), (true, true)])
    func excludedPlatforms(isMac: Bool, isVision: Bool) {
        let support = LiveActivityPlatformSupport(
            osVersion: .init(majorVersion: 26, minorVersion: 1, patchVersion: 0),
            isMac: isMac,
            isVision: isVision
        )
        #expect(!support.supportsLocalActivity)
        #expect(!support.supportsPushToStart)
    }
}
