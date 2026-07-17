import ActivityKit
import Foundation

// MARK: - LiveActivityUtil

#if os(iOS)
  @available(iOS 16.1, *)
  @objc(EQMLiveActivityUtil)
  @objcMembers public class EQMLiveActivityUtil: NSObject {
    @available(iOS 18.0, *)
    public func pushToStartToken() -> String? {
      guard #available(iOS 18.0, *), isLiveActivitySupported() else { return nil }
      return Activity<MockLiveActivityAttributes>.pushToStartToken?
        .map { String(format: "%02x", $0) }.joined()
    }

    @available(iOS 18.0, *)
    public func observePushToStartTokenUpdates(
      _ onUpdate: @escaping @Sendable @convention(block) (NSString) -> Void
    ) {
      guard #available(iOS 18.0, *), isLiveActivitySupported() else { return }
      Task {
        for await tokenData in Activity<MockLiveActivityAttributes>.pushToStartTokenUpdates {
          onUpdate(tokenData.map { String(format: "%02x", $0) }.joined() as NSString)
        }
      }
    }

    public func isLiveActivitySupported() -> Bool {
      guard #available(iOS 16.1, *), !ProcessInfo.processInfo.isiOSAppOnMac else {
        return false
      }

      guard #available(iOS 26.1, *), !ProcessInfo.processInfo.isiOSAppOnVision else {
        return false
      }
      return true
    }

    public func isPushToStartSupported() -> Bool {
      if !isLiveActivitySupported() {
        return false
      }
      guard #available(iOS 18.0, *), !ProcessInfo.processInfo.isiOSAppOnMac else {
        return false
      }
      return true
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
