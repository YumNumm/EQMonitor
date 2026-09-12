import Foundation

#if os(iOS)
  import ActivityKit
#endif

struct LiveActivityPlatformSupport {
  let osVersion: OperatingSystemVersion
  let isMac: Bool
  let isVision: Bool

  var supportsLocalActivity: Bool {
    guard !isMac, !isVision else { return false }
    return osVersion.majorVersion > 16
      || (osVersion.majorVersion == 16 && osVersion.minorVersion >= 1)
  }

  var supportsPushToStart: Bool {
    supportsLocalActivity && osVersion.majorVersion >= 18
  }
}

// MARK: - LiveActivityUtil

#if os(iOS)
  @available(iOS 16.1, *)
  @objc(EQMLiveActivityUtil)
  @objcMembers public class EQMLiveActivityUtil: NSObject {
    @available(iOS 18.0, *)
    public func pushToStartToken() -> String? {
      guard isPushToStartSupported() else { return nil }
      return Activity<MockLiveActivityAttributes>.pushToStartToken?
        .map { String(format: "%02x", $0) }.joined()
    }

    @available(iOS 18.0, *)
    public func observePushToStartTokenUpdates(
      _ onUpdate: @escaping @Sendable @convention(block) (NSString) -> Void
    ) {
      guard isPushToStartSupported() else { return }
      Task {
        for await tokenData in Activity<MockLiveActivityAttributes>.pushToStartTokenUpdates {
          onUpdate(tokenData.map { String(format: "%02x", $0) }.joined() as NSString)
        }
      }
    }

    public func isLiveActivitySupported() -> Bool {
      platformSupport.supportsLocalActivity
    }

    public func isPushToStartSupported() -> Bool {
      platformSupport.supportsPushToStart
    }

    @nonobjc private var platformSupport: LiveActivityPlatformSupport {
      let processInfo = ProcessInfo.processInfo
      var isVision = false
      if #available(iOS 26.1, *) {
        isVision = processInfo.isiOSAppOnVision
      }
      return LiveActivityPlatformSupport(
        osVersion: processInfo.operatingSystemVersion,
        isMac: processInfo.isiOSAppOnMac,
        isVision: isVision
      )
    }
  }

  // MARK: - MockLiveActivityAttributes
  struct MockLiveActivityAttributes: ActivityAttributes, Identifiable {
    public typealias ContentState = MockLiveActivityContentState

    public var id = UUID()
  }

  struct MockLiveActivityContentState: Codable, Hashable {
  }

#endif
