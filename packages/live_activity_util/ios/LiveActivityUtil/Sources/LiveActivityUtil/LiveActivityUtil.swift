import ActivityKit
import Foundation

// MARK: - LiveActivityUtil

@available(iOS 16.1, *)
@objcMembers public class EQMLiveActivityUtil: NSObject {
  @available(iOS 17.2, *)
  public static func pushToStartToken() -> String? {
    let data = Activity<MockLiveActivityAttributes>.pushToStartToken
    if let data = data {
      let token = data.map { String(format: "%02x", $0) }.joined()
      return token
    } else {
      return nil
    }
  }
  @available(iOS 17.2, *)
  public static func pushToStartTokenUpdates() -> AsyncStream<String>? {
    return AsyncStream { continuation in
      Task {
        for await tokenData in Activity<MockLiveActivityAttributes>.pushToStartTokenUpdates {
          let token = tokenData.map { String(format: "%02x", $0) }.joined()
          continuation.yield(token)
        }
        continuation.finish()
      }
    }
  }

  public static func isLiveActivitySupported() -> Bool {
    guard #available(iOS 16.1, *), !ProcessInfo.processInfo.isiOSAppOnMac else {
      return false
    }

    guard #available(iOS 26.1, *), !ProcessInfo.processInfo.isiOSAppOnVision else {
      return false
    }
    return true

  }

  public static func isPushToStartSupported() -> Bool {
    if (!isLiveActivitySupported()) {
          return false
      }
    guard #available(iOS 17.2, *), !ProcessInfo.processInfo.isiOSAppOnMac else {
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
